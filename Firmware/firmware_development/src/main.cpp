/*
Things to do in main.cpp when integrating a new module:
    Add Header file
    Add variable for previous time of execution
    Add interval variable
    Init sensor in setup()
    Write relevant code in loop()
*/

#include <Arduino.h>
#include <Firebase_ESP_Client.h>

//Custom header files
#include "WifiConnection.h" // WiFi Connection
#include "AQISensor.h"      // AQI Sensor
#include "MoistureSensor.h" // Moisture Sensor
#include "ProbeSensor.h"    // Probe Temperature Sensor
#include "IRSensor.h"       // IR Sensor
#include "WeightSensor.h"   // Weight Sensor
#include "BabyDetection.h"  // Baby Detection Module
#include "MicSensor.h"      // Crying Detection using Mic

//Provides the token generation process info
#include "addons/TokenHelper.h"
//Provides the RTDB payload printing info and other helper functions
#include "addons/RTDBHelper.h"

// Firebase Config
#define DB_URL "https://esp-test-rtdb-a7ae5-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define API_KEY "AIzaSyAkcfm9OAStI2TGGAaKoO-6ZepYpOU6O9g"

// Firebase Objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// Execution Timers
unsigned long prevTimeAQISentData = 0;
unsigned long prevTimeMoistureSentData = 0;
unsigned long prevTimeProbeSentData = 0;
unsigned long prevTimeBabyDetectionSentData = 0;
unsigned long prevTimeMicSentData = 0;

// Intervals
int aqiInterval = 10000;
int moistureInterval = 10000;
int probeInterval = 10000;
int detectionInterval = 10000;
int micInterval = 100; // Adjusted to actual interval used in MicSensor

bool signupCheck = false;

void setup() 
{
    Serial.begin(115200);
    delay(100);

    init_Wifi_Connections();
    init_AQI_sensor();
    init_Moisture_Sensor();
    init_Probe_Sensor();
    init_Baby_Detection_Sensors();
    init_Mic();

    config.api_key = API_KEY;
    config.database_url = DB_URL;

    if (Firebase.signUp(&config, &auth, "", "")) 
    {
        Serial.println("Sign-up check: OK");
        signupCheck = true;
    } 
    else 
    {
        Serial.println("Error in Signup & DB connection");
        Serial.println(config.signer.signupError.message.c_str());
    }

    config.token_status_callback = tokenStatusCallback;
    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);

}// setup() ends

void pushDataToFirebase(const String& path, const String& type, bool success) 
{
    if (success) 
    {
        Serial.print(type); Serial.println(" Pushed");
        Serial.print("Path: "); Serial.println(path);
        Serial.print("Type: "); Serial.println(type);
    } 
    else 
    {
        Serial.println("FAILED!");
        Serial.print("Firebase Error: "); Serial.println(fbdo.errorReason());
    }

}

void loop() 
{
    unsigned long currentMillis = millis();

    //NOTE: DO NOT change the order of sensor code. Otherwise, mic_sensor may not give right values due to firebase latency issues
    if (Firebase.ready() && signupCheck) 
    {

        //Baby detection (Weight and IR)
        if (currentMillis - prevTimeBabyDetectionSentData > detectionInterval || prevTimeBabyDetectionSentData == 0) 
        {
            prevTimeBabyDetectionSentData = currentMillis;
            pushDataToFirebase("sensors/BabyDetection", "Baby Detection", Firebase.RTDB.setBool(&fbdo, "sensors/BabyDetection", baby_Detection_Flag()));
            
        }


        //Cry detection (Mic)
        if (currentMillis - prevTimeMicSentData > micInterval || prevTimeMicSentData == 0) 
        {
            prevTimeMicSentData = currentMillis;
            pushDataToFirebase("sensors/BabyCrying", "Baby Crying", Firebase.RTDB.setBool(&fbdo, "sensors/BabyCrying", processSoundAndDetectCry()));
            //Firebase.RTDB.setInt(&fbdo, "ignoreValues/Mic", mic_Raw_Value());
            //Firebase.RTDB.setInt(&fbdo, "ignoreValues/Mic_Average", average);
            Serial.println(mic_Raw_Value());
        }



        // AQI sensor
        if (currentMillis - prevTimeAQISentData > aqiInterval || prevTimeAQISentData == 0) 
        {
            prevTimeAQISentData = currentMillis;
            pushDataToFirebase("sensors/AQIGrade", "AQI Grade", Firebase.RTDB.setString(&fbdo, "sensors/AQIGrade", AQI_grade()));
            //Firebase.RTDB.setInt(&fbdo, "ignoreValues/AQIVoltage", read_AQI_Voltage());
            
            
        }

        //Diaper sensor
        if (currentMillis - prevTimeMoistureSentData > moistureInterval || prevTimeMoistureSentData == 0) 
        {
            prevTimeMoistureSentData = currentMillis;
            pushDataToFirebase("sensors/DiaperCondition", "Diaper Condition", Firebase.RTDB.setString(&fbdo, "sensors/DiaperCondition", diaper_Condition()));
        }

        //Probe sensor
        if (currentMillis - prevTimeProbeSentData > probeInterval || prevTimeProbeSentData == 0) 
        {
            prevTimeProbeSentData = currentMillis;
            pushDataToFirebase("sensors/ProbeTemp", "Probe Temperature", Firebase.RTDB.setFloat(&fbdo, "sensors/ProbeTemp", temp_In_Fahrenheit()));
        }


    } 
    else 
    {
        //Serial.println("Interval wait!");
        Serial.print("Firebase Error: ("); Serial.print(fbdo.errorReason()); Serial.println(")");
        delay(1500);
    }




}//loop() ends