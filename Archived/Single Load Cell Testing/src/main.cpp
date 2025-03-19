#include <HX711.h>  // Load cell amplifier library

// Define pins for HX711 (you are using ESP32-S3-WROOM-1 N16R8)
#define DT_PIN 36  // Data pin
#define SCK_PIN 37 // Clock pin

HX711 scale;

float scaleFactor = 101.0;  // Example: Replace with your calibrated value

void setup() {
  Serial.begin(115200);

  // Initialize HX711 with defined pins
  scale.begin(DT_PIN, SCK_PIN);

  // Optional: Reset the scale (if previously powered)
  scale.set_scale();
  scale.tare();  // Set zero weight baseline

  Serial.println("HX711 initialized. Starting calibration...");

  // Tare (zero offset)
  Serial.print("Taring... ");
  scale.tare();  // Remove any residual value
  Serial.println("Done.");

  // Optional: Show raw value (for calibration)
  Serial.println("Place a known weight and press any key in Serial Monitor...");
  while (!Serial.available());  // Wait for user input
  Serial.read();  // Clear input

  long reading = scale.get_units(10);  // Average 10 readings
  Serial.print("Raw Reading: ");
  Serial.println(reading);

  Serial.println("Calculate scale factor: scale_factor = raw_reading / known_weight_in_grams");
  Serial.println("Replace 'scaleFactor' in code and re-upload for accurate grams output.");
  
  // Apply existing scaleFactor for test
  scale.set_scale(scaleFactor);  // Apply scale factor (update after calibration)
}

void loop() {
  float weight = scale.get_units(5);  // Average 5 readings for stability
  Serial.print("Weight (g): ");
  Serial.println(weight);
  delay(500);  // Delay for readability
}
