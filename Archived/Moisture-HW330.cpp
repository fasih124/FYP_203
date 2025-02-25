int sensorValue;

void setup()
{
  Serial.begin(9600);
  pinMode(34, INPUT); // HW-330 Analog output to GPIO34
}

void loop()
{
  sensorValue = analogRead(34); // Read moisture level

  Serial.print("Moisture Level: ");
  Serial.println(sensorValue);
  
  delay(1000); // Wait 1 second before next reading
}
 
