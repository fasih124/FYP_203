#include <Arduino.h>

#define MIC_PIN 2
#define THRESHOLD 2500
#define DURATION_MS 5000
#define SAMPLE_INTERVAL 10
#define MIN_LOUD_COUNT 7

unsigned long monitoringStart = 0;
unsigned long lastSampleTime = 0;
int loudCount = 0;
bool monitoring = false;
unsigned long postCheckDelay = 5000;
unsigned long postCheckStart = 0;
bool inPostDelay = false;

bool babyCrying = false;  // can be used externally if needed

void init_Mic() {
  pinMode(MIC_PIN, INPUT);
}

int mic_Raw_Value() {
  return analogRead(MIC_PIN);
}

bool detect_Cry() 
{
  unsigned long currentTime = millis();

  if (!monitoring && !inPostDelay) {
    monitoringStart = currentTime;
    lastSampleTime = currentTime;
    loudCount = 0;
    monitoring = true;
  }

  if (monitoring && (currentTime - lastSampleTime >= SAMPLE_INTERVAL)) 
  {
    lastSampleTime = currentTime;
    int soundLevel = analogRead(MIC_PIN);
    if (soundLevel > THRESHOLD) {
      loudCount++;
    }
  }

  if (monitoring && (currentTime - monitoringStart >= DURATION_MS)) 
  {
    monitoring = false;
    inPostDelay = true;
    postCheckStart = currentTime;

    if (loudCount >= MIN_LOUD_COUNT) 
    {
      babyCrying = true;
      return true;
    } else {
      babyCrying = false;
      return false;
    }
  }

  if (inPostDelay && (currentTime - postCheckStart >= postCheckDelay)) {
    inPostDelay = false;
  }

  return false;  // Default return if no decision made yet

} //func ends
