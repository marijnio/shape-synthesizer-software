import processing.serial.*;

// controller variables
Serial myPort;
String val;
boolean firstContact = false; // state of connection

boolean buttonA, buttonB, buttonC, buttonD,
        _buttonA, _buttonB, _buttonC, _buttonD, // last readings
        buttonAP, buttonBP, buttonCP, buttonDP, //  when pressed 
        joyUp, joyRight, joyDown, joyLeft;

int     potA, potB, potC, potD,
        sPotA, sPotB;
  
void serialEvent(Serial myPort){
  // put the incoming data into a string
  // the '\n' is our end delimiter indicating the end of a complete package
  val = myPort.readStringUntil('\n');
  // make sure the package is not empty
  if (val != null){
    // trim whitespace and formatting characters
    val = trim(val);
    
    // look for the 'A' string to start the handshake
    // if so, clear the buffer and send a request for data
    if (!firstContact){
      if (val.equals("A")){
        myPort.clear();
        firstContact = true;
        myPort.write("A");
        println("contact");
      }
    }
    // if contact is established, receive and parse data
    else {
      int[] nums = int(split(val, ' '));
      
      // assign data
      buttonA = boolean(nums[0]);
      buttonB = boolean(nums[1]);
      buttonC = boolean(nums[2]);
      buttonD = boolean(nums[3]);
      
      joyUp = boolean(nums[4]);
      joyRight = boolean(nums[5]);
      joyDown = boolean(nums[6]);
      joyLeft = boolean(nums[7]);
      
      potA = nums[8];
      potB = nums[9];
      potC = nums[10];
      potD = nums[11];
      
      sPotA = nums[12];
      sPotB = nums[13];
      
      // button checkers
      if (buttonA && !_buttonA) { buttonAP = true; }
      if (buttonB && !_buttonB) { buttonBP = true; }
      if (buttonC && !_buttonC) { buttonCP = true; }
      if (buttonD && !_buttonD) { buttonDP = true; }
      
      _buttonA = buttonA;
      _buttonB = buttonB;
      _buttonC = buttonC;
      _buttonD = buttonD;
    }
  }
}
