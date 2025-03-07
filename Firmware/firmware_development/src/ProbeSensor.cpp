#include <Arduino.h>
#include <OneWire.h>
#include <DallasTemperature.h>

#define Probe_Pin 6

//Object of use
OneWire oneWire(Probe_Pin);
DallasTemperature sensor(&oneWire);

float celcius = 0;
float fahrenheit = 0;

void init_Probe_Sensor()
{
    sensor.begin(); 

}

float temp_In_Fahrenheit()
{
    sensor.requestTemperatures();   //fetch temperature info

    celcius = sensor.getTempCByIndex(0);    //index 0 for first sensor (can handle multiple temp sensors)
    fahrenheit = sensor.toFahrenheit(celcius);

    return fahrenheit;

}