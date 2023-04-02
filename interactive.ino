int xyzPins[] = {12, 13, 15};
int xVal, yVal, zVal;

int lastState = 1; // the previous state from the button input 
int currentState; // the current reading from the button input

void setup() {
  Serial.begin(9600);
  pinMode(xyzPins[2], INPUT_PULLUP); // z axis is a button
  pinMode(25, INPUT_PULLUP); //button
}

void loop() {
  xVal = analogRead(xyzPins[0]);
  yVal = analogRead(xyzPins[1]);
  zVal = digitalRead(xyzPins[2]);
  currentState = digitalRead(25); 

  yVal = abs(4095 - yVal); 
  
  Serial.print(xVal);
  Serial.print(",");
  Serial.print(yVal);
  Serial.print(",");
  Serial.print(zVal); // joystick button value 
  Serial.print(",");
  if(lastState == 0 && currentState == 1){
    Serial.println(1); // 1 represent button pressed
  }else{
    Serial.println(0); // 0 represent button not pressed
  }
  
  // save the last state
  lastState = currentState; 
  delay(100);
}
