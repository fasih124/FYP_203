#include <Arduino.h>
#include <WeightSensor.h>   //for weight value input
#include <ToggleWeight.h>   //for weight flag
#include <ultrasonic.h> //for flag input



void init_Baby_Detection_Sensors()
{
   
    init_WeightSensor();
    init_Toggle_Weight();
    init_Ultrasonic();

}


bool baby_Detection_Flag()
{
    float currentDistance = get_Distance();

    if(ultrasonic_Detection_Flag(currentDistance) &&  process_Weight_OK())
    {
        return true;
    }
    else
    {
        return false;
    }

}