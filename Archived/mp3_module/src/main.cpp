#include <Arduino.h>

#include "file1.h"
#include "file2.h"
#include "dfplayer.h"

void setup()
{
  Serial.begin(115200); // Initialize Serial Monitor
  delay(500);
  Serial.println("Initializing DFPlayer...");
  Init_Dfplayer();
  
}

void loop()
{
  file1();
  delay(5000);

  file2();
  delay(5000);

}