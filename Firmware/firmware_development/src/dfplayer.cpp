/*
Tracks sequence

0001 - Welcome
0002 - System init
0003 - wifi ok
0004 - wifi failed
0005 - db ok
0006 - db failed
0007 - checks ok
0008 - lullaby

*/

#include <Arduino.h>
#include <HardwareSerial.h>
#include <DFRobotDFPlayerMini.h>


#define DFPLAYER_RX 18  // ESP32-S3 RX pin connected to MP3 TX (via 2.2k resistor)
#define DFPLAYER_TX 17  // ESP32-S3 TX pin connected to MP3 RX (through 1k resistor)


HardwareSerial mySerial(1);   // Use UART1 on ESP32-S3 for the DFPlayer
DFRobotDFPlayerMini myDFPlayer;

void init_Dfplayer()
{
 // Initialize the UART communication with the DFPlayer
  mySerial.begin(9600, SERIAL_8N1, DFPLAYER_RX, DFPLAYER_TX);

  // Check if the DFPlayer Mini is connected and responding
  if (!myDFPlayer.begin(mySerial)) {
    Serial.println("DFPlayer Mini not found! Check wiring, power, and SD card.");
    //while (true); // Halt execution if the player isn't found
  }

  Serial.println("DFPlayer Mini online.");

  myDFPlayer.volume(30);  // Set playback volume (0 to 30)
  
//  myDFPlayer.play(2);   
}