#include <Arduino.h>

#ifndef ULTRASONIC_H
#define ULTRASONIC_H

void init_Ultrasonic();
float get_Distance();
bool ultrasonic_Detection_Flag(float currentDistance); // Function signature updated

#endif