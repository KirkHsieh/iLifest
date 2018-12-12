#include <IRremote.h>
#include <LiquidCrystal_I2C.h>  // 引用 LiquidCrystal 函式庫
#include <Wire.h>

LiquidCrystal_I2C lcd(0x27, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);
int RECV_PIN = 2;
IRrecv irrecv(RECV_PIN);

decode_results results;
int status = 0;
void setup()
{
  lcd.begin(16, 2);
  Serial.begin(9600);
  Serial.println("Enabling IRin");
  irrecv.enableIRIn(); // Start the receiver
  Serial.println("TV IR Decoder");
//  lcd.print("TV IR Decoder"); 
}

void loop() {
  
  //lcd.setCursor(0, 0);
  if (irrecv.decode(&results)) {
  Serial.println(results.value);
  unsigned long checkIRremote = results.value;
  receiveAndJudge(checkIRremote);
  irrecv.resume(); // Receive the next value
  delay(100);
  }
}
int receiveAndJudge(unsigned long value) {
//  lcd.clear();

  if (value == 2656) {
    lcd.setCursor(0, 0);
    lcd.print("TV ON Channel 23 "); 
  }else if(value == 2704){
    lcd.setCursor(0, 0);
    lcd.print("TV OFF          "); 
  }else if(value == 2688){
    lcd.setCursor(0, 1);
    lcd.print("AC ON Temp 26-C    ");
  }else if(value == 2672){
    lcd.setCursor(0, 1);
    lcd.print("AC OFF          "); 
  }
   irrecv.resume(); // Receive the next value
}
