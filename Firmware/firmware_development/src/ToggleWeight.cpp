#include "ToggleWeight.h"

int weightRawValue = 0;
int weightBaselineValue = 0;
bool weightFlag = false;
bool weightLastState = false;

void init_Toggle_Weight() {
  pinMode(WEIGHT_LED_PIN, OUTPUT);
  weightBaselineValue = touchRead(WEIGHT_PIN);
}

int read_Weight_Raw_Value() {
  return touchRead(WEIGHT_PIN);
}

bool process_Weight() {
  weightRawValue = read_Weight_Raw_Value();
  int difference = abs(weightRawValue - weightBaselineValue);

  bool currentSensorState = (difference > WEIGHT_CHANGE_THRESHOLD);

  if (currentSensorState && !weightLastState) {
    weightFlag = !weightFlag;
    if (weightFlag) {
      digitalWrite(WEIGHT_LED_PIN, HIGH);
    } else {
      digitalWrite(WEIGHT_LED_PIN, LOW);
    }
  } else if (!currentSensorState) 
  {
    weightBaselineValue = weightRawValue;
  }
  weightLastState = currentSensorState;
 
  return weightFlag;
}

bool process_Weight_OK() {

  weightFlag = true;
   if (weightFlag) {
      digitalWrite(WEIGHT_LED_PIN, HIGH);
    } else {
      digitalWrite(WEIGHT_LED_PIN, LOW);
    }
 
  return weightFlag;
}


void turn_Off_Weight_LED() 
{
  digitalWrite(WEIGHT_LED_PIN, LOW);
  weightFlag = false;
}