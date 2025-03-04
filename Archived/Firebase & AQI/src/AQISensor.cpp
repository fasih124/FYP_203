#include <Arduino.h>
#define MQ135_AnalogPin 4 //ADC Pin



//Function to init sensor (pinmode)
void init_AQI_sensor()
{
   pinMode(MQ135_AnalogPin, INPUT);
}

//Function to return raw voltage
int read_AQI_Voltage()
{
  int aqiValue = analogRead(MQ135_AnalogPin);
  return aqiValue;
}

//Function that gets that raw voltage and returns String based on raw value
String AQI_grade()
{
  int aqiResolution = read_AQI_Voltage();

  if (aqiResolution < 200) return "Excellent";
  else if (aqiResolution < 400) return "Good";
  else if (aqiResolution < 600) return "Moderate";
  else if (aqiResolution < 800) return "Poor";
  else 
    return "Hazardous";

}


// void loop ()
// {
//   int rawVoltage = analogRead(MQ135_AnalogPin);
  
//   Serial.print("Voltage value: "); Serial.print(rawVoltage); Serial.print("\t");
  
//   // The values need calibration in real-time environment
  
//   if (rawVoltage < 200) Serial.println("Air Quality: Excellent");
//   else if (rawVoltage < 400) Serial.println("Air Quality: Good");
//   else if (rawVoltage < 600) Serial.println("Air Quality: Moderate");
//   else if (rawVoltage < 800) Serial.println("Air Quality: Poor");
//   else Serial.println("Air Quality: Hazardous");

//   delay(2000);
// }

#pragma region  
/*
This code converts raw voltage value to standard AQI values
But its having some logical error and creating accuracy issues
*/

// //Converts gas value to approximate ppm 
// float getGasConc(int rawValue)  //Analog read value in the parameter
// {
//   float voltage = (rawValue / 4095) * 3.3;
//   float ppm = voltage * 2500;   //sensor caibration factor for 3.3V
//   return ppm;
// }

// //Maps ppm value to AQI levels (US EPA Scale)
// float calAQI(float ppm)
// {
//   if (ppm <= 50) return 50;         //Good
//   else if (ppm <= 100) return 100;  //Moderate
//   else if (ppm <= 150) return 150;  //Unhealthy for special
//   else if (ppm <= 200) return 200;  //Unhealthy
//   else return 300;                  //Hazardous
// }


// void setup()
// {
//   Serial.begin(115200);

// }

// void loop()
// {
//   int rawValue = analogRead(MQ135_Pin);
//   float gasPpm = getGasConc(rawValue);
//   int aqi = calAQI(gasPpm);

//   Serial.print("Raw Value: "); Serial.print(rawValue);
//   Serial.print(" | Gas PPM: "); Serial.print(gasPpm);
//   Serial.print(" | AQI: "); Serial.print(aqi);

//    // AQI classification based on US EPA standards
//   if (aqi <= 50) Serial.println(" | Air Quality: Good");
//   else if (aqi <= 100) Serial.println(" | Air Quality: Moderate");
//   else if (aqi <= 150) Serial.println(" | Air Quality: Unhealthy for Sensitive Groups");
//   else if (aqi <= 200) Serial.println(" | Air Quality: Unhealthy");
//   else Serial.println(" | Air Quality: Hazardous!");

//     delay(2000);  // Read every 5 seconds  



// }
#pragma endregion

