#ifndef TOGGLE_DIAPER_H
#define TOGGLE_DIAPER_H

#include <Arduino.h>

#define T1_PIN T1
#define DIAPER_LED_PIN 11
#define DIAPER_CHANGE_THRESHOLD 20000

extern int diaperRawValue;
extern int diaperBaselineValue;
extern bool diaperFlag;
extern bool diaperLastState;

void init_Toggle_Diaper();
int read_Diaper_Raw_Value();
String process_Diaper();
void turn_Off_Diaper_LED();

#endif