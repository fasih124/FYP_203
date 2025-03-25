//This file is not directly participating in main code.
//It's being used by BabyDetection file.

#include <HX711.h>  //external library by bogde

#define DT_PIN 4   // DT Pin (Don't change or else error in reading)
#define SCK_PIN 7  // SCK Pin (Don't change or else error in reading)

HX711 scale;

float scaleFactor = 101.0;   //ADC to kg calibration
int weightThreshold = 200; //Set to 300kg (because sensor is not calibrated for actual weight, this will detect change effectively anyways)

void init_WeightSensor()
{
    scale.begin(DT_PIN, SCK_PIN);
    scale.set_scale();
    scale.tare();   //sets baseline value

}


int measure_WeightChange()
{
    int weight = 0;
    if(scale.is_ready())    //if hx711 is working fine
    {
        weight = scale.get_units(10)/1000; // Takes average of 10 readings (g) and converts that in kg   
        delay(200); //for stability in readings

    }
     //for stability in readings
    return weight;
}


bool weight_Detection_Flag()
{
    return measure_WeightChange() > weightThreshold;  //checks the condition and returns true or false
}