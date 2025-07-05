#include <Arduino.h>
//#include <IRSensor.h>   // for flag input
#include <WeightSensor.h>   //for flag input
#include <ultrasonic.h> //for flag input



void init_Baby_Detection_Sensors()
{
   
    init_WeightSensor();
    init_Ultrasonic();

}


bool baby_Detection_Flag()
{
    float currentDistance = get_Distance();

    if(ultrasonic_Detection_Flag(currentDistance) /*&&  weight_Detection_Flag()*/)
    {
        return true;
    }
    else
    {
        return false;
    }

}