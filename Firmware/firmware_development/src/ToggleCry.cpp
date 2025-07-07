#include "ToggleCry.h"

int touchRawValue = 0;
int baselineTouchValue = 0;
bool cryFlag = false;
bool lastTouchState = false;

void init_Toggle_Cry() {
  pinMode(LED_PIN, OUTPUT);
  delay(50);
  baselineTouchValue = touchRead(T4_PIN);
}

int read_Cry_Raw_Value() {
  return touchRead(T4_PIN);
}

bool process_Cry() {
  touchRawValue = read_Cry_Raw_Value();
  int difference = abs(touchRawValue - baselineTouchValue);

  bool currentTouchState = (difference > CHANGE_THRESHOLD);

  if (currentTouchState && !lastTouchState) {
    cryFlag = !cryFlag;
    if (cryFlag) {
      digitalWrite(LED_PIN, HIGH);
    } else {
      digitalWrite(LED_PIN, LOW);
    }
  } else if (!currentTouchState) {
    baselineTouchValue = touchRawValue;
  }
  lastTouchState = currentTouchState;
  return cryFlag;
}

// New function to turn off LED
void turn_Off_Cry_LED() 
{
  digitalWrite(LED_PIN, LOW); // Turn LED LOW
  cryFlag = false; // Set flag to OFF
}