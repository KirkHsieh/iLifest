#include <SoftwareSerial.h>
#include <ESP8266WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"

#define WIFI_SSID "Yuc"
#define WIFI_PASS "hhshwifi"

#define MQTT_SERV "io.adafruit.com"
#define MQTT_PORT 1883
#define MQTT_NAME "pucsie2019"
#define MQTT_PASS "448b9ff8e1a146429b36aa06a3b3303d"

//Set up MQTT and WiFi clients
WiFiClient client;
Adafruit_MQTT_Client mqtt(&client, MQTT_SERV, MQTT_PORT, MQTT_NAME, MQTT_PASS);

//Set up the feed you're subscribing to
Adafruit_MQTT_Subscribe tvonoff = Adafruit_MQTT_Subscribe(&mqtt, MQTT_NAME "/f/tvonoff");
Adafruit_MQTT_Subscribe airconditioneronoff = Adafruit_MQTT_Subscribe(&mqtt, MQTT_NAME "/f/airconditioneronoff");
SoftwareSerial NodeMCU(D4, D5);

int setON = 0;
int setOFF = 0;
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
  mqtt.subscribe(&tvonoff);
  mqtt.subscribe(&airconditioneronoff);
  
  pinMode(D4, INPUT);
  pinMode(D5, OUTPUT);
}

void loop()
{
  
  MQTT_connect();
  int ledPin_D4 = 2;
  pinMode(ledPin_D4,INPUT);
  int ledPin_D5 = 14;
  pinMode(ledPin_D5,OUTPUT);
  
  //Read from our subscription queue until we run out, or
  //wait up to 5 seconds for subscription to update
  Adafruit_MQTT_Subscribe * subscription;
  
  while ((subscription = mqtt.readSubscription(5000)))
  {
    //If we're in here, a subscription updated...
    if (subscription == &tvonoff)
    {
      //Print the new value to the serial monitor
      Serial.print("TVOnOFF: ");
      Serial.println((char*) tvonoff.lastread);
      
      //If the new value is  "ON", turn the light on.
      //Otherwise, turn it off.
      if (!strcmp((char*) tvonoff.lastread, "ON"))
      {
          //Active low logic
          //Serial.println("testON");
          int i = 111;
          NodeMCU.println(i);
          delay(30);
      }
      else {
          //Serial.println("testOFF");
          int i = 110;
          NodeMCU.println(i);
          delay(30);
      }
    }

    if (subscription == &airconditioneronoff)
    {
      //Print the new value to the serial monitor
      Serial.print("TVOnOFF: ");
      Serial.println((char*) airconditioneronoff.lastread);
      
      //If the new value is  "ON", turn the light on.
      //Otherwise, turn it off.
      if (!strcmp((char*) airconditioneronoff.lastread, "ON"))
      {
          //Active low logic
          //Serial.println("testON");
          int i = 101;
          NodeMCU.println(i);
          delay(30);
      }
      else {
          //Serial.println("testOFF");
          int i = 100;
          NodeMCU.println(i);
          delay(30);
      }
    }
  }

  // ping the server to keep the mqtt connection alive
  if (!mqtt.ping())
  {
    mqtt.disconnect();
  }
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
