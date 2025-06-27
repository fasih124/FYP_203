#include <Arduino.h>
#include "dfplayer.h"


void file1()
{
    Serial.println("This is file 1");
    myDFPlayer.play(2);
}