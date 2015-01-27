// 3D fractal tree simulation by Marijn Willemse
// This version receives input from a custom Arduino controller.

import nervoussystem.obj.*;

// generation values
float shrinkVal = 0.62;     // amount to reduce in size per recursion
float branchRadius = 4;     // width of the current branch
float branchRatio = 1;      // ratio of branch length to its width
float sizeLimit = 4;        // minimum allowed branch length
int branching = 2;          // amount of branches to make per recursion
float bend = PI/4;          // branch bending angle
boolean bendMethod = false; // branches rotate along z axis when true 
int colorMethod = 0;        // branch color scheme
boolean zScaling = true;    // flattens tree for horizontal printing

// drawing values
color c;
int hue;
boolean stroke = false;

// camera variables
float camRotation = 0;
float camHeight = 150;

boolean record;

void setup() {
  size(1280, 720, P3D);
  colorMode(HSB, 360); // 360 degrees on the HSB color wheel
  smooth(4);

  // Controller values
  // change the 0 to a 1 or 2 etc. to match your port
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  // drawing configuration
  background(#FFFFFF);
  if (stroke == false) { noStroke(); }
  lights();
    
  hue = 0; // reset the hue value
  c = color(360);
  fill(c);
  
  // the camera orbits around the point of interest
  float orbitRadius = 200;
  float camY = camHeight;
  float camX = cos( radians(camRotation) ) * orbitRadius;
  float camZ = sin( radians(camRotation) ) * orbitRadius;
  camera(camX, camY, camZ, 0, 100, 0, 0, -1, 0);
  
  // interpret controller readings when controller is connected
  if (firstContact) interpret();
  
  if (record) { // start recording if directed
    String str1 = "output_" + year() + month() + day() + hour() + second() + ".obj";
    println("recording to " + str1 + "...");
    beginRecord("nervoussystem.obj.OBJExport", str1);
  }
  
  // the first branch is drawn with a given length
  // it operates as a recursive function and draws all
  branch(80);
  
  if (record) { // simulation is drawn so recording stops
    endRecord();
    record = false;
  }
}

void branch(float len) {
  if (colorMethod < 2) {
    c = color(hue % 360, 360, 360); // hue wraps around at 360
  } 
  fill(c);
  
  float branchDepth = branchRadius; // reset branch depth
  
  // move to middle of branch
  translate(0, len/2/branchRatio);
  
  // only scale depth of box if zScaling is on
  if (zScaling) { branchDepth = len / branchDepth; }
  // the branch is scaled to the current length
  box(branchDepth, len/branchRatio, len/branchRadius);
  
  // move to end of branch
  translate(0, len/2/branchRatio);
  // reduce len of next recursion
  len *= shrinkVal;
  
  // check if branch is allowed to branch again
  if (len > sizeLimit) {
    for (int i = 0; i < branching; i++) {
      // get single branch angle from number of branches
      float radian = TWO_PI / branching;
      pushMatrix();
      hue += 36; // shift hue when branching
      rotateY(radian*i); // rotate into position
      rotateX(bend);     // then bend over
      if (bendMethod == true) { rotateZ(bend); }
      branch(len); // draw the next branch
      popMatrix();
      if (colorMethod == 0) {
        hue -= 36; // return to previous hue
      }
    }
  }
}

void interpret() {
  if (joyRight) camRotation += 2;
  if (joyLeft) camRotation -= 2;
  if (joyUp && camHeight < 250) { camHeight += 2; }
  if (joyDown && camHeight > -100) { camHeight -= 2; }

  branching = round(map(sPotA, 0, 1023, 0, 8));
  bend = map(sPotB, 0, 1023, 0, PI);
  
  shrinkVal = map(potA, 0, 1023, 0.5, 0.75);
  sizeLimit = map(potB, 0, 1023, 3, 20);
  branchRadius = map(potD, 0, 1023, 4, 10);
  branchRatio = map(potC, 0, 1023, 1, 2);
  
  if (buttonAP) {
    colorMethod = (colorMethod+1) % 3;
    buttonAP = false;
  }
  if (buttonBP) {
    bendMethod = !bendMethod;
    buttonBP = false;
  }
  if (buttonCP) {
    zScaling = !zScaling;
    buttonCP = false;
  }
  if (buttonDP) {
    record = true;
    buttonDP = false;
  }
}
