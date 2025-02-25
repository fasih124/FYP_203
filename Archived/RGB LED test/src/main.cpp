#include <Arduino.h>
#include <Adafruit_NeoPixel.h>

#define NEOPIXEL_PIN 48   // Built-in RGB LED pin (change if needed)
#define NUM_PIXELS 1      // Only one built-in LED

Adafruit_NeoPixel pixels(NUM_PIXELS, NEOPIXEL_PIN, NEO_GRB + NEO_KHZ800);

void setup() {
    pixels.begin();  // Initialize NeoPixel
    pixels.show();   // Turn off all pixels initially
}

void loop() {
    // Cycle through colors every 5 seconds
    pixels.setPixelColor(0, pixels.Color(255, 0, 0)); // Red
    pixels.show();
    delay(1000);

    pixels.setPixelColor(0, pixels.Color(0, 255, 0)); // Green
    pixels.show();
    delay(1000);

    pixels.setPixelColor(0, pixels.Color(0, 0, 255)); // Blue
    pixels.show();
    delay(1000);
}
