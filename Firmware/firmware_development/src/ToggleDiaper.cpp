#include "ToggleDiaper.h"

int diaperRawValue = 0;
int diaperBaselineValue = 0;
bool diaperFlag = false;
bool diaperLastState = false;

void init_Toggle_Diaper() {
  pinMode(DIAPER_LED_PIN, OUTPUT);
  diaperBaselineValue = touchRead(T1_PIN);
}

int read_Diaper_Raw_Value() {
  return touchRead(T1_PIN);
}

String process_Diaper() {
  diaperRawValue = read_Diaper_Raw_Value();
  int difference = abs(diaperRawValue - diaperBaselineValue);

  bool currentTcState = (difference > DIAPER_CHANGE_THRESHOLD);

  if (currentTcState && !diaperLastState) {
    diaperFlag = !diaperFlag;
    if (diaperFlag) {
      digitalWrite(DIAPER_LED_PIN, HIGH);
    } else {
      digitalWrite(DIAPER_LED_PIN, LOW);
    }
  } else if (!currentTcState) {
    diaperBaselineValue = diaperRawValue;
  }
  diaperLastState = currentTcState;

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