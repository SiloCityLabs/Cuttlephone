/*
 * Developed using Sparkfun Pro Micro 5v USB-c
 * https://github.com/MHeironimus/ArduinoJoystickLibrary/
 */
#include "Joystick.h"

Joystick_ Joystick(JOYSTICK_DEFAULT_REPORT_ID, JOYSTICK_TYPE_MULTI_AXIS, 16, 0, true, true, true, false, false, true, false, false, true, true, false);

// JP1 is an input
byte rows[] = {2,3,4,5};
const int rowCount = sizeof(rows)/sizeof(rows[0]);
 
// JP2 and JP3 are outputs
byte cols[] = {6,7,8,9};
const int colCount = sizeof(cols)/sizeof(cols[0]);
 
//byte keysLast[colCount][rowCount];//Last State

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

  for(int x=0; x<rowCount; x++) {
      Serial.print(rows[x]); Serial.println(" as input");
      pinMode(rows[x], INPUT);
  }

  for (int x=0; x<colCount; x++) {
      Serial.print(cols[x]); Serial.println(" as input-pullup");
      pinMode(cols[x], INPUT_PULLUP);
  }
  
  // Init Button Pins
//  for (int index = 0; index < totalButtons; index++){
//    pinMode(buttons[index], INPUT_PULLUP);
//  }
}

void loop() {

  //Joysticks
  Joystick.setXAxis(analogRead(A0));
  Joystick.setYAxis(analogRead(A1));
  Joystick.setZAxis(analogRead(A2));
  Joystick.setRzAxis(analogRead(A3));

  //Read buttons
  readMatrix();

  delay(50);
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
