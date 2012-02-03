/*
    rgb led that colors with temperature
  
  With using analog input when input gets 488 accepts it as
  27 celsius. With this equation it just calculates the temperature
  and colors the rgb led
  
  created 02 02 2012 thursday
  by Taha Doğan Güneş

*/
int thermoresistor = 1;
float thermo;
float termo;
int pin1 = 11;
int pin2 = 10;
int pin3 = 9;
int color = 0; //0 red //1 green 2//blue
int delayint = 200; //default
float ratio = 488.0*27.0;
int brightness = 0;


char inputfromcomp[40];
int mint=0; //char adding int
char ichar; //adder char
int fint; //finished all can be usable in commands

int gotimpulse; //1 yes 0 no
void setup(void){
  Serial.begin(9600);
  pinMode(pin1, OUTPUT);   
  pinMode(pin2, OUTPUT);   
  pinMode(pin3, OUTPUT);   
}

void loop(void) {
  
      
  // check if data has been sent from the computer:
  if (Serial.available()) {
  // read the most recent byte (which will be from 0 to 255):
    ichar = (char)Serial.read();

    if (ichar == '-') {
         
    
          if (gotimpulse == 1){
                gotimpulse =0;
               // Serial.print("Response: ");
               // Serial.println(inputfromcomp);
               // Serial.println("-+- Stopped reading -+-\n");
                fint = 1;
                mint = 0;

              }
          else {
            for (int i=0; i<19; i++){
              inputfromcomp[i] = '\0';
                  
            }
            //Serial.println("-+- Started reading -+-");
            gotimpulse =1;
          }

    }
    
    if (gotimpulse == 1 && ichar != '-') { //let's make that char :)
    
        inputfromcomp[mint] = ichar;
        mint +=1;
     }
    

    // set the brightness of the LED:
   
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
    
  }
  thermo = analogRead(thermoresistor);
 // Serial.print("\r");
  //Serial.print(photocellreading);
 //Serial.print("\r");
 

  /*
  Serial.print("Thermo: ");
  Serial.print(ratio/thermo);
  Serial.println(" celsius");
  Serial.print("Brightness: ");
  Serial.println(brightness);
  */
  
  //Serial.println(interval);  
  termo=ratio/thermo;
  //Whole animation thing
  
  if (termo>30) { //too hot red 
    color=0;
  }
  else if (termo<20) { //freezing blue
    color=2;
  }
  else{ //good temprature green
    color=1;
  }

 if (fint == 1){

   String mystring = String(inputfromcomp);


   //write your own methods here:
   
   if (mystring=="stop") brightness = 0;
   if (mystring=="bright") brightness = 255;
   if (mystring=="add") brightness += 5;
   if (mystring=="ext") brightness -= 5;
   
   
   if (mystring=="delayadd") delayint += 40;
   if (mystring=="delayext") delayint -= 40;
   if (mystring=="delayzero") delayint =0;
   if (mystring=="showtemp") Serial.println(termo);
   fint = 0;
 } 
  delay(delayint);
}


/*

     String thisString = inputfromcomp;
     switch(thisString)
     {
        case "stop":
          brightness = 0;
          break;
      
        case "bright":
          brightness = 255;
          break;
      
        case "in":
          brightness = brightness + 10;
          break;

      
        case "optimum":
          brightness = 155;
          break;
      
        case "de":
          brightness = brightness - 10;
          break;
        case "temprature":
          Serial.print("Thermo: ");
          Serial.print(ratio/thermo);
          Serial.println(" celsius");
          break;
     }*/
