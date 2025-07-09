#ifndef TOUCH_CRY_MODULE_H
#define TOUCH_CRY_MODULE_H

#include <Arduino.h>

#define T4_PIN T4
#define LED_PIN 13
#define CHANGE_THRESHOLD 30000

extern int touchRawValue;
extern int baselineTouchValue;
extern bool cryFlag;
extern bool lastTouchState;

void init_Toggle_Cry();
int read_Cry_Raw_Value();
bool process_Cry();
void turn_Off_Cry_LED();

#endif