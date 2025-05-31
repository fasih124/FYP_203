// MicSensor.h

#ifndef MIC_SENSOR_H
#define MIC_SENSOR_H

#include <Arduino.h>        // Required for Arduino types like bool, int, unsigned long, millis()
#include "BabyDetection.h"  // Include for baby_Detection_Flag()

// Define constants (these don't need 'extern' as #define is a preprocessor directive)
#define MIC_PIN 2
#define CRY_THRESHOLD 2000
#define NUM_AVERAGE_SAMPLES 10
#define MIN_CRY_DURATION 1000
#define QUIET_TIME 3000

// Declare global variables as 'extern'
// This tells other files that these variables are defined in MicSensor.cpp
extern int soundReadings[NUM_AVERAGE_SAMPLES];
extern int readIndex;
extern long total;
extern int average;

extern unsigned long loudStartTime;
extern unsigned long quietStartTime;

extern bool babyCrying;
extern int currentRawValue;

// Declare function prototypes
// These functions are implemented in MicSensor.cpp
void init_Mic();
int mic_Raw_Value();
int mic_Smoothed_Value();
bool process_Sound_And_Detect_Cry();

#endif // MIC_SENSOR_H