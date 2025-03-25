/*
Things to do in main.cpp when integrating a new module:
    Add Header file
    Add variable for previous time of execution
    Add interval variable
    Init sensor in setup()
    Write relevant code in loop()
*/

#include <Arduino.h>
//#include <WiFi.h>   //Made a separate module
#include <Firebase_ESP_Client.h>


//Custom header files
#include "WifiConnection.h" //Connection for wifi
#include "AQISensor.h"  //AQI Sensor
#include "MoistureSensor.h" //Moisture sensor
#include "ProbeSensor.h"  //Probe temperature sensor
#include "IRSensor.h" //IR sensor
#include "WeightSensor.h" //Weight sensor
#include "BabyDetection.h"  //Baby detection module

//Provides the token generation process info
#include "addons/TokenHelper.h"
//Provides the RTDB payload printing info and other helper functions
#include "addons/RTDBHelper.h"


//DB URL provided by firebase project
#define DB_URL "https://esp-test-rtdb-a7ae5-default-rtdb.asia-southeast1.firebasedatabase.app/"

//API key provided by firebase project
#define API_KEY "AIzaSyAkcfm9OAStI2TGGAaKoO-6ZepYpOU6O9g"

//Debugging LED pin definition
byte dataPassedLEDPin = 13;  //Green blinks when data is passed to firebase
int delayForDataPassedLEDPin = 70;

byte intervalWaitLEDPin = 12;  //Yelow blinks when ther is interval wait or intentional program pause
int delayForIntervalWaitLEDPin = 70;

byte dangerBlockLEDPin = 11; //Red blinks when exception block executes representing error
int delayForDangerBlockLEDPin = 3000;

//DB Object
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;


// Variables for previous time of execution. Parallel operations
unsigned long prevTimeAQISentData = 0;  // For AQI
unsigned long prevTimeMoistureSentData = 0; // For Moisture
unsigned long prevTimeProbeSentData = 0; //For Probe
unsigned long prevTimeIRprintedData = 0; //For IR sensor printing data on serial monitor (only for testing purpose)
unsigned long prevTimeWeightPrintedData = 0; //For weight sensor printing data on serial monitor (only for testing purpose)
unsigned long prevTimeBabyDetectionSentData = 0;



// Wait intervals for sensors in milliseconds
int aqiInterval = 2000; 
int moistureInterval = 2000;
int probeInterval = 2000;
int irInterval = 2000;
int weightInterval = 2000;
int detectionInterval = 2000;


//Signup check
bool signupCheck = false;


void setup()
{
    Serial.begin(115200);
    delay(100);

    pinMode(dataPassedLEDPin, OUTPUT); //DataPush LED Programming
    pinMode(intervalWaitLEDPin, OUTPUT); //Interval Wait LED Programming
    pinMode(dangerBlockLEDPin, OUTPUT); //Danger block LED Programming


    //Wifi connection initialization both AP and STA
    init_Wifi_Connections();
    

    //Sensors initialization
    init_AQI_sensor();
    init_Moisture_Sensor();
    init_Probe_Sensor();
//    init_IRSensor();  //init for testing purpose and printing output on serial monitor
//    init_WeightSensor();  //init for testing purpose and printing output on serial monitor
    init_Baby_Detection_Sensors();

    //Assigning the API Key
    config.api_key = API_KEY;

    //Assigning the RTDB URL
    config.database_url = DB_URL;


    //Sign-up Check
    if (Firebase.signUp(&config, &auth, "", ""))   //Args empty for email & password
    {
        Serial.println("Sign-up check: OK");
        signupCheck = true;    //status flag set to OK
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
  
    //AQI sensor execution block
    #pragma region 
    //check if firebase is ready, AND signup is ok, AND (time interval is 1.5sec OR prevMillis is still 0)
    if(Firebase.ready() && signupCheck && (millis() - prevTimeAQISentData > aqiInterval || prevTimeAQISentData == 0))
    {
        /*current time of execution of this block goes to PrevMillis, 
        keeps incrementing the threshold for next execution 
        (e.g.1500+1500 in two executions)*/

        prevTimeAQISentData = millis();
        
        //Writing int number (AQI sensor value here)
        if(Firebase.RTDB.setInt(&fbdo, "ignoreValues/AQIVoltage", read_AQI_Voltage()))
        {

            //Data passed LED
            digitalWrite(dataPassedLEDPin, HIGH);
            delay(delayForDataPassedLEDPin);  //70 milisec
            digitalWrite(dataPassedLEDPin, LOW);
          
            Serial.println("AQI Voltage Pushed");
            Serial.print("Path: "); Serial.println(fbdo.dataPath());
            Serial.print("Type: "); Serial.println(fbdo.dataType());
            

            //Sending AQI Grade after AQI Voltage
            Firebase.RTDB.setString(&fbdo, "sensors/AQIGrade",AQI_grade());
            Serial.println("AQI Grade Pushed");
            Serial.print("Path: "); Serial.println(fbdo.dataPath());
            Serial.print("Type: "); Serial.println(fbdo.dataType());

            digitalWrite(dataPassedLEDPin, HIGH);
            delay(delayForDataPassedLEDPin);
            digitalWrite(dataPassedLEDPin, LOW);
            //delay(500);


        }
        else
        {
            Serial.println("FAILED!");
            Serial.print("Firebase Error: "); Serial.println(fbdo.errorReason());

            // Error LED
            digitalWrite(dangerBlockLEDPin, HIGH);
            delay(delayForDangerBlockLEDPin); //3 sec
            digitalWrite(dataPassedLEDPin, LOW);
        }
        
    
    }
    else
    {
        Serial.println("Interval wait!"); 
        Serial.print("Firebase Error: ("); Serial.print(fbdo.errorReason()); Serial.println(")");
        
        // Interval wait LED
        digitalWrite(intervalWaitLEDPin, HIGH);
        delay(delayForIntervalWaitLEDPin); //70 milisec
        digitalWrite(intervalWaitLEDPin, LOW);
        delay(1500);  //Error notification delay
    }
    #pragma endregion
    //AQI sensor block end
    
    //Moisture sensor execution block
    #pragma region 
    if(Firebase.ready() && signupCheck && (millis() - prevTimeMoistureSentData > moistureInterval || prevTimeMoistureSentData == 0))
    {
      prevTimeMoistureSentData=millis();  //update sent time
      
      //String type diaper condition
      if(Firebase.RTDB.setString(&fbdo, "sensors/DiaperCondition", diaper_Condition()))
      {
        Serial.println("Diaper codition pushed!");
        Serial.print("Path: "); Serial.println(fbdo.dataPath());
        Serial.print("Type: "); Serial.println(fbdo.dataType());
        
        //Bug: Remove delay(), this function may cause program hault
        //Data passed LED
        digitalWrite(dataPassedLEDPin, HIGH);
        delay(delayForDataPassedLEDPin);  //70 milisec
        digitalWrite(dataPassedLEDPin, LOW);

        
      }
      else
      {
        Serial.println("Failed!");
        Serial.print("Firebase Error: "); Serial.println(fbdo.errorReason());

        //Bug: Remove delay(), this function may cause program hault
        // Error LED
        digitalWrite(dangerBlockLEDPin, HIGH);
        delay(delayForDangerBlockLEDPin); //3 sec
        digitalWrite(dataPassedLEDPin, LOW);

      }

    }

    else
    {
      Serial.println("Interval wait!");
      Serial.print("Firebase Error: ("); Serial.print(fbdo.errorReason()); Serial.println(")");
      
      //Bug: Remove delay(), this function may cause program hault      
      // Interval wait LED
      digitalWrite(intervalWaitLEDPin, HIGH);
      delay(delayForIntervalWaitLEDPin); //70 milisec
      digitalWrite(intervalWaitLEDPin, LOW);
    
    }
    #pragma endregion
    //Moisture sensor block end


    //Probe sensor execution block
    #pragma region 
    if(Firebase.ready() && signupCheck && (millis() - prevTimeProbeSentData > probeInterval || prevTimeProbeSentData == 0))
    {
      prevTimeProbeSentData = millis();

      //float type fahrenheit temperature
      if(Firebase.RTDB.setFloat(&fbdo, "sensors/ProbeTemp", temp_In_Fahrenheit()))
      {
        //Bug: Remove delay(), this function may cause program hault
        //Data passed LED
        digitalWrite(dataPassedLEDPin, HIGH);
        delay(delayForDataPassedLEDPin);  //70 milisec
        digitalWrite(dataPassedLEDPin, LOW);

        Serial.println("Probe temperature pushed!");
        Serial.print("Path: "); Serial.println(fbdo.dataPath());
        Serial.print("Type: "); Serial.println(fbdo.dataType());
        
      
      
      }
      else
      {
        Serial.println("Failed!");
        Serial.print("Firebase Error: "); Serial.println(fbdo.errorReason());

        //Bug: Remove delay(), this function may cause program hault
        // Error LED
        digitalWrite(dangerBlockLEDPin, HIGH);
        delay(delayForDangerBlockLEDPin); //3 sec
        digitalWrite(dataPassedLEDPin, LOW);


      }


    }
    else
    {

      //Bug: Remove delay(), this function may cause program hault      
      // Interval wait LED
      digitalWrite(intervalWaitLEDPin, HIGH);
      delay(delayForIntervalWaitLEDPin); //70 milisec
      digitalWrite(intervalWaitLEDPin, LOW);

      Serial.println("Interval wait!");
      Serial.print("Firebase Error: ("); Serial.print(fbdo.errorReason()); Serial.println(")");
      
      

    }
    #pragma endregion
    //Probe sensor block end



    // // IRSensor output (Not pushing to firebase)
    // #pragma region 
    // if (millis()-prevTimeIRprintedData > irInterval)
    // {
    //     prevTimeIRprintedData = millis();
    //     Serial.print("IR temp output: "), Serial.println(get_Average_IRTemp());
    //     Serial.print("IR flag: "), Serial.println(IR_Detection_Flag());
    // }

    // #pragma endregion
    // //IRSensor block end (Not pushing to firebase)


    // //WeightSensor output (Not pushing to firebase)
    // #pragma region 
    // if (millis()-prevTimeWeightPrintedData > weightInterval)
    // {
    //     prevTimeWeightPrintedData = millis();
    //     Serial.print("Weight output: "), Serial.println(measure_WeightChange());
    //     Serial.print("Weight flag: "), Serial.println(weight_Detection_Flag());
    // }
    
    // #pragma endregion
    // //WeightSensor block end (Not pushing to firebase)
    


    //    //Detection module output (Not pushing to firebase)
    // #pragma region 
    // if (millis()-prevTimeBabyDetectionSentData > detectionInterval)
    // {
    //     prevTimeBabyDetectionSentData = millis();
    //     Serial.print("Detection flag: "), Serial.println(baby_Detection_Flag());
    // }
    
    // #pragma endregion
    // //Detection module block end (Not pushing to firebase)



        //Baby detection execution block
        #pragma region 
        //check if firebase is ready, AND signup is ok, AND (time interval is 1.5sec OR prevMillis is still 0)
        if(Firebase.ready() && signupCheck && (millis() - prevTimeBabyDetectionSentData > detectionInterval || prevTimeBabyDetectionSentData == 0))
        {
    
            prevTimeBabyDetectionSentData = millis();
            
            //Writing bool on database (baby detection flag)
            if(Firebase.RTDB.setBool(&fbdo, "sensors/BabyDetection", baby_Detection_Flag()))
            {
    
                //Data passed LED
                digitalWrite(dataPassedLEDPin, HIGH);
                delay(delayForDataPassedLEDPin);  //70 milisec
                digitalWrite(dataPassedLEDPin, LOW);
              
                Serial.println("Baby Detection Status Pushed");
                Serial.print("Path: "); Serial.println(fbdo.dataPath());
                Serial.print("Type: "); Serial.println(fbdo.dataType());
                
    
                //Sending IRtemp(float) and weight reading(int) for debugging purpose
                
                //IRTemp reading
                Firebase.RTDB.setFloat(&fbdo, "ignoreValues/IRTemp",get_Average_IRTemp());
                Serial.println("IRTemp value pushed");
                Serial.print("Path: "); Serial.println(fbdo.dataPath());
                Serial.print("Type: "); Serial.println(fbdo.dataType());
    
                //Weight reading
                Firebase.RTDB.setInt(&fbdo, "ignoreValues/Weight",measure_WeightChange());
                Serial.println("Weight value pushed");
                Serial.print("Path: "); Serial.println(fbdo.dataPath());
                Serial.print("Type: "); Serial.println(fbdo.dataType());
    

    
            }
            else
            {
                Serial.println("FAILED!");
                Serial.print("Firebase Error: "); Serial.println(fbdo.errorReason());
    
            }
            
        
        }
        else
        {
            Serial.println("Interval wait!"); 
            Serial.print("Firebase Error: ("); Serial.print(fbdo.errorReason()); Serial.println(")");
            
            // Interval wait LED
            digitalWrite(intervalWaitLEDPin, HIGH);
            delay(delayForIntervalWaitLEDPin); //70 milisec
            digitalWrite(intervalWaitLEDPin, LOW);
            delay(1500);  //Error notification delay
        }
        #pragma endregion
        //Baby detection block end


}




