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

// #include <Arduino.h>
// #include <HX711.h>  // Load cell amplifier library

// // Define pins for HX711 (ESP32-S3-WROOM-1)
// #define DT_PIN 4  // Data pin
// #define SCK_PIN 7 // Clock pin

// HX711 scale;

// float scaleFactor = 101.0;  // Replace with your calibrated value

// void setup() {
//   Serial.begin(115200);

//   // Initialize HX711
//   scale.begin(DT_PIN, SCK_PIN);
//   scale.set_scale();
//   scale.tare();  // Zero baseline

//   Serial.println("HX711 initialized.");
// }

// void loop() {
//   if (scale.is_ready()) {  // Ensure HX711 is ready
//     float weight = scale.get_units(10) / 1000.0;  // Convert to kg
//     Serial.print("Weight (kg): ");
//     Serial.println(weight);
//   } else {
//     Serial.println("HX711 not ready...");
//   }
//   delay(200);
// }



#include <Arduino.h>
#include <HX711.h> // Include the HX711 library

// Define pins for HX711 (ESP32-S3-WROOM-1)
#define DT_PIN 4  // Data pin (DOUT) from HX711
#define SCK_PIN 7 // Clock pin (SCK) to HX711

// Create an HX711 object
HX711 scale;

void setup() {
  Serial.begin(115500); // Standard baud rate for Serial communication
  while(!Serial); // Wait for serial monitor to open

  Serial.println("Initializing HX711...");

  // Initialize the HX711 module with the defined pins
  scale.begin(DT_PIN, SCK_PIN);

  // Check if the HX711 is connected and responding
  if (scale.is_ready()) {
    Serial.println("HX711 is ready!");
    // You can also try to read a raw value immediately to confirm communication
    long initial_raw_value = scale.read();
    Serial.print("Initial Raw Value: ");
    Serial.println(initial_raw_value);
    Serial.println("Try pressing on the load cell and observe changes in 'Raw Value'.");
  } else {
    Serial.println("ERROR: HX711 not found or not ready.");
    Serial.println("Please check:");
    Serial.println("1. All wiring connections (DT, SCK, VCC, GND).");
    Serial.println("2. Power supply to the HX711 module (should be stable 3.3V from ESP32).");
    Serial.println("3. Load cell wiring to HX711.");
    Serial.println("4. If the HX711 module itself is faulty.");
    // In this test, we won't loop forever, but keep retrying in loop()
  }

  Serial.println("\n--- Starting Continuous Raw Value Readings ---");
}

void loop() {
  // Check if the HX711 is ready to send data
  if (scale.is_ready()) {
    // Read the raw analog-to-digital converter (ADC) value from the HX711.
    // This value is directly from the HX711's internal ADC, before any scaling or taring.
    long raw_value = scale.read(); // Read a single raw value

    Serial.print("Raw Value: ");
    Serial.println(raw_value/1000);

    // Add a small delay to not flood the serial monitor too quickly
    delay(100);
  } else {
    // If not ready, print an error and try to re-initialize (optional, but good for robust code)
    Serial.println("HX711 not ready... Retrying connection.");
    scale.begin(DT_PIN, SCK_PIN); // Attempt to re-begin (reset) the HX711
    delay(500); // Wait a bit before next attempt
  }
}