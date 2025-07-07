#include <Arduino.h>

#define HW_Pin 15

int susuThreshold = 5; // Greater value, clean environment. Less value, more moist
int sensorValue = 0;

void init_Moisture_Sensor()
{
   pinMode(HW_Pin, INPUT);
}

String diaper_Condition()
{
   String moist = "Change Diaper";
   String clean = "Diaper Clean";

   sensorValue = analogRead(HW_Pin);

   if (sensorValue < susuThreshold)
   {
      return moist;
   }

   else
   {
      return clean;
   }
}