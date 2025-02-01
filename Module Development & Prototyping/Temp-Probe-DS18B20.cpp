#include <Arduino.h>

//lbrary for one wire sensors
#include <OneWire.h>  
//library for temp sensor
#include <DallasTemperature.h>  

//connection to GPIO
#define ONE_WIRE_BUS 10 

//Objects of use
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensor(&oneWire);

//variable values
float celcius = 0;
float fahrenheit = 0;


void setup() 
{
  sensor.begin(); //Initializes the sensor

  Serial.begin(115200);
  Serial.println("Serial comm & sensor initialized!");

}

void loop() 
{
  sensor.requestTemperatures();  //fetching temperature

  celcius = sensor.getTempCByIndex(0); //temp in C
  fahrenheit = sensor.toFahrenheit(celcius); //conversion to F by input of C

  Serial.print(celcius);
  Serial.print(" C ");
  Serial.print(" ---- ");
  Serial.print(fahrenheit);
  Serial.println(" F ");


  delay(1000);
}

