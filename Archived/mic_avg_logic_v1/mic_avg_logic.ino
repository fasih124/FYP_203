#include <Arduino.h>

#define MIC_PIN 2
// --- LED Pin Definitions ---
#define LED_CRY_PIN 11   // LED to turn on when crying is detected
#define LED_SILENT_PIN 13 // LED to turn on when no crying is detected
// --- End LED Pin Definitions ---

// --- Raw Value Thresholds for defining "LOUD" ---
// A sound is considered 'loud' if its raw reading is either
// above HIGH_THRESHOLD OR below LOW_THRESHOLD.
#define HIGH_THRESHOLD 2400 // Raw value above this is loud
#define LOW_THRESHOLD 300   // Raw value below this is loud
// --- End Raw Value Thresholds ---

// Number of samples to include in the moving average calculation.
// A higher number means more smoothing but slower reaction.
#define NUM_AVERAGE_SAMPLES 10 // Average of the last 10 readings

// --- Hysteresis Durations ---
#define SAMPLE_INTERVAL 100 // How often to re-evaluate the crying state (ms)
#define MIN_CRY_DURATION 500 // Average must be loud for this duration to confirm crying (ms)
#define QUIET_TIME 3000     // Average must be quiet for this duration to confirm no crying (ms)
// --- End Hysteresis Durations ---

// Global variables for the moving average calculation
int soundReadings[NUM_AVERAGE_SAMPLES];
int readIndex = 0;
long total = 0;
int average = 0; // This average is still calculated, but the LOUD/QUIET decision uses raw thresholds.

// Global variables for hysteresis timing
unsigned long lastSampleTime = 0; // When the detection logic was last processed
unsigned long quietStartTime = 0; // When the sound became continuously "not loud"
unsigned long loudStartTime = 0;  // When the sound became continuously "loud"

bool babyCrying = false; // Global flag to indicate if crying is detected
int currentRawValue = 0; // Global to store the latest raw reading for plotting/access

void init_Mic()
{
  pinMode(MIC_PIN, INPUT);
  // --- Initialize LED Pins ---
  pinMode(LED_CRY_PIN, OUTPUT);
  pinMode(LED_SILENT_PIN, OUTPUT);
  // --- End Initialize LED Pins ---
  // Initialize all elements in the soundReadings array to 0
  for (int i = 0; i < NUM_AVERAGE_SAMPLES; i++) {
    soundReadings[i] = 0;
  }
}

int mic_Raw_Value()
{
  return analogRead(MIC_PIN);
}

// This function encapsulates all the sound reading, averaging, and cry detection.
bool processSoundAndDetectCry() {
  unsigned long currentTime = millis(); // Get current time inside the function

  // 1. Read the new raw value from the microphone
  currentRawValue = mic_Raw_Value(); // Store in global for plotting in loop()

  // 2. Update Moving Average (always update, regardless of SAMPLE_INTERVAL)
  // This moving average is still useful for smoothing the plotted data,
  // even if the LOUD/QUIET decision uses raw thresholds now.
  total = total - soundReadings[readIndex];
  soundReadings[readIndex] = currentRawValue;
  total = total + currentRawValue;
  readIndex++;
  if (readIndex >= NUM_AVERAGE_SAMPLES) {
    readIndex = 0;
  }
  average = total / NUM_AVERAGE_SAMPLES; // Average calculated but not directly used for LOUD/QUIET decision anymore

  // --- CRY DETECTION LOGIC (with Hysteresis based on Raw Thresholds) ---
  // This logic only updates the babyCrying flag at SAMPLE_INTERVAL frequency
  if (currentTime - lastSampleTime >= SAMPLE_INTERVAL)
  {
    lastSampleTime = currentTime; // Mark the time of this state evaluation

    // Determine if the current raw sound level is "LOUD"
    // based on both HIGH_THRESHOLD and LOW_THRESHOLD.
    bool isLoudNow = (currentRawValue > HIGH_THRESHOLD || currentRawValue < LOW_THRESHOLD);

    if (isLoudNow)
    {
      // --- RAW SOUND IS LOUD ---
      if (loudStartTime == 0) { // If this is the start of a new continuous loud period
        loudStartTime = currentTime;
      }
      quietStartTime = 0; // Reset quiet timer as it's loud now

      // If baby is not already crying AND the raw sound has been loud for MIN_CRY_DURATION
      if (!babyCrying && (currentTime - loudStartTime >= MIN_CRY_DURATION))
      {
        babyCrying = true; // Confirm crying
      }
    }
    else
    {
      // --- RAW SOUND IS QUIET / NOT LOUD ENOUGH ---
      loudStartTime = 0; // Reset loud timer as the continuous loud period is broken

      if (quietStartTime == 0) { // If this is the start of a new continuous quiet period
        quietStartTime = currentTime;
      }

      // If baby is currently crying AND the raw sound has been quiet for QUIET_TIME
      if (babyCrying && (currentTime - quietStartTime >= QUIET_TIME))
      {
        babyCrying = false; // Confirm not crying
        quietStartTime = 0; // Reset quiet timer for next quiet period
      }
    }
  }

  return babyCrying; // Return the current crying state
}


void setup()
{
  Serial.begin(9600);
  init_Mic();
}


void loop()
{
  // --- Call the function to do all the work ---
  bool cryStatus = processSoundAndDetectCry(); // This updates the global babyCrying flag

  // --- SERIAL PLOTTER OUTPUT ---
  // Plot the current raw value, the calculated average, and the crying status (0 or 1).
  // The Serial Plotter will show three lines.
  Serial.print(currentRawValue); // Raw signal
  Serial.print(" ");
  Serial.print(average);         // Smoothed signal (moving average)
  Serial.print(" ");
  Serial.println(cryStatus ? 1 : 0); // Binary cry status (0 or 1)

  // --- LED Control Logic ---
  if (babyCrying) { // Use the global babyCrying flag updated by processSoundAndDetectCry()
    digitalWrite(LED_CRY_PIN, HIGH);   // Turn on the cry LED
    digitalWrite(LED_SILENT_PIN, LOW);  // Turn off the silent LED
  } else {
    digitalWrite(LED_CRY_PIN, LOW);    // Turn off the cry LED
    digitalWrite(LED_SILENT_PIN, HIGH); // Turn on the silent LED
  }
  // --- End LED Control Logic ---

  // --- EXAMPLE FOR SENDING TO FIREBASE ---
  // You can now send 'currentRawValue', 'average', and 'cryStatus' (which is babyCrying)
  // to Firebase from here, every time loop() runs, or based on a separate timer if desired.
  // Example: YourFirebaseSendFunction(currentRawValue, cryStatus, average);

  delay(50); // Paces the loop. Adjust this for plotting smoothness vs responsiveness.
}