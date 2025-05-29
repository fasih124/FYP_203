#ifndef DFPLAYER_MODULE_H
#define DFPLAYER_MODULE_H

#include <DFRobotDFPlayerMini.h> // Include the library here as well
#include <HardwareSerial.h>

extern DFRobotDFPlayerMini myDFPlayer;

// Declare the initialization function
void Init_Dfplayer();

#endif // DFPLAYER_MODULE_H