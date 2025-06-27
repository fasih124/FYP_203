#include <Arduino.h>

#define HW_Pin 5

int susuThreshold = 1000;   //Greater value, clean environment. Less value, more moist
int sensorValue = 0;


void init_Moisture_Sensor()
{   
    pinMode(HW_Pin, INPUT);
}

String diaper_Condition()
{
    String moist = "Change diaper";
    String clean = "Diaper clean";

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