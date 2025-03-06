#ifndef AQISENSOR_H //if not already defined in main,
#define AQISENSOR_H //then define, otherwise ignore

#include <Arduino.h>

void init_AQI_sensor();
int read_AQI_Voltage();
String AQI_grade();


#endif  //end statement for ifndef