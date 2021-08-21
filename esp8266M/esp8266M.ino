#include <Arduino.h>
#include <ESP8266WiFi.h> 
#include <WebSocketsServer.h>
#include <Servo.h>


Servo servoMotor =2 ;

const char *ssid =  "ssid";  
const char *pass =  "123456789"; 

WebSocketsServer webSocket = WebSocketsServer(81);

void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length) {
    String cmd = "";
    switch(type) {
        case WStype_DISCONNECTED:
            Serial.println("Websocket is disconnected");
          
            break;
        case WStype_CONNECTED:{
            Serial.println("Websocket is connected");
            Serial.println(webSocket.remoteIP(num).toString());
            webSocket.sendTXT(num, "connected");}
            break;
        case WStype_TEXT:
            cmd = "";
            for(int i = 0; i < length; i++) {
                cmd = cmd + (char) payload[i]; 
            } 
            Serial.println(cmd);

            if(cmd == "poweron"){
                digitalWrite(servoMotor, 0);  
            }else if(cmd == "poweroff"){
                digitalWrite(servoMotor, 180);    
            }

             webSocket.sendTXT(num, cmd+":success");

            break;
        case WStype_FRAGMENT_TEXT_START:
            break;
        case WStype_FRAGMENT_BIN_START:
            break;
        case WStype_BIN:
            hexdump(payload, length);
            break;
        default:
            break;
    }
}



void setup() {
  pinMode(servoMotor, OUTPUT); 
   Serial.begin(9600); 

   Serial.println("Connecting to wifi");
   
   IPAddress apIP(192, 168, 0, 1);   
   WiFi.softAPConfig(apIP, apIP, IPAddress(255, 255, 255, 0)); 
   WiFi.softAP(ssid, pass); //turn on WIFI

   webSocket.begin(); 
  webSocket.onEvent(webSocketEvent); 
   Serial.println("Websocket is started");
}

void loop() {
   webSocket.loop();
}
