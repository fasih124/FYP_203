#include <Arduino.h>
#include "dfplayer.h"


void file2()
{
    Serial.println("This is file 2");
    myDFPlayer.play(3);
}