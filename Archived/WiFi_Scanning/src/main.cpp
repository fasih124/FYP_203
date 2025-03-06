#include <Arduino.h>
#include <WiFi.h>

void setup() 
{
    Serial.begin(115200);
    WiFi.mode(WIFI_STA);
    WiFi.disconnect();  
    delay(100);


}

void loop() 
{
  Serial.println("Scanning for WiFi networks...");
  int numNetworks = WiFi.scanNetworks();

  if (numNetworks == 0) 
  {
      Serial.println("No WiFi networks found.");
  } 
  else 
  {
      Serial.println("Found WiFi networks:");
      for (int i = 0; i < numNetworks; i++) 
      {
          Serial.println(String(i + 1) + ": " + WiFi.SSID(i));
      }
  }

  delay(3000);

  
}
