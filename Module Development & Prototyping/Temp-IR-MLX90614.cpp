 //https://github.com/adafruit/Adafruit-MLX90614-Library

// ESP32-S3 supports software-defined I2C pins, meaning you can use almost any GPIO for SCL and SDA by defining them in your code.
// SCL (Clock Line) → GPIO 9
// SDA (Data Line) → GPIO 8


#include<Adafruit_MLX90614.h>

Adafruit_MLX90614 mlx = Adafruit_MLX90614();



void setup() 
{

  Serial.begin(115200);
  while(!Serial); //continue checking untill connection is established.

  if (!mlx.begin())
  {
    Serial.println("Error connecting!");
    while(1); //keep the program stuck unless connection is established.
  }



}

void loop() 
{
  Serial.print("Ambient C: ");  Serial.print(mlx.readAmbientTempC()); Serial.println( " *C");
  Serial.print("Ambient F: ");  Serial.print(mlx.readAmbientTempF()); Serial.println( " *F"); 
  Serial.println();
  Serial.println();
  Serial.print("Object C: ");  Serial.print(mlx.readObjectTempC()); Serial.println( " *C");
  Serial.print("Object F: ");  Serial.print(mlx.readObjectTempF()); Serial.println( " *F");
  Serial.println();
  Serial.println();

  delay(1000);
}

