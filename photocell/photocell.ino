//TDG Photocell

int photocellpin = 1;
int photocellreading;

int buzzerpin = 11;

void setup(void){
  Serial.begin(9600);
  
}

void loop(void) {
  photocellreading = analogRead(photocellpin);
  Serial.print("Analog reading=");
  Serial.println(photocellreading);

  if (photocellreading>200) {
    analogWrite(buzzerpin, 255);
  }
  
  
}
