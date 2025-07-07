#ifndef TOGGLE_WEIGHT_H
#define TOGGLE_WEIGHT_H

#include <Arduino.h>

#define WEIGHT_PIN T7
#define WEIGHT_LED_PIN 12
#define WEIGHT_CHANGE_THRESHOLD 20000

extern int weightRawValue;
extern int weightBaselineValue;
extern bool weightFlag;
extern bool weightLastState;

void init_Toggle_Weight();
int read_Weight_Raw_Value();
bool process_Weight();
bool process_Weight_OK();
void turn_Off_Weight_LED();

#endif