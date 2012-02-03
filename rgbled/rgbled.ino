/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */

int pin1 = 11;
int pin2 = 10;
int pin3 = 9;
int pin4 = 8; //pin of buzzer
int brightness = 255;
int fadeAmount = 1;
int color = 0; //0 blue //1 green 2//red
byte inputfromcomp;
void setup() {                
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
     Serial.begin(9600);
}

void loop() {
  
    Serial.println(inputfromcomp);
  // check if data has been sent from the computer:
  if (Serial.available()) {
  // read the most recent byte (which will be from 0 to 255):
    brightness = Serial.read();
    // set the brightness of the LED:
    if (inputfromcomp==97) brightness = 0 ;
);
    }
    
    
  switch(color) {
    case 0:
    analogWrite(pin1,brightness);
    analogWrite(pin2,0);
    analogWrite(pin3,0);
    break;
    
    case 1:
    analogWrite(pin1,0);
    analogWrite(pin2,brightness);
    analogWrite(pin3,0);
    break;
    
    case 2:
    analogWrite(pin1,0);
    analogWrite(pin2,0);
    analogWrite(pin3,brightness);
    break;
    
    case 3:
    color = 0;
    break;
    
  }
  
  fadeAmount += 1;
  if (fadeAmount > 350) {
   fadeAmount = 1;
   color += 1;
  }
  brightness -= fadeAmount;
  Serial.println(fadeAmount);
  if (brightness < 0){
    brightness = 255;
    
    
  }
  else if (brightness < 40) {
    analogWrite(pin4, 0);
  }
  else {
    analogWrite(pin4, 0);
    
  }
  delay(60);              // wait for a second
}
