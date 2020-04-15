#include <Keypad.h> //https://github.com/Chris--A/Keypad
#include <Key.h>
#include "Joystick.h" //https://github.com/MHeironimus/ArduinoJoystickLibrary/
#include <Keypad_I2C.h> // I2C Keypad library by Joe Young https://github.com/joeyoung/arduino_keypads

/*
 * Developed using Sparkfun Pro Micro 5v USB-c
 * 
 */
Joystick_ Joystick(JOYSTICK_DEFAULT_REPORT_ID, JOYSTICK_TYPE_MULTI_AXIS, 16, 0, true, true, true, false, false, true, false, false, true, true, false);

// Define the keypad pins
const byte ROWS = 3; 
const byte COLS = 3;

#define keypadAddrL 0x38  // I2C address of I2C Expander module (A0-A1-A2 dip switch to off position)
char keysLeft[ROWS][COLS] = {
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
};

#define keypadAddrR 0x39  // I2C address of I2C Expander module (A0-A1-A2 dip switch to on position)
char keysRight[ROWS][COLS] = {
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
};

// Keypad pins connected to the I2C-Expander pins P0-P5
byte rowPinsLeft[ROWS] = {0, 1, 2}; // connect to the row pinouts of the keypad
byte colPinsLeft[COLS] = {3, 4, 5};    // connect to the column pinouts of the keypad

// Keypad pins connected to the I2C-Expander pins P0-P5
byte rowPinsRight[ROWS] = {0, 1, 2}; // connect to the row pinouts of the keypad
byte colPinsRight[COLS] = {3, 4, 5};    // connect to the column pinouts of the keypad

// Create instance of the Keypad name I2C_Keypad and using the PCF8574 chip
Keypad_I2C I2C_KeypadL( makeKeymap(keysLeft), rowPinsLeft, colPinsLeft, ROWS, COLS, keypadAddrL, PCF8574 );
Keypad_I2C I2C_KeypadR( makeKeymap(keysRight), rowPinsRight, colPinsRight, ROWS, COLS, keypadAddrR, PCF8574 );

unsigned long loopCount;
unsigned long startTime;
String msg;

void setup() {
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB
  }
  
  //Init joysticks
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
  pinMode(A3, INPUT);
  
  Serial.print("Begin Joystick\n");
  
  Joystick.setXAxisRange(0, 1023);
  Joystick.setYAxisRange(0, 1023);
  Joystick.setZAxisRange(0, 1023);
  Joystick.setRzAxisRange(0, 1023);
  Joystick.begin();

  Serial.print("Begin keypads\n");

  I2C_KeypadL.begin();
  //I2C_KeypadR.begin();

  //Status led
  I2C_KeypadL.pin_mode(7,1);
  //I2C_KeypadR.pin_mode(7,1);
  I2C_KeypadL.pin_write(7,1);
  //I2C_KeypadR.pin_write(7,1);
  
  Serial.print("Active\n");


loopCount = 0;
    startTime = millis();
  msg = "";
}

void loop() {

  loopCount++;
    if ( (millis()-startTime)>5000 ) {
        Serial.print("Average loops per second = ");
        Serial.println(loopCount/5);
        startTime = millis();
        loopCount = 0;
    }

  //Joysticks
  Joystick.setXAxis(analogRead(A0));
  Joystick.setYAxis(analogRead(A1));
  Joystick.setZAxis(analogRead(A2));
  Joystick.setRzAxis(analogRead(A3));

  
  Serial.println(I2C_KeypadL.pin_read(0));
  Serial.println(I2C_KeypadL.pin_read(1));
  Serial.println(I2C_KeypadL.pin_read(2));
  Serial.println(I2C_KeypadL.pin_read(3));
  Serial.println(I2C_KeypadL.pin_read(4));
  Serial.println(I2C_KeypadL.pin_read(5));
  Serial.println(I2C_KeypadL.pin_read(6));
  Serial.println(I2C_KeypadL.pin_read(7));

  // Fills kpd.key[ ] array with up-to 10 active keys.
  // Returns true if there are ANY active keys.
  if (I2C_KeypadL.getKeys())
  {
      for (int i=0; i<LIST_MAX; i++)   // Scan the whole key list.
      {
          if ( I2C_KeypadL.key[i].stateChanged )   // Only find keys that have changed state.
          {
              switch (I2C_KeypadL.key[i].kstate) {  // Report active key state : IDLE, PRESSED, HOLD, or RELEASED
                  case PRESSED:
                  msg = " PRESSED.";
              break;
                  case HOLD:
                  msg = " HOLD.";
              break;
                  case RELEASED:
                  msg = " RELEASED.";
              break;
                  case IDLE:
                  msg = " IDLE.";
              }
              Serial.print("Key ");
              Serial.print(I2C_KeypadL.key[i].kchar);
              Serial.println(msg);
              msg="";
          }
      }
  }

  //delay(20);
}

//void readMatrix() {
//    // iterate the columns
//    for (int colIndex=0; colIndex < colCount; colIndex++) {
//        // col: set to output to low
//        byte curCol = cols[colIndex];
//        pinMode(curCol, OUTPUT);
//        digitalWrite(curCol, LOW);
// 
//        // row: interate through the rows
//        for (int rowIndex=0; rowIndex < rowCount; rowIndex++) {
//            byte rowCol = rows[rowIndex];
//            pinMode(rowCol, INPUT_PULLUP);
//            int currentButtonState = digitalRead(rowCol);
//            //keysLast[colIndex][rowIndex] = digitalRead(rowCol);
//
//            if(colIndex == 0 && rowIndex == 0){       // Start
//              Joystick.setButton(0, currentButtonState);
//            }else if(colIndex == 0 && rowIndex == 1){ // Select
//              Joystick.setButton(1, currentButtonState);
//              
//            }else if(colIndex == 0 && rowIndex == 2){ // A
//              Joystick.setButton(2, currentButtonState);
//            }else if(colIndex == 0 && rowIndex == 3){ // B
//              Joystick.setButton(3, currentButtonState);
//            }else if(colIndex == 1 && rowIndex == 0){ // X
//              Joystick.setButton(4, currentButtonState);
//            }else if(colIndex == 1 && rowIndex == 1){ // Y
//              Joystick.setButton(5, currentButtonState);
//            }else if(colIndex == 1 && rowIndex == 2){ // L1
//              Joystick.setButton(6, currentButtonState);
//            }else if(colIndex == 1 && rowIndex == 3){ // L2
//              Joystick.setButton(7, currentButtonState);
//            }else if(colIndex == 2 && rowIndex == 0){ // L3
//              Joystick.setButton(8, currentButtonState);
//            }else if(colIndex == 2 && rowIndex == 1){ // R1
//              Joystick.setButton(9, currentButtonState);
//            }else if(colIndex == 2 && rowIndex == 2){ // R2
//              Joystick.setButton(10, currentButtonState);
//            }else if(colIndex == 2 && rowIndex == 3){ // R3
//              Joystick.setButton(11, currentButtonState);
//            }else if(colIndex == 3 && rowIndex == 0){ // UP
//              Joystick.setButton(12, currentButtonState);
//              //Joystick.setHatSwitch(0, 0);
//            }else if(colIndex == 3 && rowIndex == 1){ // Down
//              Joystick.setButton(13, currentButtonState);
//              //Joystick.setHatSwitch(0, 90);
//            }else if(colIndex == 3 && rowIndex == 2){ // Left
//              Joystick.setButton(14, currentButtonState);
//              //Joystick.setHatSwitch(0, 180);
//            }else if(colIndex == 3 && rowIndex == 3){ // Right
//              Joystick.setButton(15, currentButtonState);
//              //Joystick.setHatSwitch(0, 270);
//            }
//            pinMode(rowCol, INPUT);
//        }
//        // disable the column
//        pinMode(curCol, INPUT);
//    }
//}
