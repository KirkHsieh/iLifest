#include <SoftwareSerial.h>
#include <IRremote.h>

IRsend irsend;
SoftwareSerial ArduinoUno(5, 4); // RX | TX
const int IRPin = 3;                 // 繼電器(Relay)
int relayState = 0;   
int electricDeviceID; 
void setup() {
   digitalWrite(IRPin, HIGH);
  Serial.begin(9600);
  ArduinoUno.begin(4800);
  pinMode(IRPin, OUTPUT);          // 把 relayPin 設置成 OUTPUT 
}

void loop() {
  electricDeviceID = ArduinoUno.parseInt();
  if(ArduinoUno.available()) {
     execute();
  }
}

void execute() {
  if(electricDeviceID == 110) {  
    irsend.sendSony(0xa90, 32);
      do {
        electricDeviceID = ArduinoUno.parseInt();
        Serial.println(electricDeviceID);
      }while(electricDeviceID == 110 || electricDeviceID == 0);
    }
    else if(electricDeviceID == 111){
      irsend.sendSony(0xa60, 32);
      do {  
        electricDeviceID = ArduinoUno.parseInt();
        Serial.println(electricDeviceID);
      }while(electricDeviceID == 111 || electricDeviceID == 0);
    }
    else if(electricDeviceID == 101) {  
    irsend.sendSony(0xa80, 32);
      do {
        electricDeviceID = ArduinoUno.parseInt();
        Serial.println(electricDeviceID);
      }while(electricDeviceID == 101 || electricDeviceID == 0);
    }
    else {
      irsend.sendSony(0xa70, 32);
      do {  
        electricDeviceID = ArduinoUno.parseInt();
        Serial.println(electricDeviceID);
      }while(electricDeviceID == 100 || electricDeviceID == 0);
    }
    execute();
}
