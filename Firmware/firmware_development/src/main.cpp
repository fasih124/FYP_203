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

// Custom header files
#include "WifiConnection.h" // WiFi Connection
#include "AQISensor.h"      // AQI Sensor
#include "MoistureSensor.h" // Moisture Sensor
#include "ProbeSensor.h"    // Probe Temperature Sensor
#include "IRSensor.h"       // IR Sensor
#include "WeightSensor.h"   // Weight Sensor
#include "BabyDetection.h"  // Baby Detection Module
#include "MicSensor.h"      // Crying Detection using Mic
#include "dfplayer.h"       // Mp3 module

// Firebase_ESP_Client Firebase;
// Firebase Objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// Provides the token generation process info
#include "addons/TokenHelper.h"
// Provides the RTDB payload printing info and other helper functions
#include "addons/RTDBHelper.h"

// Firebase Config
#define DB_URL "https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app/" //"https://carenest-5594e-default-rtdb.firebaseio.com/"
#define API_KEY "AIzaSyDgpAMZvSibox-INAbPeTfOlroY-LTs9eE"                           //"AIzaSyCkLbu5xrMndsmpfY_hvYv19thuOXH8F68"

// Execution Timers
unsigned long prevTimeAQISentData = 0;
unsigned long prevTimeMoistureSentData = 0;
unsigned long prevTimeProbeSentData = 0;
unsigned long prevTimeBabyDetectionSentData = 0;
unsigned long prevTimeMicSentData = 0;
unsigned long prevTimeLullabyPlayed = 0;

// Intervals
int aqiInterval = 30000;
int moistureInterval = 30000;
int probeInterval = 30000;
int detectionInterval = 15000;
int micInterval = 100;       // Adjusted to actual interval used in MicSensor
int lullabyInterval = 60000; // wont repeat within 1 min duration if flag fluctuates from true to false & then false to true

bool signupCheck = false;
bool lullabyCurrentlyPlaying = false;

bool babyIsCrying = false; // already defined in MicSensor file for global access

String firebaseCradleID = "cradle1"; // Change this to your cradle ID

void setup()
{
    Serial.begin(115200);
    delay(100);
    init_Dfplayer(); // call before using its play() functions

    myDFPlayer.play(1); // welcome note
    delay(5000);

    myDFPlayer.play(2); // initiating components
    delay(5000);

    Serial.println("******************************************************");
    Serial.println("******************************************************");
    init_Wifi_Connections();
    // Serial.println("Using Cradle ID: ");
    Serial.println(firebaseCradleID);
    Serial.println("******************************************************");
    Serial.println("******************************************************");

    // contains wifi ok audio
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

        myDFPlayer.play(5); // DB ok audio
        delay(5000);
    }
    else
    {
        Serial.println("Error in Signup & DB connection");
        Serial.println(config.signer.signupError.message.c_str());

        myDFPlayer.play(6); // DB failed audio
        delay(5000);
    }

    config.token_status_callback = tokenStatusCallback;
    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);

    myDFPlayer.play(7); // all system checks ok

} // setup() ends

void pushDataToFirebase(const String &path, const String &type, bool success)
{
    if (success)
    {
        Serial.print(type);
        Serial.println(" Pushed");
        Serial.print("Path: ");
        Serial.println(path);
        Serial.print("Type: ");
        Serial.println(type);
    }
    else
    {
        Serial.println("FAILED!");
        Serial.print("Firebase Error: ");
        Serial.println(fbdo.errorReason());
    }
}

void loop()
{
    unsigned long currentMillis = millis();

    /* NOTE:
     DO NOT change the order of sensor code.
     Otherwise, mic_sensor may not give right values
     due to firebase latency issues.
     Also, DO NOT send raw values unless necessary 'cuz,
     this can also introduce latency in firebase.
    */

    if (Firebase.ready() && signupCheck)
    {

        String presencePath = "sensors/";
        presencePath.concat(firebaseCradleID);
        presencePath.concat("/babyPresence");
        presencePath.concat("/ispresent");
        

        // Baby detection (Weight and IR)
        if (currentMillis - prevTimeBabyDetectionSentData > detectionInterval || prevTimeBabyDetectionSentData == 0)
        {
            prevTimeBabyDetectionSentData = currentMillis;
            pushDataToFirebase(presencePath, "Baby Detection", Firebase.RTDB.setBool(&fbdo, presencePath, baby_Detection_Flag()));
            // Serial.print("WEIGHT: "); Serial.println(measure_WeightChange());
            Serial.print("TEMPERATURE:  ");
            Serial.println(get_Average_IRTemp());
            Serial.print("Baby Detection Flag:  ");
            Serial.println(baby_Detection_Flag());
        }



        String cryingPath = "sensors/";
        cryingPath.concat(firebaseCradleID);
        cryingPath.concat("/SoundSensor");
        cryingPath.concat("/value");
        
        // Cry detection (Mic)
        if (currentMillis - prevTimeMicSentData > micInterval || prevTimeMicSentData == 0)
        {
            prevTimeMicSentData = currentMillis;

            babyIsCrying = process_Sound_And_Detect_Cry();

            // pushDataToFirebase("sensors/BabyCrying", "Baby Crying", Firebase.RTDB.setBool(&fbdo, "sensors/BabyCrying", babyIsCrying/*babyCrying*/ /*process_Sound_And_Detect_Cry()*/));
            pushDataToFirebase(cryingPath, "Baby Crying", Firebase.RTDB.setBool(&fbdo, cryingPath, babyIsCrying/*babyCrying*/ /*process_Sound_And_Detect_Cry()*/));
            // Firebase.RTDB.setInt(&fbdo, "ignoreValues/Mic", mic_Raw_Value());
            // Firebase.RTDB.setInt(&fbdo, "ignoreValues/Mic_Average", average);

            // initially mic raw values will be fluctuating greatly, they'll stabilize after some minutes of execution.
            // Serial.print("-------------");
            // Serial.print(mic_Raw_Value());
            // Serial.println("-------------");
            // Serial.print("Cry Status: ");
            // Serial.println(babyIsCrying);
        }

        String AQIPath = "sensors/";
        AQIPath.concat(firebaseCradleID);
        AQIPath.concat("/AQISensor");
        AQIPath.concat("/value");

        // AQI sensor
        if (currentMillis - prevTimeAQISentData > aqiInterval || prevTimeAQISentData == 0)
        {
            prevTimeAQISentData = currentMillis;
            pushDataToFirebase(AQIPath, "AQI Grade", Firebase.RTDB.setString(&fbdo, AQIPath, AQI_grade()));
            // Firebase.RTDB.setInt(&fbdo, "ignoreValues/AQIVoltage", read_AQI_Voltage());
        }

        String moisturePath = "sensors/";
        moisturePath.concat(firebaseCradleID);
        moisturePath.concat("/MositureSensor");
        moisturePath.concat("/value");

        // Diaper sensor
        if (currentMillis - prevTimeMoistureSentData > moistureInterval || prevTimeMoistureSentData == 0)
        {
            prevTimeMoistureSentData = currentMillis;
            pushDataToFirebase(moisturePath, "Diaper Condition", Firebase.RTDB.setString(&fbdo, moisturePath, diaper_Condition()));
        }

        // firebase temp sesor path
        String tempPath = "sensors/";
        tempPath.concat(firebaseCradleID);
        tempPath.concat("/TempSensor");
        tempPath.concat("/value");
        // Probe sensor
        if (currentMillis - prevTimeProbeSentData > probeInterval || prevTimeProbeSentData == 0)
        {
            prevTimeProbeSentData = currentMillis;
            // pushDataToFirebase("sensors/ProbeTemp", "Probe Temperature", Firebase.RTDB.setFloat(&fbdo, "sensors/ProbeTemp", temp_In_Fahrenheit()));
            pushDataToFirebase(tempPath, "Probe Temperature", Firebase.RTDB.setFloat(&fbdo, tempPath, temp_In_Fahrenheit()));
        }

/*
Following block doesn't send data to firebase,
but checks if baby is crying and plays the lullaby with proper timing.
*/

// un-comment following region for lullaby playing
#pragma region
// if (babyIsCrying)
// {

//     if (currentMillis - prevTimeLullabyPlayed > lullabyInterval) {
//         myDFPlayer.play(8); // Play the lullaby track
//         prevTimeLullabyPlayed = currentMillis; // Update the timestamp for the next cooldown check

//         Serial.println("Baby crying detected, starting/restarting lullaby.");
//     }
// }
#pragma endregion
        myDFPlayer.available(); // Just check for availability to clear the buffer
    }
    else
    {
        // Serial.println("Interval wait!");
        Serial.print("Firebase Error: (");
        Serial.print(fbdo.errorReason());
        Serial.println(")");
        delay(1500);
    }

} // loop() ends