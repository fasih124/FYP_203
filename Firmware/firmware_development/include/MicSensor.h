// MicSensor.h

#ifndef MIC_SENSOR_H
#define MIC_SENSOR_H

#include <Arduino.h>        // Required for Arduino types like bool, int, unsigned long
#include "BabyDetection.h"  // Include for baby_Detection_Flag()

// --- ADJUST THESE THRESHOLDS ---
// Based on your observation: 50-250 in silence.
// A crying sound should be significantly OUTSIDE this range.
// You MUST fine-tune these values during testing.
#define RAW_HIGH_THRESHOLD 350 // Example: Raw reading above this is "loud" (a cry)
#define RAW_LOW_THRESHOLD  30 // Example: Raw reading below this is "loud" (e.g., mic disconnect, or very specific sound)

#define MIN_CRY_DURATION 150  // Minimum time (ms) raw sound must be continuously "loud" to be a cry
#define QUIET_TIME 3000       // Minimum time (ms) raw sound must be "quiet" to reset cry flag

// Declare global variables as 'extern'
// (Removed moving average specific variables)
extern unsigned long loudStartTime;
extern unsigned long quietStartTime;

extern bool babyCrying;
extern int currentRawValue; // Still useful for debugging the raw value

// Declare function prototypes
void init_Mic();
int mic_Raw_Value(); // Only raw value is relevant now
bool process_Sound_And_Detect_Cry();

#endif // MIC_SENSOR_H