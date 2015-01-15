import controlP5.*;
import peasy.*;

PGraphics3D g3;
PeasyCam cam;
PMatrix3D currCameraMatrix;

ControlP5 cp5;

void setupCam() {
  g3 = (PGraphics3D)g;
  
  cam = new PeasyCam(this, 0, -100, 0, 200);
  cam.setMouseControlled(false);
  cam.setYawRotationMode();
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
}

void setupMenu() {
  cp5 = new ControlP5(this);
  
  cp5.setColorForeground(0xffababa9);
  cp5.setColorBackground(0xffe7e7e7);
  cp5.setColorLabel(0xff222222);
  cp5.setColorValue(0xffffffff);
  cp5.setColorActive(0xff3b75d9);

  cp5.addSlider("shrinkVal")
   .setPosition(16,16)
   .setSize(128,16)
   .setRange(0.5,0.75)
   ;
   
  cp5.addSlider("sizeLimit")
    .setPosition(16,36)
    .setSize(128,16)
    .setRange(3, 20)
    ;

  cp5.addSlider("branchWidth")
    .setPosition(16,56)
    .setSize(128,16)
    .setRange(0, 1)
    ;

  cp5.addSlider("branchLength")
    .setPosition(16,76)
    .setSize(128,16)
    .setRange(0, 1)
    ;
    
  cp5.addSlider("bend")
    .setPosition(16,96)
    .setSize(128,16)
    .setRange(0, PI)
    ;
    
  cp5.addSlider("branching")
    .setPosition(16,116)
    .setSize(128,16)
    .setRange(0, 6)
    .setNumberOfTickMarks(6)
    ;
  
  cp5.addSlider("colorMethod")
    .setPosition(16,146)
    .setSize(128,16)
    .setRange(0, 3)
    .setNumberOfTickMarks(3)
    ;
  
  cp5.addToggle("bendMethod")
     .setPosition(16,178)
     .setSize(62,16)
     ;

  cp5.addToggle("zScaling")
     .setPosition(82,178)
     .setSize(62,16)
     .setValue(true)
     ;
  
  cp5.addToggle("camControls")
     .setPosition(16,214)
     .setSize(62,16)
     ;

  cp5.addButton("save")
     .setPosition(82,214)
     .setSize(62,16)
     ;
  cp5.getController("save").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

  cp5.setAutoDraw(false);
}


void gui() {
  currCameraMatrix = new PMatrix3D(g3.camera);
  camera();
  cp5.draw();
  g3.camera = currCameraMatrix;
}

public void save() {
  record = true;
}

public void camControls(boolean value) {
  cam.setMouseControlled(value);
}
