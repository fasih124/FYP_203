#include <Arduino.h>
#include <IRSensor.h>   // for flag input
#include <WeightSensor.h>   //for flag input

void init_Baby_Detection_Sensors()
{
    //init_IRSensor();
    init_WeightSensor();
}


bool baby_Detection_Flag()
{
    // if both sensors' flags return true, then baby is detected.

    if(/*IR_Detection_Flag() &&*/ weight_Detection_Flag())
    {
        return true;
    }
    else
    {
        return false;
    }

}