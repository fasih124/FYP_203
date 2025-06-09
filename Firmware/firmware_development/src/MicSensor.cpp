// MicSensor.cpp

#define MIC_PIN 2

#include <Arduino.h>
#include "MicSensor.h"      // Include its own header
#include "BabyDetection.h"  // Assuming this provides baby_Detection_Flag()

// Global variables (defined here, declared in MicSensor.h)
unsigned long loudStartTime = 0;
unsigned long quietStartTime = 0;

bool babyCrying = false;
int currentRawValue = 0; // Stores the immediate analogRead() value


void init_Mic()
{
  pinMode(MIC_PIN, INPUT);
  // No moving average array to initialize
}

int mic_Raw_Value()
{
  return analogRead(MIC_PIN);
}

// Signal processing and crying detection logic (simplified)
bool process_Sound_And_Detect_Cry()
{
  unsigned long currentTime = millis(); // Get current time for timing logic

  // --- 1. Read Raw Sound Value ---
  currentRawValue = mic_Raw_Value(); // Read the raw sensor value directly

  //if there's no baby in the craddle, no need for signal processing
  if (!baby_Detection_Flag() /* && !true */) // Remove '&& !true' for production code
  {
    babyCrying = false;
    loudStartTime = 0;
    quietStartTime = 0;
    // No moving average states to reset here
    return babyCrying;
  }
  else  //if baby is detected, then go to signal processing
  {

  // The RAW_LOW_THRESHOLD might catch mic disconnects or very unique sounds.
  bool isLoudNow = (currentRawValue > RAW_HIGH_THRESHOLD || currentRawValue < RAW_LOW_THRESHOLD);


  // --- 4. State Machine for Crying Detection ---
  if (isLoudNow) // If the current raw sound level is "loud"
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
      Serial.println("!!!! BABY CRYING DETECTED (RAW) !!!!"); // For debugging
    }
  }
  else // If the current raw sound level is NOT "loud" (i.e., it's "quiet")
  {
    loudStartTime = 0; // Reset the loud timer, as it's currently quiet

    if (quietStartTime == 0) // If this is the beginning of a new quiet period
    {
      quietStartTime = currentTime; // Record the start time of this quiet period
    }

    // If baby IS currently flagged as crying, AND the quiet period has lasted long enough
    if (babyCrying && (currentTime - quietStartTime >= QUIET_TIME))
    {
      babyCrying = false; // Reset crying status
      quietStartTime = 0; // Reset quiet timer
      Serial.println("---- Baby stopped crying (RAW) ----"); // For debugging
    }
  }


  return babyCrying; // Return the current status of the babyCrying flag
  }

}