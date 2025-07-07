#include "ToggleDiaper.h"

int diaperTouchRawValue = 0;
int diaperBaselineTouchValue = 0;
bool diaperFlag = false;
bool diaperLastTouchState = false;

void init_Toggle_Diaper() {
  pinMode(DIAPER_LED_PIN, OUTPUT);
  diaperBaselineTouchValue = touchRead(T1_PIN);
}

int read_Diaper_Raw_Value() {
  return touchRead(T1_PIN);
}

String process_Diaper() {
  diaperTouchRawValue = read_Diaper_Raw_Value();
  int difference = abs(diaperTouchRawValue - diaperBaselineTouchValue);

  bool currentTouchState = (difference > DIAPER_CHANGE_THRESHOLD);

  if (currentTouchState && !diaperLastTouchState) {
    diaperFlag = !diaperFlag;
    if (diaperFlag) {
      digitalWrite(DIAPER_LED_PIN, HIGH);
    } else {
      digitalWrite(DIAPER_LED_PIN, LOW);
    }
  } else if (!currentTouchState) {
    diaperBaselineTouchValue = diaperTouchRawValue;
  }
  diaperLastTouchState = currentTouchState;

  if (diaperFlag) {
    return "Change Diaper";
  } else {
    return "Diaper Clean";
  }
}

void turn_Off_Diaper_LED() {
  digitalWrite(DIAPER_LED_PIN, LOW);
  diaperFlag = false;
}