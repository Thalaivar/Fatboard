#include <WiFiServerSecure.h>
#include <WiFiClientSecure.h>
#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>
#include <WiFiUdp.h>
#include <ESP8266WiFiType.h>
#include <ESP8266WiFiAP.h>
#include <WiFiClient.h>
#include <WiFiServer.h>
#include <ESP8266WiFiScan.h>
#include <ESP8266WiFiGeneric.h>
#include <ESP8266WiFiSTA.h>

#define port 345
#define CONN_MSG -45

const char *ssid = "Fatboard";
const char *password = "fatboardisbae";

typedef enum conn_stat {
  NO_CONN = 0,
  PHON_CONN = 1,
  CONN_VER = 2
} conn_status;

conn_status connection = NO_CONN;
bool hotspot  = false;
int16_t speedValue = 1000;

WiFiServer board(port);
WiFiClient phone;

void setup() {
  Serial.begin(115200);
  setupWiFi();

  if(hotspot) {
    board.begin();
  }

  Serial.println("WiFi began!");
}

void loop() {
  while(connection != CONN_VER) checkConnection();

  while(connection == CONN_VER){
    if(!phone.connected()) killBoard();
    else{
      int msg_size = phone.available();
      yield();
      if(msg_size > 0){
        byte value_msg[2];
        msg_size = phone.readBytes(value_msg, msg_size);
        speedValue = (value_msg[1] << 8) | value_msg[0];
        Serial.println(speedValue);
      }
    }
  }
}

void setupWiFi() {
  hotspot = WiFi.softAP(ssid, password);
}

void checkConnection() {
  if(connection == NO_CONN) {
    phone = board.available();
    if(phone) {
      connection = PHON_CONN;
      Serial.println("Phone connected...");
      
      while(phone.connected() && connection == PHON_CONN){
        int msg_size = phone.available();
        if(msg_size > 0){
          byte conn_msg_raw[2];
          msg_size = phone.readBytes(conn_msg_raw, msg_size);
          yield();
          int16_t conn_msg = (conn_msg_raw[1] << 8) | conn_msg_raw[0];
          if(conn_msg == CONN_MSG){
            connection = CONN_VER;
            phone.write("V");
          }
          phone.flush();
        }
      }
    }
  }
}

void killBoard(){
  connection = NO_CONN;
  speedValue = 1000;
  Serial.println("KILL");
}

