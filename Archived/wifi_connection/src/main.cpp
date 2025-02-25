#include <Arduino.h>
#include <WiFi.h>

String ssid = "HUAWEI-7hqx";
String password = "wifi.access(192.168)";


void setup()
{
  Serial.begin(115200); 
  WiFi.mode(WIFI_STA);  //station mode
  WiFi.disconnect();    //ensures smooth connection
  delay(100);

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
      Serial.println(String(i+1) + ":" + WiFi.SSID(i)); //gets the ssid of network in array index
    }
  }



  //Connection
  Serial.print("\nConnecting to wifi...");
  WiFi.begin(ssid, password); //initiates connection based on SSID provided

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



void loop()
{
 //setup();

}