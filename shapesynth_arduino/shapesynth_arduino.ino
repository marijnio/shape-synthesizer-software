// define input locations
int buttonA = 3;
int buttonB = 2;
int buttonC = 5;
int buttonD = 4;

int joyUp = 6;
int joyRight = 7;
int joyDown = 8;
int joyLeft = 9;

int potA = 1;
int potB = 0;
int potC = 3;
int potD = 2;

int sPotA = 4;
int sPotB = 5;

// declare booleans and integers for readings
boolean _buttonA, _buttonB, _buttonC, _buttonD,
        _joyUp, _joyRight, _joyDown, _joyLeft;

int     _potA, _potB, _potC, _potD,
        _sPotA, _sPotB;

// declare variables for analog input smoothing
const int s = 5; // amount of smoothing
int       index = 0; // current reading index
          // arrays
int       hPotA[s], hPotB[s], hPotC[s], hPotD[s],
          hSPotA[s], hSPotB[s];
          // totals and averages
int       totals[6], averages[6];


// define LED location
int led = 10;

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
  
  // initialize all analog readings to 0
  for (int i=0; i < s; i++){ hPotA[i] = 0; }
  for (int i=0; i < s; i++){ hPotB[i] = 0; }
  for (int i=0; i < s; i++){ hPotC[i] = 0; }
  for (int i=0; i < s; i++){ hPotD[i] = 0; }
  for (int i=0; i < s; i++){ hSPotA[i] = 0; }
  for (int i=0; i < s; i++){ hSPotB[i] = 0; }
  
  establishContact(); // send a byte to make contact until recever responds
}

void loop() {
  // if data is available to read
  if (Serial.available() > 0) {
    digitalWrite(led, HIGH);   // turn the LED on
    // read digital input values
    _buttonA = !(digitalRead(buttonA)); // to correct value directions,
    _buttonB = !(digitalRead(buttonB)); // some values are inversed
    _buttonC = !(digitalRead(buttonC));
    _buttonD = !(digitalRead(buttonD));
    
    _joyUp = !(digitalRead(joyUp));
    _joyRight = !(digitalRead(joyRight));
    _joyDown = !(digitalRead(joyDown));
    _joyLeft = !(digitalRead(joyLeft));
    
    // subtract the last readings
    totals[0] = totals[0] - hPotA[index];
    totals[1] = totals[1] - hPotB[index];
    totals[2] = totals[2] - hPotC[index];
    totals[3] = totals[3] - hPotD[index];
    totals[4] = totals[4] - hSPotA[index];
    totals[5] = totals[5] - hSPotB[index];
    
    // read analog input values
    hPotA[index] = (1023-analogRead(potA));
    hPotB[index] = (1023-analogRead(potB));
    hPotC[index] = (1023-analogRead(potC));
    hPotD[index] = (1023-analogRead(potD));
    hSPotA[index] = analogRead(sPotA);
    hSPotB[index] = analogRead(sPotB);
    
    // add the readings to the totals
    totals[0] = totals[0] + hPotA[index];
    totals[1] = totals[1] + hPotB[index];
    totals[2] = totals[2] + hPotC[index];
    totals[3] = totals[3] + hPotD[index];
    totals[4] = totals[4] + hSPotA[index];
    totals[5] = totals[5] + hSPotB[index];
    
    // advance in the array positions
    index = index + 1;
    // wrap around if necessary
    if (index >= s) { index = 0; }

  // calculate the average:
  average = total / numReadings;
    
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
    delay(300);
  }
}
