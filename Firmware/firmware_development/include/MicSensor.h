// #ifndef MIC_SENSOR_H
// #define MIC_SENSOR_H

// void init_Mic();
// int mic_Raw_Value();
// bool processSoundAndDetectCry();

// #endif


//-----------------------------------------

#ifndef BABY_CRY_DETECTOR_H
#define BABY_CRY_DETECTOR_H

#include <Arduino.h>

// ... (other #defines like MIC_PIN, THRESHOLDS, etc.) ...

#define HIGH_THRESHOLD 2400
#define LOW_THRESHOLD 300
#define NUM_AVERAGE_SAMPLES 10
#define SAMPLE_INTERVAL 100
#define MIN_CRY_DURATION 500
#define QUIET_TIME 3000

// --- EXTERN DECLARATIONS FOR GLOBAL VARIABLES ---
extern int soundReadings[NUM_AVERAGE_SAMPLES];
extern int readIndex;
extern long total;
extern int average; // <-- THIS IS KEY for 'average'

extern unsigned long lastSampleTime;
extern unsigned long quietStartTime;
extern unsigned long loudStartTime;

extern bool babyCrying;    // <-- THIS IS KEY for 'babyCrying'
extern int currentRawValue; // <-- THIS IS KEY for 'currentRawValue'
// --- END EXTERN DECLARATIONS ---

// Function declarations
void init_Mic();
int mic_Raw_Value();
bool processSoundAndDetectCry();

#endif // BABY_CRY_DETECTOR_H