#define MIC_PIN 2
#define CRY_LED_PIN 11
#define CHILL_LED_PIN 13

#define THRESHOLD 2500
#define DURATION_MS 5000
#define SAMPLE_INTERVAL 10
#define MIN_LOUD_COUNT 7

unsigned long monitoringStart = 0;
unsigned long lastSampleTime = 0;
int loudCount = 0;
bool monitoring = false;
unsigned long postCheckDelay = 5000;
unsigned long postCheckStart = 0;
bool inPostDelay = false;

void setup() {
  Serial.begin(115200);
  pinMode(MIC_PIN, INPUT);
  pinMode(CRY_LED_PIN, OUTPUT);
  pinMode(CHILL_LED_PIN, OUTPUT);
}

void loop() {
  unsigned long currentTime = millis();

  if (!monitoring && !inPostDelay) {
    monitoringStart = currentTime;
    lastSampleTime = currentTime;
    loudCount = 0;
    monitoring = true;
  }

  if (monitoring && (currentTime - lastSampleTime >= SAMPLE_INTERVAL)) {
    lastSampleTime = currentTime;
    int soundLevel = analogRead(MIC_PIN);
    if (soundLevel > THRESHOLD) {
      loudCount++;
    }
  }

  if (monitoring && (currentTime - monitoringStart >= DURATION_MS)) {
    monitoring = false;
    inPostDelay = true;
    postCheckStart = currentTime;

    if (loudCount >= MIN_LOUD_COUNT) {
      Serial.println("Baby is crying!");
      digitalWrite(CRY_LED_PIN, HIGH);
      digitalWrite(CHILL_LED_PIN, LOW);
    } else {
      Serial.println("No crying detected.");
      digitalWrite(CRY_LED_PIN, LOW);
      digitalWrite(CHILL_LED_PIN, HIGH);
    }
  }

  if (inPostDelay && (currentTime - postCheckStart >= postCheckDelay)) {
    inPostDelay = false;
  }
}
