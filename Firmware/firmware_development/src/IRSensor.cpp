//This file is not directly participating in main code.
//It's being used by BabyDetection file.

#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_MLX90614.h>

//object for mlx sensor
Adafruit_MLX90614 mlx = Adafruit_MLX90614();


float IRTempThreshold = 81;


//Initializing sensor
void init_IRSensor()
{
    Wire.begin(9, 8); //SDA, SCL

    while(!mlx.begin())
    {
        Serial.println("Error connecting to IR Sensor");
    }
}


//Getting average of temp for more accurate reading
float get_Average_IRTemp()
{
    float sum = 0;
    float readings = 10;    //number of readings to get the average

    
    for(int i=0; i<readings; i++)
    {
    sum += mlx.readObjectTempF();   //add temp in F to sum
    delay(10);
    }

    return sum/readings;
}


bool IR_Detection_Flag()
{
    return get_Average_IRTemp() > IRTempThreshold;  //checks the condition and returns true or false
}


