#include "ultrasonic.h" // Include its own header
#include <Arduino.h>    // Ensure Arduino functions are available

#define trigPin 14
#define echoPin 10

#define distanceThreshold 6.0 // in inches
#define soundSpeedInMicroSecond 0.0135

void init_Ultrasonic()
{
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

float get_Distance()
{
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long signalDuration = pulseIn(echoPin, HIGH, 30000);

  // if (signalDuration == 0) {
  //   return -1.0;  //numerical error flag
  // }

  float distance = (signalDuration * soundSpeedInMicroSecond) / 2.0;

  return distance;
}

/* Function now takes the measured distance as a parameter, 
   work on the fetched parameter value and dont call get_distance 
   again and agian, it gives wrong flag */

// From loop, only call baby detection flag, not ultrasonic.
//BabyDetectioon ---> get_Distance and store variable ----> param passed to ultrasonicDetection
bool ultrasonic_Detection_Flag(float currentDistance)
{
  // The logic remains the same, but it uses the provided 'currentDistance'
  if(currentDistance < distanceThreshold)
  {
    return true;
  }
  else
  {
    return false;
  }
}