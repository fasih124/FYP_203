//Send Data to Firebase
#include <Arduino.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include "AQISensor.h"  //AQI Sensor

//Provides the token generation process info
#include "addons/TokenHelper.h"
//Provides the RTDB payload printing info and other helper functions
#include "addons/RTDBHelper.h"

//Network credentials
#define WIFI_SSID "NightOwl"
#define WIFI_PASSWORD "nightowl"


//DB URL provided by firebase project
#define DB_URL "https://esp-test-rtdb-a7ae5-default-rtdb.asia-southeast1.firebasedatabase.app/"

//API key provided by firebase project
#define API_KEY "AIzaSyAkcfm9OAStI2TGGAaKoO-6ZepYpOU6O9g"

//LED pin definition
byte dataPassedLEDPin = 6;


//DB Object
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;


//Data sending in parallel using time functions
unsigned long sendDataPrevMillis = 0;
bool signupOK = false;

int count;  //dummy int type data beign pushed to DB


void setup()
{
    Serial.begin(115200);
    delay(100);

    pinMode(dataPassedLEDPin, OUTPUT); //DataPush LED Programming
    init_AQI_sensor();  //Initializes AQI Sensor pinMode
    
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
 
    //Assigning the API Key
    config.api_key = API_KEY;

    //Assigning the RTDB URL
    config.database_url = DB_URL;


    //Sign Up
    if (Firebase.signUp(&config, &auth, "", ""))   //Args empty for email & password
    {
        Serial.println("ok");
        signupOK = true;    //status flag set to OK
    }
    else
    {
      Serial.println();
        Serial.println("Error in Signup & DB connection");
        Serial.println(config.signer.signupError.message.c_str());
        // Serial.printf("%s\n", config.signer.signupError.message.c_str());
    }

    //Assigning the callback function for the long running token generation task
    config.token_status_callback = tokenStatusCallback;

    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);
 
}

void loop()
{
    
    //check if firebase is ready, AND signup is ok, AND (time interval is 1.5sec OR prevMillis is still 0)
    if(Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 1500 || sendDataPrevMillis == 0))
    {
        /*current time of execution of this block goes to PrevMillis, 
        keeps incrementing the threshold for next execution 
        (e.g.1500+1500 in two executions)*/

        sendDataPrevMillis = millis();
        
        //Writing int number (AQI sensor value here)
        if(Firebase.RTDB.setInt(&fbdo, "sensors/AQIVoltage", read_AQI_Voltage()))
        {
            Serial.println("AQI Voltage Pushed");
            Serial.print("Path: "); Serial.println(fbdo.dataPath());
            Serial.print("Type: "); Serial.println(fbdo.dataType());
            

            //Sending AQI Grade after AQI Voltage
            Firebase.RTDB.setString(&fbdo, "sensors/AQIGrade",AQI_grade());
            Serial.println("AQI Grade Pushed");
            Serial.print("Path: "); Serial.println(fbdo.dataPath());
            Serial.print("Type: "); Serial.println(fbdo.dataType());

            digitalWrite(dataPassedLEDPin, HIGH);
            delay(100);
            digitalWrite(dataPassedLEDPin, LOW);
            //delay(500);


        }
        else
        {
            Serial.println("FAILED!");
            Serial.print("Firebase Error: "); Serial.println(fbdo.errorReason());
        }
        
        //count++;

        //Writing string (AQI Quality)
    
    }
    else
    {
        Serial.println("Interval wait!"); 
        Serial.print("Firebase Error: ("); Serial.print(fbdo.errorReason()); Serial.println(")");
        
        delay(1500);  //Error notification delay
    }

    

}




