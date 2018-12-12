#include <SoftwareSerial.h>

SoftwareSerial ArduinoUno(3, 2); // RX | TX
const int relayPin = 8;                 // 繼電器(Relay)
int relayState = 0;   
int electricDeviceID; 
void setup() {
   digitalWrite(relayPin, HIGH);
  Serial.begin(9600);
  ArduinoUno.begin(4800);
  pinMode(relayPin, OUTPUT);             // 把 relayPin 設置成 OUTPUT 
}

void loop() {
  electricDeviceID = ArduinoUno.parseInt();
  if(ArduinoUno.available()) {
     execute();
  }
}

void execute() {
  if(electricDeviceID == 10) {  
      do {
        digitalWrite(relayPin, HIGH);
        electricDeviceID = ArduinoUno.parseInt();
        Serial.println(electricDeviceID);
      }while(electricDeviceID == 10 || electricDeviceID == 0);
    }
    else {
      do {
        digitalWrite(relayPin, LOW);
        electricDeviceID = ArduinoUno.parseInt();
        Serial.println(electricDeviceID);
      }while(electricDeviceID == 11 || electricDeviceID == 0);
    }
    execute();
}
