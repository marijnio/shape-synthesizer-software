// define input locations
int buttonA = 2;
int buttonB = 3;
int buttonC = 4;
int buttonD = 5;

int joyUp = 8;
int joyRight = 7;
int joyDown = 6;
int joyLeft = 9;

int potA = 1;
int potB = 5;
int potC = 2;
int potD = 3;

int sPotA = 4;
int sPotB = 0;

// declare booleans and integers for readings
boolean _buttonA, _buttonB, _buttonC, _buttonD,
        _joyUp, _joyRight, _joyDown, _joyLeft;

int     _potA, _potB, _potC, _potD,
        _sPotA, _sPotB;

// define LED location
int led = 13;

void setup() {
  // declare the switches with pullup resistors
  pinMode(buttonA, INPUT_PULLUP);
  pinMode(buttonB, INPUT_PULLUP);
  pinMode(buttonC, INPUT_PULLUP);
  pinMode(buttonD, INPUT_PULLUP);

  pinMode(joyUp, INPUT_PULLUP);
  pinMode(joyRight, INPUT_PULLUP);
  pinMode(joyDown, INPUT_PULLUP);
  pinMode(joyLeft, INPUT_PULLUP);
  
  pinMode(led, OUTPUT);
  
  Serial.begin(9600);
  establishContact(); // send a byte to make contact until recever responds
}

void loop() {
  // if data is available to read
  if (Serial.available() > 0) {
    digitalWrite(led, HIGH);   // turn the LED on
    // read input values
    _buttonA = !(digitalRead(buttonA)); // to correct value directions,
    _buttonB = !(digitalRead(buttonB)); // some values are inversed
    _buttonC = !(digitalRead(buttonC));
    _buttonD = !(digitalRead(buttonD));
  
    _joyUp = !(digitalRead(joyUp));
    _joyRight = !(digitalRead(joyRight));
    _joyDown = !(digitalRead(joyDown));
    _joyLeft = !(digitalRead(joyLeft));
  
    _potA = (1023-analogRead(potA));
    _potB = (1023-analogRead(potB));
    _potC = (1023-analogRead(potC));
    _potD = (1023-analogRead(potD));
    
    _sPotA = analogRead(sPotA);
    _sPotB = analogRead(sPotB);
    
    // send input values
    Serial.print(String(_buttonA) + " ");
    Serial.print(String(_buttonB) + " ");
    Serial.print(String(_buttonC) + " ");
    Serial.print(String(_buttonD) + " ");
    
    Serial.print(String(_joyUp) + " ");
    Serial.print(String(_joyRight) + " ");
    Serial.print(String(_joyDown) + " ");
    Serial.print(String(_joyLeft) + " ");
    
    Serial.print(String(_potA) + " ");
    Serial.print(String(_potB) + " ");
    Serial.print(String(_potC) + " ");
    Serial.print(String(_potD) + " ");
  
    Serial.print(String(_sPotA) + " ");
    Serial.println(String(_sPotB) + " ");
  }
}

void establishContact(){
  while (Serial.available() <= 0){
    digitalWrite(led, HIGH);   // turn the LED on
    Serial.println("A"); // send a capital A
    delay(300);
    digitalWrite(led, LOW);    // turn the LED off  
  }
}
