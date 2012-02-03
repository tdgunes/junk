//SerialAlarm
//488 - 27 celsius
int photocellpin = 1;
int photocellreading;

int buzzerpin = 10;
int ledpin = 9;
int interval = 100;

int thermoresistor = 3;
int thermo;

float ratio = 488.0*27.0;
void setup(void){
  Serial.begin(9600);
  
}

void loop(void) {
  photocellreading = analogRead(photocellpin);
  thermo = analogRead(thermoresistor);
 // Serial.print("\r");
  //Serial.print(photocellreading);
 //Serial.print("\r");
  delay(60);  
  Serial.print("Photocell:");
  Serial.println(photocellreading);
  
   Serial.print("Thermo: ");
    Serial.print(ratio/thermo);
  Serial.println(" celsius");
  //Serial.println(interval);  
  
  //Whole animation thing
  if (photocellreading<=800) {
     interval -= 1;
    if (interval < 60){
        analogWrite(buzzerpin, 0);
        analogWrite(ledpin, 0);
    }
     else {
      analogWrite(buzzerpin, 255+interval);
        analogWrite(ledpin, 255);
    }
    if (interval == 0 ){
    
      interval = 100;
    }
  }
  else{
    analogWrite(ledpin, 255);
    analogWrite(buzzerpin, 0);
       
  }
  
}
