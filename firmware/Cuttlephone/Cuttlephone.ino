/*
 * Developed using Sparkfun Pro Micro 5v USB-c
 * 
 */
#include "Joystick.h" //https://github.com/MHeironimus/ArduinoJoystickLibrary/
#include <Keypad_I2C.h> // I2C Keypad library by Joe Young https://github.com/joeyoung/arduino_keypads

Joystick_ Joystick(JOYSTICK_DEFAULT_REPORT_ID, JOYSTICK_TYPE_MULTI_AXIS, 16, 0, true, true, true, false, false, true, false, false, true, true, false);

// Define the keypad pins
const byte ROWS = 3; 
const byte COLS = 3;

#define keypadAddrL 0x20  // I2C address of I2C Expander module (A0-A1-A2 dip switch to off position)
char keysLeft[ROWS][COLS] = {
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
};

#define keypadAddrR 0x20  // I2C address of I2C Expander module (A0-A1-A2 dip switch to on position)
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
  
  Joystick.setXAxisRange(0, 1023);
  Joystick.setYAxisRange(0, 1023);
  Joystick.setZAxisRange(0, 1023);
  Joystick.setRzAxisRange(0, 1023);
  Joystick.begin();

  I2C_KeypadL.begin();
  I2C_KeypadR.begin();
}

void loop() {

  //Joysticks
  Joystick.setXAxis(analogRead(A0));
  Joystick.setYAxis(analogRead(A1));
  Joystick.setZAxis(analogRead(A2));
  Joystick.setRzAxis(analogRead(A3));

  //Read buttons
  char keyL = I2C_KeypadL.getKey();
  char keyR = I2C_KeypadR.getKey();

  //delay(50);
}

void readMatrix() {
    // iterate the columns
    for (int colIndex=0; colIndex < colCount; colIndex++) {
        // col: set to output to low
        byte curCol = cols[colIndex];
        pinMode(curCol, OUTPUT);
        digitalWrite(curCol, LOW);
 
        // row: interate through the rows
        for (int rowIndex=0; rowIndex < rowCount; rowIndex++) {
            byte rowCol = rows[rowIndex];
            pinMode(rowCol, INPUT_PULLUP);
            int currentButtonState = digitalRead(rowCol);
            //keysLast[colIndex][rowIndex] = digitalRead(rowCol);

            if(colIndex == 0 && rowIndex == 0){       // Start
              Joystick.setButton(0, currentButtonState);
            }else if(colIndex == 0 && rowIndex == 1){ // Select
              Joystick.setButton(1, currentButtonState);
              
            }else if(colIndex == 0 && rowIndex == 2){ // A
              Joystick.setButton(2, currentButtonState);
            }else if(colIndex == 0 && rowIndex == 3){ // B
              Joystick.setButton(3, currentButtonState);
            }else if(colIndex == 1 && rowIndex == 0){ // X
              Joystick.setButton(4, currentButtonState);
            }else if(colIndex == 1 && rowIndex == 1){ // Y
              Joystick.setButton(5, currentButtonState);
            }else if(colIndex == 1 && rowIndex == 2){ // L1
              Joystick.setButton(6, currentButtonState);
            }else if(colIndex == 1 && rowIndex == 3){ // L2
              Joystick.setButton(7, currentButtonState);
            }else if(colIndex == 2 && rowIndex == 0){ // L3
              Joystick.setButton(8, currentButtonState);
            }else if(colIndex == 2 && rowIndex == 1){ // R1
              Joystick.setButton(9, currentButtonState);
            }else if(colIndex == 2 && rowIndex == 2){ // R2
              Joystick.setButton(10, currentButtonState);
            }else if(colIndex == 2 && rowIndex == 3){ // R3
              Joystick.setButton(11, currentButtonState);
            }else if(colIndex == 3 && rowIndex == 0){ // UP
              Joystick.setButton(12, currentButtonState);
              //Joystick.setHatSwitch(0, 0);
            }else if(colIndex == 3 && rowIndex == 1){ // Down
              Joystick.setButton(13, currentButtonState);
              //Joystick.setHatSwitch(0, 90);
            }else if(colIndex == 3 && rowIndex == 2){ // Left
              Joystick.setButton(14, currentButtonState);
              //Joystick.setHatSwitch(0, 180);
            }else if(colIndex == 3 && rowIndex == 3){ // Right
              Joystick.setButton(15, currentButtonState);
              //Joystick.setHatSwitch(0, 270);
            }
            pinMode(rowCol, INPUT);
        }
        // disable the column
        pinMode(curCol, INPUT);
    }
}
