/* 3D fractal tree simulation by Marijn Willemse */

import nervoussystem.obj.*;

// generation variables
float shrinkVal = 0.62;  // amount to shrink per recursion
float branchWidth = 0.2; // width of the branch to its length
float branchLength = 1;  // length of branch length to its width
float sizeLimit = 10;    // minimum allowed branch length
int branching = 2;       // number of branches per recursion
float bend = PI/4;       // branch bending angle
int colorMethod;     // branch color scheme
boolean bendMethod;  // branches rotate along z axis when true 
boolean zScaling;    // flattens tree for horizontal printing

// drawing variables
color c;
int hue;
boolean stroke = false;
boolean record;

void setup() {
  size(1280, 720, P3D);
  colorMode(HSB, 360); // 360 degrees on the HSB color wheel
  smooth(4);
  
  setupCam();
  setupMenu();
}

void draw() {
  // drawing configuration
  background(#FFFFFF);
  if (stroke == false) { noStroke(); }
  lights();
    
  hue = 0; // reset the hue value
  c = color(270); // set default at a light grey
  fill(c);
  
  if (record) { // start recording if directed
    String str = "output_" + year() + "_" + month() + "_"
                 + day() + "_" + hour() + "_" + minute() + "_"
                 + second() + ".obj"; // timestamped path
    println("recording to " + str + "...");
    beginRecord("nervoussystem.obj.OBJExport", str);
  }

  rotateY(PI/2);
  
  // the first branch is drawn with a given length
  // it operates as a recursive function
  branch(80);
  
  if (record) { // simulation is drawn so recording stops
    endRecord();
    record = false;
  }
  
  gui(); // draw the cp5 gui on a 2D view
}

void branch(float len) {
  if (colorMethod < 2) {
    c = color(hue % 360, 360, 360); // hue wraps around at 360
  } 
  fill(c);
  
  float branchDepth = branchWidth; // reset branch depth
  
  // move to middle of branch
  translate(0, -len/2*branchLength);
  
  // only scale depth of box if zScaling is on
  if (zScaling) { branchDepth = len*branchDepth; }
  // the branch is scaled to the current length
  box(branchDepth, len*branchLength, len*branchWidth);
  
  // move to end of branch
  translate(0, -len/2*branchLength);
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
