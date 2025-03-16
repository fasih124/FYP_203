// This will handle AP mode and STA mode of ESP before and after saving wifi credentials.
// The library used also handles the Captive Portal which is the main purpose of using it.

#include <Arduino.h>
#include <WiFiManager.h>

WiFiManager wm;

void init_Wifi_Connections()
{
    // wm.resetSettings(); //Deletes the saved wifi credentials. (Run once for testing purpose only)

    bool result = wm.autoConnect("CareNest", "carenest");   //Connected network credentials are storede in the variable.

    //Checks if connection was successful
    if(result)
    {
        Serial.println("Wifi connected!");
        Serial.print("IP Address: ");
        Serial.println(WiFi.localIP()); //Prints assigned IP

    }
    else
    {
        Serial.println("Failed to Connect!");
        ESP.restart(); // restarts the ESP which means re-executes setup() which means retries to establish connection.
        
        //If not connected again and again, ESP will keep restarting. Like a loop. Thats what this function does.
        
    }

}