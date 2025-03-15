#include <Arduino.h>
#include <WiFi.h>

//Network credentials
#define WIFI_SSID "NightOwl"
#define WIFI_PASSWORD "nightowl"


void init_Wifi_Connection()
{
    
    //Wifi Connection
    WiFi.mode(WIFI_STA);  //station mode
    WiFi.disconnect();    //ensures smooth connection
    delay(100);
    Serial.println("-----------------------------------");

    //Scanning
  Serial.println("Scanning Wifi...");
  int numNetworks = WiFi.scanNetworks();  //get numbers of scanned networks

  if(numNetworks == 0)
  {
    Serial.println("No networks found!");
  }
  else
  {
    Serial.println("Available Networks: ");
    for (int i = 0; i < numNetworks; i++)
    {
        Serial.print(String(i+1)); Serial.print(": "); Serial.println(WiFi.SSID(i));
      //Serial.println(String(i+1) + ":" + WiFi.SSID(i)); //gets the ssid of network in array index
    }
  }

  //Connection
  Serial.print("\nConnecting to wifi...");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD); //initiates connection based on SSID provided

  int retries = 0;  //loop to try again if connection failed
  while(WiFi.status() != WL_CONNECTED && retries < 20)  //tries 20 times to connect to wifi
  {
    delay(500);
    Serial.print(".");  //Animation for connection time
    retries++;
  }

  if (WiFi.status() == WL_CONNECTED)
  {
    Serial.println("\n-----------Connected to Wifi!-----------");
    Serial.print("IP Address: ");
    Serial.println(WiFi.localIP()); //prints IP address assigned to controller
  }
  else
  {
    Serial.println("\n Failed to connect!");
  }
}