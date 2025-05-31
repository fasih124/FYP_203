// #include <Arduino.h>
// #include "BabyDetection.h"  // Assuming this provides baby_Detection_Flag()

#define MIC_PIN 2

// --- ADJUST THESE THRESHOLDS ---
// Based on your observation of 50-250 in silence:
// Anything significantly *above* 250 would indicate a sound.
// A typical cry would likely push it much higher than 250.
#define CRY_THRESHOLD 200 // Example: Any smoothed reading above 400 is considered "loud"
                          // You MUST fine-tune this value by testing with actual cries.
                          // Start with something like 300, 400, or 500 and adjust.

// If you want to detect extreme silence/mic disconnect (values below 50)
// #define EXTREME_SILENCE_THRESHOLD 30 // Example: Any smoothed reading below 30 could be an issue or a very specific sound.
                                       // For crying detection, this might not be strictly necessary.

#define NUM_AVERAGE_SAMPLES 10 // Number of samples for the moving average. Good for smoothing noise.

#define MIN_CRY_DURATION 300  // Minimum time (in milliseconds) a sound must be continuously "loud" to be classified as a cry.
                              // Shorter value = more sensitive, more false positives.
#define QUIET_TIME 3000       // Minimum time (in milliseconds) the sound must be "quiet" to reset the babyCrying flag.
                              // Longer value = cry flag stays true for longer after sound stops.

// Global variables for MicSensor module (as defined in your original code)
int soundReadings[NUM_AVERAGE_SAMPLES];
int readIndex = 0;
long total = 0;
int average = 0; // The smoothed value, crucial for stable detection

unsigned long loudStartTime = 0;  // Timestamp when the "loud" period began
unsigned long quietStartTime = 0; // Timestamp when the "quiet" period began

bool babyCrying = false;
int currentRawValue = 0; // Stores the immediate analogRead() value

void init_Mic()
{
  pinMode(MIC_PIN, INPUT);
  // Initialize the moving average buffer
  for (int i = 0; i < NUM_AVERAGE_SAMPLES; i++)
  {
    soundReadings[i] = 0;
  }
}

// Function to get the current raw analog value (for debugging)
int mic_Raw_Value()
{
  return analogRead(MIC_PIN);
}

// Function to get the current smoothed average value (for debugging and main logic)
int mic_Smoothed_Value()
{
  return average;
}


// Signal processing and crying detection logic
bool processSoundAndDetectCry()
{
  unsigned long currentTime = millis(); // Get current time for all timing checks

  // --- 1. Continuous Sound Sampling and Moving Average Update ---
  // This block runs every time processSoundAndDetectCry() is called,
  // making it highly responsive.
  currentRawValue = mic_Raw_Value(); // Read the raw sensor value

  // Update the moving average (rolling average)
  total = total - soundReadings[readIndex];       // Subtract the oldest sample
  soundReadings[readIndex] = currentRawValue;     // Add the new raw sample
  total = total + currentRawValue;                // Update the running total
  readIndex++;                                    // Move to the next slot in the buffer
  if (readIndex >= NUM_AVERAGE_SAMPLES)           // Wrap around if end of buffer
  {
    readIndex = 0;
  }
  average = total / NUM_AVERAGE_SAMPLES;          // Calculate the new smoothed average

  // --- 2. Optional: Baby Presence Check (from BabyDetection module) ---
  // If baby_Detection_Flag() returns false, reset states and indicate no crying.
  // Use 'true' for debugging if BabyDetection module is not fully integrated/working.
  // if (!baby_Detection_Flag() /* && !true */) // Remove '&& !true' for production
  // {
  //   babyCrying = false;
  //   loudStartTime = 0;
  //   quietStartTime = 0;
  //   // Optionally reset sound readings buffer if baby is removed for a long time
  //   // for (int i = 0; i < NUM_AVERAGE_SAMPLES; i++) { soundReadings[i] = 0; }
  //   // total = 0; average = 0; currentRawValue = 0;
  //   return false;
  // }

  // --- 3. Determine "Loudness" based on Smoothed Average and Thresholds ---
  // We're looking for sounds above our defined CRY_THRESHOLD.
  // If you also want to detect very low sounds (e.g., mic unplugged/broken),
  // you can add '|| average < EXTREME_SILENCE_THRESHOLD' here.
  bool isLoudNow = (average > CRY_THRESHOLD);

  // --- 4. State Machine for Crying Detection ---
  if (isLoudNow) // If the current smoothed sound level is "loud"
  {
    if (loudStartTime == 0) // If this is the beginning of a new loud period
    {
      loudStartTime = currentTime; // Record the start time of this loud period
    }
    quietStartTime = 0; // Reset the quiet timer, as it's currently loud

    // If baby is NOT currently flagged as crying, AND the loud period has lasted long enough
    if (!babyCrying && (currentTime - loudStartTime >= MIN_CRY_DURATION))
    {
      babyCrying = true; // Set the babyCrying flag to true
      // Serial.println("!!!! BABY CRYING DETECTED !!!!"); // For debugging
    }
  }
  else // If the current smoothed sound level is NOT "loud" (i.e., it's "quiet")
  {
    loudStartTime = 0; // Reset the loud timer, as it's currently quiet

    if (quietStartTime == 0) // If this is the beginning of a new quiet period
    {
      quietStartTime = currentTime; // Record the start time of this quiet period
    }

    // If baby IS currently flagged as crying, AND the quiet period has lasted long enough
    if (babyCrying && (currentTime - quietStartTime >= QUIET_TIME))
    {
      babyCrying = false; // Set the babyCrying flag to false
      quietStartTime = 0; // Reset the quiet timer
      // Serial.println("---- Baby stopped crying ----"); // For debugging
    }
  }

  return babyCrying; // Return the current status of the babyCrying flag
}



void setup()
{
  Serial.begin(9600);
  init_Mic();
}



void loop()
{
  Serial.print(mic_Raw_Value()); Serial.print("-----------"); Serial.print(mic_Smoothed_Value());
  Serial.println();
  Serial.print("Cry Status: "); Serial.println(processSoundAndDetectCry());
  delay(2000);
}