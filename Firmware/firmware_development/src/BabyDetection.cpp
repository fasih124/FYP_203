#include <Arduino.h>
#include <IRSensor.h>
//#include <WeightSensor.h>

void init_Sensors()
{
    init_IRSensor();
    //init_weightSensor();
}


bool BabyDetectionFlag()
{
    // if both sensors' flags return true, then baby is detected.
    if(IRDetectionFlag() /*&& WeightDetectionFlag()*/)
    {
        return true;
    }
    else
    {
        false;
    }

}