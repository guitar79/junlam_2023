#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include "Arduino.h"
#include "TeensyStep.h"
#define SCREEN_WIDTH 128 
#define SCREEN_HEIGHT 32 
#define OLED_RESET     -1 
#define SCREEN_ADDRESS 0x3C 
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

//버튼
const int stepPin = 16;
const int dirPin  = 15;
const int slpPin  = 17;
const int rstPin  = 7;
const int faultPin = 14;
const int rightPin = 11;
const int leftPin = 9;
const int upPin = 10;
const int downPin = 12;
const int menuMax = 5;

//이름
String menu[300];
int SelectedNum = 0;
int MenuNum[300];
int CurrentPage = 0;
int buttondel = 0;
//모터 관련
Stepper motor(stepPin, dirPin);
RotateControl rotatecontrol;
//파 관련
boolean waveset = false;
elapsedMillis timer = 0;
elapsedMillis intervalTimer = 0;
float MaxSpeed = 30000;
float Acceleration = 30000;

//리미트핀
const int lmtPin1 = 22;
const int lmtPin2 = 21;
boolean previousInit = false;
int leftEnd = 0;
int rightEnd = 0;
int MID = 0;

unsigned char codingarray [] PROGMEM = {
  //starting logo(skip)
};

void setup() {
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  display.clearDisplay();
  display.display();
  motor.setMaxSpeed(MaxSpeed);
  motor.setAcceleration(Acceleration);
  pinMode(rightPin,INPUT_PULLUP);
  pinMode(leftPin,INPUT_PULLUP);
  pinMode(upPin,INPUT_PULLUP);
  pinMode(downPin,INPUT_PULLUP);
  pinMode(slpPin, OUTPUT);
  pinMode(rstPin, OUTPUT);
  pinMode(lmtPin1,INPUT);
  pinMode(lmtPin2,INPUT);
  digitalWrite(slpPin, HIGH);
  digitalWrite(rstPin, HIGH);
  
  menu[1] = "Wave";
  menu[NUM(0)] = " Regular";
  menu[NUM(0,0)] = " Sin Wave";
  menu[NUM(0,0,0)] = " 0.8PI"; menu[NUM(0,0,1)] = " 1.0PI";
  menu[NUM(0,0,2)] = " 1.2PI"; menu[NUM(0,0,3)] = " 1.4PI";
  menu[NUM(0,0,4)] = " 2.0PI";
  menu[NUM(1)] = " Irregular";
  menu[NUM(1,0)] = " Tsunami";
  menu[NUM(2)] = " Button";
  MenuNum[1] = 3; 
  MenuNum[NUM(0)] = 1; 
  MenuNum[NUM(1)] = 1; 
  MenuNum[NUM(0,0)] = 5;
  while (!Serial && millis() < 1000);
  rotatecontrol.rotateAsync(motor);
  rotatecontrol.overrideSpeed(0);
}

void loop(){
  if(CurrentPage==0){
    startpage();
  }
  if(CurrentPage>=1){
    page();
  }
}