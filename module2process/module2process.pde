/*
Decoration game
By Winnie Chen
*/

import processing.serial.*;

final int w = 640; 
final int h = 480; 
final int T_SIZE = 64;

Serial myPort; // Create object from Serial class
PImage jianbing;   // Jianbing background image
PFont emoji;    // The emoji font

String[] toppings = {"\uD83E\uDD6C", "\ud83e\udd53", "\uD83E\uDD90", "\uD83C\uDF57"}; 
// lettuce, bacon, shrimp, chicken
int toppingIndex = 0; 

int xPos = 680/2;  // Starting position of the topping
int yPos = 480/2;

ArrayList<Topping> toppingsList = new ArrayList<>();

void setup() {
  background(255);
  size(640, 480);
  // List all the available serial ports
  String portName = Serial.list()[2];
  
  // Select and open the port
  myPort = new Serial(this, portName, 9600);
  
  // Load the jianbing and topping 
  jianbing = loadImage("jianbing.jpg"); 
  
  //load the topping
  emoji = createFont("Apple Color Emoji", 32);
  textFont(emoji);
  textAlign(CENTER, CENTER);
}

void draw() {
  image(jianbing, 0, 0, width, height); // Draw the pizza background

  // Draw the topping
  textSize(64);
  text(toppings[toppingIndex], xPos, yPos);
  
  for(Topping topping: toppingsList){
    int index = topping.index;
    PVector position = topping.position;
    text(toppings[index], position.x, position.y);
  }
  
  if (myPort.available() > 0) {
    String input = myPort.readStringUntil('\n');
    if (input != null) {
      // Split the input into x and y values
      String[] values = split(input, ',');
      int xVal = int(values[0].trim());
      int yVal = int(values[1].trim());
      int zVal = int(values[2].trim());
      int buttonPress = int(values[3].trim());
      
      // System.out.println(zVal);
      if(zVal==0){   // if joystick button pressed
        // add to toppingsList to leave the topping on canvas
        toppingsList.add(new Topping(toppingIndex, new PVector(xPos, yPos)));
      }
      // If button2 pressed 
      System.out.println(buttonPress);
      if(buttonPress == 1){
        toppingIndex = (toppingIndex + 1)%4;  // change toppings
      }
      
      // println(xVal); // around 2000
      // println(yVal); // around 2000
      
      if ( abs(xVal-2000)>100 || abs(yVal - 2000)>100 ) {
        // Map the joystick values to the topping position
        xPos += int(map(xVal, 0, 1023, -5, 5));
        yPos += int(map(yVal, 0, 1023, -5, 5));
        println("xPos, " + xPos);
        println("yPos, " + yPos);
        
        xPos = constrain(xPos, T_SIZE/2, width - T_SIZE/2);
        yPos = constrain(yPos, T_SIZE/2, height - T_SIZE/2);
      }
    }
  }
}

class Topping{
  int index;
  PVector position;
  
  Topping(int index, PVector position){
    this.index = index; 
    this.position = position;
  }

}
