// #include <HX711.h>  // Load cell amplifier library

// // Define pins for HX711 (ESP32-S3-WROOM-1)
// #define DT_PIN 4  // Data pin
// #define SCK_PIN 7 // Clock pin

// // Define LED pins
// #define LED_HIGH 13  // LED when weight ≥ 200g
// #define LED_LOW 12   // LED when weight < 200g

// HX711 scale;

// float scaleFactor = 101.0;  // Replace with your calibrated value
// const int WEIGHT_THRESHOLD = 200000;  // Weight threshold in grams

// void setup() {
//   Serial.begin(115200);

//   // Initialize HX711
//   scale.begin(DT_PIN, SCK_PIN);
//   scale.set_scale();
//   scale.tare();  // Zero baseline

//   // Initialize LED pins
//   pinMode(LED_HIGH, OUTPUT);
//   pinMode(LED_LOW, OUTPUT);

//   Serial.println("HX711 initialized.");
// }

// void loop() {
//   if (scale.is_ready()) {  // Ensure HX711 is ready
//     float weight = scale.get_units(10);  // Average 10 readings for stability
//     Serial.print("Weight (g): ");
//     Serial.println(weight);

//     if (weight >= WEIGHT_THRESHOLD) {
//       digitalWrite(LED_HIGH, HIGH);
//       digitalWrite(LED_LOW, LOW);
//     } else {
//       digitalWrite(LED_HIGH, LOW);
//       digitalWrite(LED_LOW, HIGH);
//     }
//   } else {
//     Serial.println("HX711 not ready...");
//   }
//   delay(500);
// }


// -----------------------------------

#include <HX711.h>  // Load cell amplifier library

// Define pins for HX711 (ESP32-S3-WROOM-1)
#define DT_PIN 4  // Data pin
#define SCK_PIN 7 // Clock pin

HX711 scale;

float scaleFactor = 101.0;  // Replace with your calibrated value

void setup() {
  Serial.begin(115200);

  // Initialize HX711
  scale.begin(DT_PIN, SCK_PIN);
  scale.set_scale();
  scale.tare();  // Zero baseline

  Serial.println("HX711 initialized.");
}

void loop() {
  if (scale.is_ready()) {  // Ensure HX711 is ready
    float weight = scale.get_units(10) / 1000.0;  // Convert to kg
    Serial.print("Weight (kg): ");
    Serial.println(weight);
  } else {
    Serial.println("HX711 not ready...");
  }
  delay(200);
}
