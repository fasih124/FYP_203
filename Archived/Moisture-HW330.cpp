#include <Arduino.h>

#define HW_Pin 5

int susuThreshold = 1500;
int sensorValue;

void setup()
{
  Serial.begin(9600);
  pinMode(HW_Pin, INPUT); // HW-330 Analog output to GPIO34
}

void loop()
{
  sensorValue = analogRead(HW_Pin); // Read moisture level

  if (sensorValue < susuThreshold)
  {
    Serial.println("Diaper change kr saly!");
  }
  else
  {
    Serial.println("Abi wait kr");
  } 

  delay(1000); // Wait 1 second before next reading
}
 
