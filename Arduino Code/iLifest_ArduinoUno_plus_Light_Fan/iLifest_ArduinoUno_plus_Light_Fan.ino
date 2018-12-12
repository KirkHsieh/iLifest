#include <SoftwareSerial.h>
#include <ESP8266WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"

#define WIFI_SSID "csim403"
#define WIFI_PASS "pucsim403"

#define MQTT_SERV "io.adafruit.com"
#define MQTT_PORT 1883
#define MQTT_NAME "pucsie2019"
#define MQTT_PASS "448b9ff8e1a146429b36aa06a3b3303d"

//Set up MQTT and WiFi clients
WiFiClient client;
Adafruit_MQTT_Client mqtt(&client, MQTT_SERV, MQTT_PORT, MQTT_NAME, MQTT_PASS);

//Set up the feed you're subscribing to
Adafruit_MQTT_Subscribe dinningroomonoff = Adafruit_MQTT_Subscribe(&mqtt, MQTT_NAME "/f/dinningroomonoff");
Adafruit_MQTT_Subscribe livingroomonoff = Adafruit_MQTT_Subscribe(&mqtt, MQTT_NAME "/feeds/livingroomonoff");
Adafruit_MQTT_Subscribe bedroomonoff = Adafruit_MQTT_Subscribe(&mqtt, MQTT_NAME "/feeds/bedroomonoff");
Adafruit_MQTT_Subscribe kitchenonoff = Adafruit_MQTT_Subscribe(&mqtt, MQTT_NAME "/feeds/kitchenonoff");
Adafruit_MQTT_Subscribe toiletonoff = Adafruit_MQTT_Subscribe(&mqtt, MQTT_NAME "/feeds/toiletonoff");
Adafruit_MQTT_Subscribe fanonoff = Adafruit_MQTT_Subscribe(&mqtt, MQTT_NAME "/feeds/fanonoff");
Adafruit_MQTT_Subscribe allonoff = Adafruit_MQTT_Subscribe(&mqtt, MQTT_NAME "/feeds/allonoff");

SoftwareSerial NodeMCU(D5, D6);
void setup()
{
  
  Serial.begin(9600);
  NodeMCU.begin(4800);
  //Connect to WiFi
  Serial.print("\n\nConnecting Wifi... ");
  WiFi.begin(WIFI_SSID, WIFI_PASS);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
  }

  Serial.println("OK!");

  //Subscribe to the onoff feed
  mqtt.subscribe(&dinningroomonoff);
  mqtt.subscribe(&livingroomonoff);
  mqtt.subscribe(&bedroomonoff);
  mqtt.subscribe(&kitchenonoff);
  mqtt.subscribe(&toiletonoff);
  mqtt.subscribe(&fanonoff); 
  mqtt.subscribe(&allonoff); 

  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, HIGH);
}

void loop()
{
  MQTT_connect();
  int ledPin_D0 = 16;
  pinMode(ledPin_D0,OUTPUT);
  int ledPin_D1 = 5;
  pinMode(ledPin_D1,OUTPUT);
  int ledPin_D2 = 4;
  pinMode(ledPin_D2,OUTPUT);
  int ledPin_D3 = 0;
  pinMode(ledPin_D3,OUTPUT);
  int ledPin_D4 = 2;
  pinMode(ledPin_D4,OUTPUT);
  int ledPin_D7 = 13;
  pinMode(ledPin_D7,OUTPUT);

  digitalWrite(ledPin_D0, HIGH);
  digitalWrite(ledPin_D1, HIGH);
  digitalWrite(ledPin_D2, HIGH);
  digitalWrite(ledPin_D3, HIGH);
  digitalWrite(ledPin_D4, HIGH);
  digitalWrite(ledPin_D7, HIGH);

  do {
    //Read from our subscription queue until we run out, or
    //wait up to 5 seconds for subscription to update
    Adafruit_MQTT_Subscribe * subscription;
    
    while ((subscription = mqtt.readSubscription(5000)))
    {
      //If we're in here, a subscription updated...
      if (subscription == & allonoff)
      {
        //Print the new value to the serial monitor
        Serial.print("allonoff: ");
        Serial.println((char*) allonoff.lastread);
        
        //If the new value is  "ON", turn the light on.
        //Otherwise, turn it off.
        if (!strcmp((char*) allonoff.lastread, "ON"))
        {
          //Active low logic
          digitalWrite(ledPin_D0, LOW);
          digitalWrite(ledPin_D1, LOW);
          digitalWrite(ledPin_D2, LOW);
          digitalWrite(ledPin_D3, LOW);
          digitalWrite(ledPin_D4, LOW);
          digitalWrite(ledPin_D7, LOW);
        }
        else
        {
          digitalWrite(ledPin_D0, HIGH);
          digitalWrite(ledPin_D1, HIGH);
          digitalWrite(ledPin_D2, HIGH);
          digitalWrite(ledPin_D3, HIGH);
          digitalWrite(ledPin_D4, HIGH);
          digitalWrite(ledPin_D7, HIGH);
        }
      }
      
      if (subscription == & dinningroomonoff)
      {
        //Print the new value to the serial monitor
        Serial.print("dinningroomonoff: ");
        Serial.println((char*) dinningroomonoff.lastread);
        
        //If the new value is  "ON", turn the light on.
        //Otherwise, turn it off.
        if (!strcmp((char*) dinningroomonoff.lastread, "ON"))
        {
          //Active low logic
          digitalWrite(ledPin_D0, LOW);
        }
        else
        {
          digitalWrite(ledPin_D0, HIGH);
        }
      }
  
      if (subscription == & livingroomonoff)
      {
        //Print the new value to the serial monitor
        Serial.print("livingRoomOnOff: ");
        Serial.println((char*) livingroomonoff.lastread);
        
        //If the new value is  "ON", turn the light on.
        //Otherwise, turn it off.
        if (!strcmp((char*) livingroomonoff.lastread, "ON"))
        {
          //Active low logic
          digitalWrite(ledPin_D1, LOW);
        }
        else
        {
          digitalWrite(ledPin_D1, HIGH);
        }
      }
  
      if (subscription == & bedroomonoff)
      {
        //Print the new value to the serial monitor
        Serial.print("bedroomonoff: ");
        Serial.println((char*) bedroomonoff.lastread);
        
        //If the new value is  "ON", turn the light on.
        //Otherwise, turn it off.
        if (!strcmp((char*) bedroomonoff.lastread, "ON"))
        {
          //Active low logic
          digitalWrite(ledPin_D2, LOW);
        }
        else
        {
          digitalWrite(ledPin_D2, HIGH);
        }
      }
  
      if (subscription == & kitchenonoff)
      {
        //Print the new value to the serial monitor
        Serial.print("kitchenonoff: ");
        Serial.println((char*) kitchenonoff.lastread);
        
        //If the new value is  "ON", turn the light on.
        //Otherwise, turn it off.
        if (!strcmp((char*) kitchenonoff.lastread, "ON"))
        {
          //Active low logic
          digitalWrite(ledPin_D3, LOW);
        }
        else
        {
          digitalWrite(ledPin_D3, HIGH);
        }
      }
  
      if (subscription == & toiletonoff)
      {
        //Print the new value to the serial monitor
        Serial.print("toiletonoff: ");
        Serial.println((char*) toiletonoff.lastread);
        
        //If the new value is  "ON", turn the light on.
        //Otherwise, turn it off.
        if (!strcmp((char*) toiletonoff.lastread, "ON"))
        {
          //Active low logic
          digitalWrite(ledPin_D4, LOW);
        }
        else
        {
          digitalWrite(ledPin_D4, HIGH);
        }
      }
  
      if (subscription == & fanonoff)
      {
        //Print the new value to the serial monitor
        Serial.print("fanonoff: ");
        Serial.println((char*) fanonoff.lastread);
  //      int fanSpeedValue = atoi((char*)fanonoff.lastread);
        
        if (!strcmp((char*) fanonoff.lastread, "ON"))
        {
          //Active low logic
          digitalWrite(ledPin_D7, LOW);
        }
        else
        {
          digitalWrite(ledPin_D7, HIGH);
        }
      }
      
  //      if (fanSpeedValue == 0)
  //      {
  //        //Active low logic
  //        int i = 1;
  //        NodeMCU.println(i);
  //        delay(30);
  //      }
  //      else if (fanSpeedValue == 85)
  //      {
  //        int i = 85;
  //        NodeMCU.println(i);
  //        delay(30);
  //      }
  //      else if (fanSpeedValue == 170)
  //      {
  //        int i = 170;
  //        NodeMCU.println(i);
  //        delay(30);
  //      }
  //      else if (fanSpeedValue == 255)
  //      {
  //        int i = 255;
  //        NodeMCU.println(i);
  //        delay(30);
  //      }
  //      else {
  //        Serial.print("program wrong");
  //      }
  //    }
      
    }
  
    // ping the server to keep the mqtt connection alive
    if (!mqtt.ping())
    {
      mqtt.disconnect();
    }
  }while(true);
}


/***************************************************
  Adafruit MQTT Library ESP8266 Example

  Must use ESP8266 Arduino from:
    https://github.com/esp8266/Arduino

  Works great with Adafruit's Huzzah ESP board & Feather
  ----> https://www.adafruit.com/product/2471
  ----> https://www.adafruit.com/products/2821

  Adafruit invests time and resources providing this open source code,
  please support Adafruit and open-source hardware by purchasing
  products from Adafruit!

  Written by Tony DiCola for Adafruit Industries.
  MIT license, all text above must be included in any redistribution
 ****************************************************/

void MQTT_connect() 
{
  int8_t ret;

  // Stop if already connected.
  if (mqtt.connected()) 
  {
    return;
  }

  Serial.print("Connecting to MQTT... ");

  uint8_t retries = 3;
  while ((ret = mqtt.connect()) != 0) // connect will return 0 for connected
  { 
       Serial.println(mqtt.connectErrorString(ret));
       Serial.println("Retrying MQTT connection in 5 seconds...");
       mqtt.disconnect();
       delay(5000);  // wait 5 seconds
       retries--;
       if (retries == 0) 
       {
         // basically die and wait for WDT to reset me
         while (1);
       }
  }
  Serial.println("MQTT Connected!");
}


