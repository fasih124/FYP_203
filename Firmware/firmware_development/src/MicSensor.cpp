#include <Arduino.h>

#define MIC_PIN 2

#define HIGH_THRESHOLD 2500
#define LOW_THRESHOLD 200

#define NUM_AVERAGE_SAMPLES 10

#define SAMPLE_INTERVAL 100 //eval interval to check status
#define MIN_CRY_DURATION 500  //min time to keep crying (less value, more sensitive detection with false positives also)
#define QUIET_TIME 3000 //min time to reset flag to status quiet. (more value, more stable cry flag)

int soundReadings[NUM_AVERAGE_SAMPLES];
int readIndex = 0;
long total = 0;
int average = 0;

unsigned long lastSampleTime = 0;
unsigned long quietStartTime = 0;
unsigned long loudStartTime = 0;

bool babyCrying = false;
int currentRawValue = 0;

void init_Mic()
{
  pinMode(MIC_PIN, INPUT);
  for (int i = 0; i < NUM_AVERAGE_SAMPLES; i++) {
    soundReadings[i] = 0;
  }
}

int mic_Raw_Value()
{
  return analogRead(MIC_PIN);
}

bool processSoundAndDetectCry() {
  unsigned long currentTime = millis();

  currentRawValue = mic_Raw_Value();

  total = total - soundReadings[readIndex];
  soundReadings[readIndex] = currentRawValue;
  total = total + currentRawValue;
  readIndex++;
  if (readIndex >= NUM_AVERAGE_SAMPLES) {
    readIndex = 0;
  }
  average = total / NUM_AVERAGE_SAMPLES;

  if (currentTime - lastSampleTime >= SAMPLE_INTERVAL)
  {
    lastSampleTime = currentTime;

    bool isLoudNow = (currentRawValue > HIGH_THRESHOLD || currentRawValue < LOW_THRESHOLD);

    if (isLoudNow)
    {
      if (loudStartTime == 0) {
        loudStartTime = currentTime;
      }
      quietStartTime = 0;

      if (!babyCrying && (currentTime - loudStartTime >= MIN_CRY_DURATION))
      {
        babyCrying = true;
      }
    }
    else
    {
      loudStartTime = 0;

      if (quietStartTime == 0) {
        quietStartTime = currentTime;
      }

      if (babyCrying && (currentTime - quietStartTime >= QUIET_TIME))
      {
        babyCrying = false;
        quietStartTime = 0;
      }
    }
  }

  return babyCrying;
}