// This will handle AP mode and STA mode of ESP before and after saving wifi credentials.
// The library used also handles the Captive Portal which is the main purpose of using it.

#include <Arduino.h>
#include <WiFiManager.h>
#include "dfplayer.h"


WiFiManager wm;

void init_Wifi_Connections()
{
    // wm.resetSettings(); //Deletes the saved wifi credentials. (Run once for testing purpose only)

    bool result = wm.autoConnect("CareNest", "carenest");   //Connected network credentials are stored in the variable.

    //Checks if connection was successful
    if(result)
    {
        Serial.println("Wifi connected!");
        Serial.print("IP Address: ");
        Serial.println(WiFi.localIP()); //Prints assigned IP
        
        myDFPlayer.play(3); //wifi ok
        delay(5000);

    }
    else
    {
        Serial.println("Failed to Connect!");
        ESP.restart(); // restarts the ESP which means re-executes setup() which means retries to establish connection.
        
        myDFPlayer.play(4);
        delay(10000);

        //If not connected again and again, ESP will keep restarting. Like a loop. Thats what this function does.
        
    }

}



// // This will handle AP mode and STA mode of ESP before and after saving wifi credentials.
// // The library used also handles the Captive Portal which is the main purpose of using it.

// #include <Arduino.h>
// #include <WiFiManager.h>
// #include "dfplayer.h"


// WiFiManager wm;
// // String cradleId = "";

// void generateCradleId() {
//     uint64_t chipid = ESP.getEfuseMac();  // Unique ESP32 ID

//     String part1 = String((uint16_t)(chipid >> 32), HEX);
//     String part2 = String((uint32_t)chipid, HEX);

//     // cradleId = "CareNestCradle_";
//     // cradleId.concat(part1);
//     // cradleId.concat(part2);
// }

// void showCradleInfo() {
//     String page = "<!DOCTYPE html><html><head><title>Cradle Info</title></head><body>";
//     page += "<h2>Welcome to CareNest</h2>";
//     // page += "<p><strong>Your Cradle ID:</strong><br><code>" + cradleId + "</code></p>";
//     page += "<p>Please open the CareNest app and enter this ID to link your cradle.</p>";
//     page += "<p><a href='/'>Back to WiFi Setup</a></p>";
//     page += "</body></html>";

//     wm.server->send(200, "text/html", page);
// }

// void init_Wifi_Connections()
// {
//     generateCradleId();  // Step 1: Generate ID
//   // Optional: Print it for debugging
//     // Serial.println("Cradle ID: " + cradleId);
//     wm.setAPCallback([](WiFiManager* wm) {
//         Serial.println("Access Point started");
//         Serial.println("Visit http://192.168.4.1/cradle to view Cradle ID");
//          if (wm->server) {
//         wm->server->on("/cradle", showCradleInfo);  // Now safe
//         } else {
//             Serial.println("ERROR: Web server not initialized!");
//         }
//     });
//     // wm.server->on("/cradle", showCradleInfo);  // Step 2: Custom page

//     // wm.resetSettings(); //Deletes the saved wifi credentials. (Run once for testing purpose only)

//     bool result = wm.autoConnect("CareNest", "carenest");   //Connected network credentials are stored in the variable.

//     //Checks if connection was successful
//     if(result)
//     {
//         Serial.println("Wifi connected!");
//         Serial.print("IP Address: ");
//         Serial.println(WiFi.localIP()); //Prints assigned IP
        
//         myDFPlayer.play(3); //wifi ok
//         delay(5000);

//     }
//     else
//     {
//         Serial.println("Failed to Connect!");
//         ESP.restart(); // restarts the ESP which means re-executes setup() which means retries to establish connection.
        
//         myDFPlayer.play(4);
//         delay(10000);

//         //If not connected again and again, ESP will keep restarting. Like a loop. Thats what this function does.
        
//     }

// }

