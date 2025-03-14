#include <Wire.h>
#include <Adafruit_MLX90614.h>

Adafruit_MLX90614 mlx = Adafruit_MLX90614();


float get_Average()
{
  // sum
  // readings number
  //run loop for reading and store the value into sum (sum+sum+sum+sum+sum)
  // divide the sum by reading and return the value
  float sum = 0;
  int readings = 10 ;

  for(int i=0; i<10; i++)
  {
    sum = sum + mlx.readObjectTempF();
    
    delay(10);

  }
  
  return sum/readings;
}



void setup() {
  Serial.begin(115200);
  
  // Initialize I2C (Use appropriate GPIOs for ESP32-S3)
  Wire.begin(9, 8);  // SDA = GPIO10, SCL = 8 (Change as needed)

  if (!mlx.begin()) {
    Serial.println("Error connecting to MLX90614!");
    while (1);
  }

  Serial.println("MLX90614 Ready!");
}

void loop() {
  float tempF = get_Average();  // Read object temperature in Celsius
  //float tempF = (tempC * 9.0 / 5.0) + 32.0;  // Convert to Fahrenheit

  Serial.print("Object Temperature: ");
  Serial.print(tempF);
  Serial.println(" °F");

  delay(2000);
}
