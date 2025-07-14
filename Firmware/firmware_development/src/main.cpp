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
#include "ToggleDiaper.h"   //Diaper Moisture Detection
#include "ProbeSensor.h"    // Probe Temperature Sensor
#include "ultrasonic.h"     // Ultrasonic Sensor
#include "WeightSensor.h"   // Weight Sensor
#include "ToggleWeight.h"   //weight flags
#include "BabyDetection.h"  // Baby Detection Module
#include "MicSensor.h"      // Crying Detection using Mic
#include "ToggleCry.h"      //Crying flag
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
int aqiInterval = 60000;
int moistureInterval = 2000;
int probeInterval = 15000;
int detectionInterval = 1000;
int micInterval = 200;       // Adjusted to actual interval used in MicSensor
int lullabyInterval = 60000; // wont repeat within 1 min duration if flag fluctuates from true to false & then false to true

bool signupCheck = false;
bool lullabyCurrentlyPlaying = false;

bool mainBabyCryingVar = false; // already defined in MicSensor file for global access

String firebaseCradleID = "Modelx-FYP203"; // Change this to your cradle ID

//////////////////////////////////////////////////////////////////variable for notifications//////////////////////////////////////////////////////////////////////////
String dynamicParentId = ""; // Global variable

// for temp notification
bool tempAlertSent = false;
unsigned long lastTempAlertTime = 0;
int tempAlertCooldown = 10 * 60 * 1000; // 10 minutes
// For moisture notification
bool moistureAlertSent = false;
unsigned long lastMoistureAlertTime = 0;
int moistureAlertCooldown = 15 * 60 * 1000; // 15 minutes
// For AQI notification
bool aqiAlertSent = false;
unsigned long lastAqiAlertTime = 0;
int aqiAlertCooldown = 15 * 60 * 1000; // 15 minutes
// For baby absence notification
bool babyAbsentAlertSent = false;
unsigned long lastBabyAbsentAlertTime = 0;
int babyAbsentAlertCooldown = 10 * 60 * 1000; // 10 minutes
// For baby crying notification
bool babyCryingAlertSent = false;
unsigned long lastBabyCryingAlertTime = 0;
int babyCryingAlertCooldown = 10 * 60 * 1000; // 10 minutes
//////////////////////////////////////////////////////////////////variable for notifications//////////////////////////////////////////////////////////////////////////

void fetchParentIdFromFirebase(String cradleId) {

    String path = "/cradles/";
    path.concat(cradleId); 
    path.concat("/parentId");

    if (Firebase.RTDB.getString(&fbdo, path)) {
        dynamicParentId = fbdo.stringData();
        Serial.print("✅ Parent ID fetched: ");
        Serial.println(dynamicParentId);
    } else {
        Serial.print("❌ Failed to fetch parentId: ");
        Serial.println(fbdo.errorReason());
    }
}


void setup()
{



    Serial.begin(115200);
    delay(500);
    init_Dfplayer(); // call before using its play() functions

    myDFPlayer.play(1); // welcome note
    delay(5000);

    myDFPlayer.play(2); // initiating components
    delay(5000);

    Serial.println("******************************************************");
    Serial.println("******************************************************");
    init_Wifi_Connections();

    // After Wi-Fi is connected
    
    //NTP Sync.
    configTime(0, 0, "pool.ntp.org", "time.nist.gov");

    Serial.println("Waiting for NTP time sync...");
    time_t now = time(nullptr);
    while (now < 100000)
    {
        delay(500);
        Serial.print(".");
        now = time(nullptr);
    }
    Serial.println("\nNTP time synced!");

    // Serial.println("Using Cradle ID: ");
    Serial.println(firebaseCradleID);
    Serial.println("******************************************************");


    // contains wifi ok audio
    init_AQI_sensor();
    init_Moisture_Sensor();
    init_Toggle_Diaper();
    init_Probe_Sensor();
    init_Baby_Detection_Sensors();
    init_Mic();
    init_Toggle_Cry();

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
    fetchParentIdFromFirebase(firebaseCradleID);
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

// void pushTemperatureNotification(float tempValue)
// {
//     String parentId = "F6hVlGjbukP96l0hWAgi2RkjcFE2"; // Can be replaced with actual Firebase UID
//     String path = "/notifications/";
//     FirebaseJson json;
//     // Build the message using concat (no `+`)
//     String msg;
//     msg.concat("Baby's temperature is high! Current: ");
//     msg.concat(String(tempValue, 1));
//     msg.concat("°F");
//     json.set("message", msg);
//     json.set("timestamp", time(nullptr)); // UNIX timestamp
//     json.set("type", "temperature_alert");
//     json.set("acknowledged", false);
//     json.set("parentId", parentId);
//     if (Firebase.RTDB.pushJSON(&fbdo, path.c_str(), &json))
//     {
//         String notificationId = fbdo.pushName();
//         Serial.print("Notification ID: ");
//         Serial.println(notificationId);
//         // Add notificationId using concat
//         FirebaseJson updateJson;
//         updateJson.set("notificationId", notificationId);
//         String finalPath;
//         finalPath.concat(path);
//         finalPath.concat(notificationId);
//         Firebase.RTDB.updateNode(&fbdo, finalPath.c_str(), &updateJson);
//     }
//     else
//     {
//         Serial.print("Push failed: ");
//         Serial.println(fbdo.errorReason());
//     }
// }


void pushTemperatureNotification(float tempValue)
{
    if (dynamicParentId == "") {
        Serial.println("⚠️ Parent ID not set. Skipping notification.");
        return;
    }

    String path = "/notifications/";

    FirebaseJson json;

    String msg;
    msg.concat("Baby's temperature is high! Current: ");
    msg.concat(String(tempValue, 1));
    msg.concat("°F");

    json.set("message", msg);
    json.set("timestamp", time(nullptr)); // UNIX timestamp
    json.set("type", "temperature_alert");
    json.set("acknowledged", false);
    json.set("parentId", dynamicParentId); // ✅ dynamic!

    if (Firebase.RTDB.pushJSON(&fbdo, path.c_str(), &json))
    {
        String notificationId = fbdo.pushName();
        Serial.print("✅ Notification pushed: ");
        Serial.println(notificationId);

        FirebaseJson updateJson;
        updateJson.set("notificationId", notificationId);

        // String finalPath = path + notificationId;


        String finalPath="";
        finalPath.concat(path);
        finalPath.concat(notificationId);
        Firebase.RTDB.updateNode(&fbdo, finalPath.c_str(), &updateJson);
    }
    else
    {
        Serial.print("❌ Push failed: ");
        Serial.println(fbdo.errorReason());
    }
}

void pushMoistureNotification()
{

 if (dynamicParentId == "") {
        Serial.println("⚠️ Parent ID not set. Skipping notification.");
        return;
    }

    // String parentId = "F6hVlGjbukP96l0hWAgi2RkjcFE2"; // Replace with actual UID if dynamic
    String path = "/notifications/";

    FirebaseJson json;

    // Build message
    String msg;
    msg.concat("Diaper change needed! Moisture detected.");

    json.set("message", msg);
    json.set("timestamp", time(nullptr)); // UNIX timestamp
    json.set("type", "moisture_alert");
    json.set("acknowledged", false);
    json.set("parentId", dynamicParentId);

    if (Firebase.RTDB.pushJSON(&fbdo, path.c_str(), &json))
    {
        String notificationId = fbdo.pushName();
        Serial.print("Notification ID: ");
        Serial.println(notificationId);

        FirebaseJson updateJson;
        updateJson.set("notificationId", notificationId);

        String finalPath;
        finalPath.concat(path);
        finalPath.concat(notificationId);

        Firebase.RTDB.updateNode(&fbdo, finalPath.c_str(), &updateJson);
    }
    else
    {
        Serial.print("Push failed: ");
        Serial.println(fbdo.errorReason());
    }
}

void pushAqiNotification()
{
     if (dynamicParentId == "") {
        Serial.println("⚠️ Parent ID not set. Skipping notification.");
        return;
    }
    // String parentId = "F6hVlGjbukP96l0hWAgi2RkjcFE2"; // Replace with dynamic UID if needed

    String path = "/notifications/";

    FirebaseJson json;

    String msg;
    msg.concat("Air Quality is Hazardous! Take precautions immediately.");

    json.set("message", msg);
    json.set("timestamp", time(nullptr)); // UNIX timestamp
    json.set("type", "aqi_alert");
    json.set("acknowledged", false);
    json.set("parentId", dynamicParentId);

    if (Firebase.RTDB.pushJSON(&fbdo, path.c_str(), &json))
    {
        String notificationId = fbdo.pushName();
        Serial.print("Notification ID: ");
        Serial.println(notificationId);

        FirebaseJson updateJson;
        updateJson.set("notificationId", notificationId);

        String finalPath;
        finalPath.concat(path);
        finalPath.concat(notificationId);

        Firebase.RTDB.updateNode(&fbdo, finalPath.c_str(), &updateJson);
    }
    else
    {
        Serial.print("Push failed: ");
        Serial.println(fbdo.errorReason());
    }
}

void pushBabyAbsentNotification()
{
     if (dynamicParentId == "") {
        Serial.println("⚠️ Parent ID not set. Skipping notification.");
        return;
    }
    // String parentId = "F6hVlGjbukP96l0hWAgi2RkjcFE2"; // Replace with actual UID if needed
    String path = "/notifications/";

    FirebaseJson json;

    String msg;
    msg.concat("Baby is not in the cradle! Please check.");

    json.set("message", msg);
    json.set("timestamp", time(nullptr)); // UNIX timestamp
    json.set("type", "baby_absent_alert");
    json.set("acknowledged", false);
    json.set("parentId", dynamicParentId);
    if (Firebase.RTDB.pushJSON(&fbdo, path.c_str(), &json))
    {
        String notificationId = fbdo.pushName();
        Serial.print("Notification ID: ");
        Serial.println(notificationId);

        FirebaseJson updateJson;
        updateJson.set("notificationId", notificationId);

        String finalPath;
        finalPath.concat(path);
        finalPath.concat(notificationId);

        Firebase.RTDB.updateNode(&fbdo, finalPath.c_str(), &updateJson);
    }
    else
    {
        Serial.print("Push failed: ");
        Serial.println(fbdo.errorReason());
    }
}

void pushBabyCryingNotification()
{
     if (dynamicParentId == "") {
        Serial.println("⚠️ Parent ID not set. Skipping notification.");
        return;
    }
    // String parentId = "F6hVlGjbukP96l0hWAgi2RkjcFE2"; // Replace with actual UID if needed
    String path = "/notifications/";

    FirebaseJson json;

    String msg;
    msg.concat("Baby is crying! Please check on the baby.");

    json.set("message", msg);
    json.set("timestamp", time(nullptr)); // UNIX timestamp
    json.set("type", "crying_alert");
    json.set("acknowledged", false);
   json.set("parentId", dynamicParentId);

    if (Firebase.RTDB.pushJSON(&fbdo, path.c_str(), &json))
    {
        String notificationId = fbdo.pushName();
        Serial.print("Notification ID: ");
        Serial.println(notificationId);

        FirebaseJson updateJson;
        updateJson.set("notificationId", notificationId);

        String finalPath;
        finalPath.concat(path);
        finalPath.concat(notificationId);

        Firebase.RTDB.updateNode(&fbdo, finalPath.c_str(), &updateJson);
    }
    else
    {
        Serial.print("Push failed: ");
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
        ////////////////////////////// Baby Detection ////////////////////////////////////////

        String presencePath = "sensors/";
        presencePath.concat(firebaseCradleID);
        presencePath.concat("/babyPresence");
        presencePath.concat("/ispresent");

        bool babyPresent = baby_Detection_Flag();   //being used by detection algo and mic

        // Baby detection (Weight and Ultrasonic)
        if (currentMillis - prevTimeBabyDetectionSentData > detectionInterval || prevTimeBabyDetectionSentData == 0)
        {

            prevTimeBabyDetectionSentData = currentMillis;


            // bool babyPresent = baby_Detection_Flag();
            Serial.print("Baby Detection Flag:  "); Serial.println(babyPresent);
            //Serial.print("Ultrasonic Distance: "); Serial.println(get_Distance());
            
            Serial.print("Weight Flag: -------> "); Serial.println(process_Weight_OK());
            
            // Push presence status to Firebase
            pushDataToFirebase(presencePath, "Baby Detection", Firebase.RTDB.setBool(&fbdo, presencePath, babyPresent));
            
            // Serial.print("WEIGHT: "); Serial.println(measure_WeightChange());
            
                        
            
            // Notification logic: alert if baby is NOT detected
            if (!babyPresent && (!babyAbsentAlertSent || (currentMillis - lastBabyAbsentAlertTime > babyAbsentAlertCooldown)))
            {
                pushBabyAbsentNotification();
                babyAbsentAlertSent = true;
                lastBabyAbsentAlertTime = currentMillis;
            }
            else if (babyPresent)
            {
                babyAbsentAlertSent = false; // Reset alert flag if baby returns
            }
        }
        ///////////////////////////////////////////////////////// sound cry sensor ///////////////////////////////////////////////////////////

        String cryingPath = "sensors/";
        cryingPath.concat(firebaseCradleID);
        cryingPath.concat("/SoundSensor");
        cryingPath.concat("/value");

        // Cry detection (Mic)
        //baby needs to be present to detect cry
        if ((currentMillis - prevTimeMicSentData > micInterval || prevTimeMicSentData == 0) /*&& babyPresent*/)
        {
            prevTimeMicSentData = currentMillis;

            if(babyPresent)
            {
                mainBabyCryingVar = process_Cry();
            }
            else
            {
                turn_Off_Cry_LED();
                mainBabyCryingVar = false;
            }
            

            // pushDataToFirebase("sensors/BabyCrying", "Baby Crying", Firebase.RTDB.setBool(&fbdo, "sensors/BabyCrying", mainBabyCryingVar/*babyCrying*/ /*process_Sound_And_Detect_Cry()*/));
            pushDataToFirebase(cryingPath, "Baby Crying", Firebase.RTDB.setBool(&fbdo, cryingPath, mainBabyCryingVar /*babyCrying*/ /*process_Sound_And_Detect_Cry()*/));
            

            // initially mic raw values will be fluctuating greatly, they'll stabilize after some minutes of execution.
            // Serial.print("-------------"); Serial.print(mic_Raw_Value()); Serial.println("-------------");
            // Serial.print(babyCrying); Serial.println(" ------  ");
            
            // toggel cry detection
            Serial.print("Cry Status: ");  Serial.print(mainBabyCryingVar); Serial.print(", With Value: "); Serial.println(read_Cry_Raw_Value());
            
            
            // for checking if baby is present or not (only for debugging purpose, not the part of the logic)
            //Serial.print("Baby Flag: "); Serial.println(baby_Detection_Flag());

            if (mainBabyCryingVar && (!babyCryingAlertSent || (currentMillis - lastBabyCryingAlertTime > babyCryingAlertCooldown)))
            {
                pushBabyCryingNotification();
                babyCryingAlertSent = true;
                lastBabyCryingAlertTime = currentMillis;
            }
            else if (!mainBabyCryingVar)
            {
                babyCryingAlertSent = false; // Reset when baby stops crying
            }
        }
        ///////////////////////////////////////////////////////// AQI sensor ///////////////////////////////////////////////////////////

        String AQIPath = "sensors/";
        AQIPath.concat(firebaseCradleID);
        AQIPath.concat("/AQISensor");
        AQIPath.concat("/value");

        // AQI sensor
        if (currentMillis - prevTimeAQISentData > aqiInterval || prevTimeAQISentData == 0)
        {
            // prevTimeAQISentData = currentMillis;
            // pushDataToFirebase(AQIPath, "AQI Grade", Firebase.RTDB.setString(&fbdo, AQIPath, AQI_grade()));
            // Firebase.RTDB.setInt(&fbdo, "ignoreValues/AQIVoltage", read_AQI_Voltage());
            prevTimeAQISentData = currentMillis;

            String aqiStatus = AQI_grade();

            // Push AQI status to Firebase
            pushDataToFirebase(AQIPath, "AQI Grade", Firebase.RTDB.setString(&fbdo, AQIPath, aqiStatus));

            // Notification logic for "Hazardous" with cooldown
            if (aqiStatus == "Hazardous" && (!aqiAlertSent || (currentMillis - lastAqiAlertTime > aqiAlertCooldown)))
            {
                pushAqiNotification();
                aqiAlertSent = true;
                lastAqiAlertTime = currentMillis;
            }
            else if (aqiStatus != "Hazardous")
            {
                aqiAlertSent = false; // Reset flag if air quality improves
            }
        }
        ///////////////////////////////////////////////////////// moisture sensor ///////////////////////////////////////////////////////////
        String moisturePath = "sensors/";
        moisturePath.concat(firebaseCradleID);
        moisturePath.concat("/MositureSensor");
        moisturePath.concat("/value");

        // Diaper sensor
        if (/*babyPresent &&*/ (currentMillis - prevTimeMoistureSentData > moistureInterval || prevTimeMoistureSentData == 0))
        {
            prevTimeMoistureSentData = currentMillis;
            // pushDataToFirebase(moisturePath, "Diaper Condition", Firebase.RTDB.setString(&fbdo, moisturePath, diaper_Condition()));
            String diaperStatus = " ";
            
            if(babyPresent)
            {
                diaperStatus = process_Diaper();
            }
            else
            {
                diaperStatus = "Diaper Clean";
                turn_Off_Diaper_LED();
            }

            // Push to Firebase
            pushDataToFirebase(moisturePath, "Diaper Condition", Firebase.RTDB.setString(&fbdo, moisturePath, diaperStatus));

            //Serial Debugging
            //Serial.print("Moisture Status: ");  Serial.print(diaperStatus); Serial.print(", With Value: "); Serial.println(read_Diaper_Raw_Value());

            // Notification logic with cooldown
            if (diaperStatus == "Change Diaper" && (!moistureAlertSent || (currentMillis - lastMoistureAlertTime > moistureAlertCooldown)))
            {
                pushMoistureNotification();
                moistureAlertSent = true;
                lastMoistureAlertTime = currentMillis;
            }
            else if (diaperStatus == "Diaper Clean")
            {
                moistureAlertSent = false; // Reset flag when condition normalizes
            }
        }
        /////////////////////////////////////////////////////////probe temp sensory///////////////////////////////////////////////////////////

        // firebase temp sesor path
        String tempPath = "sensors/";
        tempPath.concat(firebaseCradleID);
        tempPath.concat("/TempSensor");
        tempPath.concat("/value");
        // Probe sensor
        if (currentMillis - prevTimeProbeSentData > probeInterval || prevTimeProbeSentData == 0)
        {
            // prevTimeProbeSentData = currentMillis;
            // // pushDataToFirebase("sensors/ProbeTemp", "Probe Temperature", Firebase.RTDB.setFloat(&fbdo, "sensors/ProbeTemp", temp_In_Fahrenheit()));
            // pushDataToFirebase(tempPath, "Probe Temperature", Firebase.RTDB.setFloat(&fbdo, tempPath, temp_In_Fahrenheit()));

            prevTimeProbeSentData = currentMillis;

            float currentTemp = temp_In_Fahrenheit();
            pushDataToFirebase(tempPath, "Probe Temperature", Firebase.RTDB.setFloat(&fbdo, tempPath, currentTemp));

            // Check if temperature is high and cooldown passed
            if (currentTemp > 99 && (!tempAlertSent || (currentMillis - lastTempAlertTime > tempAlertCooldown)))
            {
                pushTemperatureNotification(currentTemp);
                tempAlertSent = true;
                lastTempAlertTime = currentMillis;
            }
            else if (currentTemp <= 98)
            {
                tempAlertSent = false; // Reset if temp returns to normal
            }
        }

    /*
    Following block doesn't send data to firebase,
    but checks if baby is crying and plays the lullaby with proper timing.
    */
    
    //un-comment following region for lullaby playing
     #pragma region 
    if (mainBabyCryingVar) 
    {

        if (currentMillis - prevTimeLullabyPlayed > lullabyInterval) {
            myDFPlayer.play(8); // Play the lullaby track
            prevTimeLullabyPlayed = currentMillis; // Update the timestamp for the next cooldown check
            
            Serial.println("Baby crying detected, starting/restarting lullaby.");
        }
    }
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