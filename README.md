# Module 2: Interactive Device
## Additional Links
- blog: https://www.notion.so/Module-2-Interactive-Devices-4d18e2bd3474455ebf387da37763de87?pvs=4
- YouTube: https://youtu.be/rEU14WnWrko (actual demo starts at 0:14)

## Description
The Interactive Devices is a project in the Creative Embedded Systems (COMS BC 3930) course taught by Professor Mark Santolucito in Spring 2023. We used ESP32 TTGO T-display, a joystick and a button as the hardware for the project. An ESP32 program was written to collect sensor data and send it over to Processing, and the processing program did something interesting with it.

## Design 
### A “Jianbing” Decoration Game

One day I was sitting at Diana eating Diana’s build pizza. My thoughts brought me back to my high school time when my friend and I always went to a street near school for some night snacks. The street was filled with street cries for selling, and even the air filled with the smell of all kinds of traditional foods. Among all kinds of stalls, my friends and I always stopped at the stall that sells Jianbing, a traditional Chinese food that you can find almost everywhere in the country although the taste and toppings might be different among places. Looking at the build pizza, a thought came to my mind that why could I just create a Jianbing decoration game just like the built pizza where you could put different toppings as your choice? That’s the inspiration of this interactive Jianbing decoration game. 

- In terms of how to play the game, the joystick controls the position of topping emoji, pressing the button on joystick (z-axis) can put the current toppings to the background, and pressing the other button can switch toppings among four choices (lettuce, bacon, shrimp, and chicken). This achieves the basic “adding toppings” functionality of the game.

## Art Decision
- In terms of the background image, instead of choosing a pre-exist image from the internet, I chose to draw the Jianbing stall myself using procreate. The image includes a flat round pot in the middle, a flour made pancake with eggs spread on it, and different choices of toppings at two sides. The image was created based on my memory of the Jianbing stall near my high school. Regarding the use of color and brushes in the Procreate app, I chose a relatively plain color and design since I wanted to create a realistic visualization.
- I chose to use the emoji to represent different toppings for two reasons. First, it avoids messing up the topping image with the background in terms of formatting; and second, it’s more direct to use food emoji since people are familiar with it. Among all the food emoji, I chose lettuce, bacon, shrimp, and chicken as the topping choices since these choices cover vegetable, meat, seafood, which are some common toppings for Jianbing. 

## Materials
- ESP32 TTGO T-display 
- a button
- a joystick 
- wires (5 to connect the joystick and 2 to connect the button)

## Setting up
- Connect joystick pins to EPS32 TTGO T-display on a breadboard: connect ground pin from the joystick to ground pin on ESP32, 5V pin from the joystick to 3V pin on ESP32, and other three pins on the joystick to any pins on ESP32 that could take in input
- Connect button pins to ESP32 TTGO T-display: connect one of the pin to ground pin on ESP32, connect another pin that’s not the same level of the first pin to any pins on ESP32 that could take in input (Can follow the link [Here](https://docs.arduino.cc/built-in-examples/digital/Button))
- Plug your ESP32 TTGO T-Display to the computer using USB-Type C cable that can transfer data

## Arduino program 
- Open file `interactive.ino` on Arduino
- Select `Tools -> Port -> /dev/cu.wchusbserialXXXXXXXX`
- Select `Boards > Boards Manager` under `Tools`, find and install `esp32`
- Select `Upload`

## Processing program 
- Open file `module2process.pde` under the `module2process` folder
- Make sure the port is not busy before starting the program 
- Select `Run`

## Interactive Device
- Use the joystick to control the position of current toppings
- Press down the joystick to add current toppings to the background
- Press down the button to change topping choices 

## Technical Challenges 
- To display emoji on the canvas, string representation of the emoji unicode should be used.
- When the joystick was first connected, the Arduino program read the sensor inputs directly and sent corresponding x, y, z positions to the processing program. Then the processing program put the emoji at the position with corresponding x and y values. However, the first attempt didn't go so well since the emoji kept moving right to the screen although the joystick was not moved, and the emoji might float out of the canvas. By printing out the x and y values on the console, I found that the value fluctuated around 2000 although the joystick was not moved. As a result, I set a changed threshold of 100 that the emoji should move only when the position changed was larger than the threshold value. In addition, adding a constraint when displaying emoji position helps keeping the emoji on canvas without floating out.
