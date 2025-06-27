#include <Arduino.h>

#define MIC_PIN 2

#define HIGH_THRESHOLD 2400
#define LOW_THRESHOLD 500

#define SAMPLE_INTERVAL 100

// Minimum duration (in ms) of continuous loud sound to detect crying
#define MIN_CRY_DURATION 50

#define QUIET_TIME 3000  // 3000ms of continuous quiet before resetting

unsigned long lastSampleTime = 0;
unsigned long quietStartTime = 0;
unsigned long loudStartTime = 0; // To track the start of a continuous loud period

bool babyCrying = false;

void init_Mic()
{
  pinMode(MIC_PIN, INPUT);
}

int mic_Raw_Value()
{
  return analogRead(MIC_PIN);
}

bool detect_Cry() // This function is currently not called in loop(), but remains for reference
{
  unsigned long currentTime = millis();

  if (currentTime - lastSampleTime >= SAMPLE_INTERVAL)
  {
    lastSampleTime = currentTime;

    int soundLevel = analogRead(MIC_PIN);

    if (soundLevel > HIGH_THRESHOLD || soundLevel < LOW_THRESHOLD)
    {
      // --- LOUD SOUND DETECTED ---
      // If this is the start of a new continuous loud period
      if (loudStartTime == 0)
      {
        loudStartTime = currentTime;
      }
      quietStartTime = 0; // Reset quiet timer as it's loud now

      // If baby is not already crying AND
      // the loud sound has been continuous for MIN_CRY_DURATION
      if (!babyCrying && (currentTime - loudStartTime >= MIN_CRY_DURATION))
      {
        babyCrying = true;
      }
    }
    else
    {
      // --- QUIET SOUND DETECTED ---
      loudStartTime = 0; // Reset loud timer as the continuous loud period is broken

      if (quietStartTime == 0)
      {
        quietStartTime = currentTime;
      }

      // If baby is currently crying AND
      // the quiet sound has been continuous for QUIET_TIME
      if (babyCrying && (currentTime - quietStartTime >= QUIET_TIME))
      {
        babyCrying = false;
        quietStartTime = 0;
      }
    }
  }

  return babyCrying;
}


void setup()
{
  Serial.begin(9600);
  init_Mic();
}


void loop()
{
  // --- CORRECTED FOR SERIAL PLOTTER ---
  Serial.println(mic_Raw_Value()); // Only print the raw number followed by a newline
  // --- END CORRECTION ---

  // If you wanted to see the cry status on the Serial Monitor (not plotter),
  // you would uncomment the line below, but it would prevent plotting if done this way.
  // Serial.print("Cry status: "); Serial.println(detect_Cry());

  // Add a small delay to make the plot smoother and not overwhelm the serial buffer
  delay(5000);
}