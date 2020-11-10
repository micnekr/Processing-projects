import peasy.*;

PeasyCam cam;

float maxXSpeed = 4;
float maxYSpeed = 7;

Player p;
Grid g;

void setup() {
  size(200,200,P3D);
  
  cam = new PeasyCam(this, 100);
  
  cam.setSuppressRollRotationMode();
  
  cam.setCenterDragHandler(null);
  cam.setRightDragHandler(null);
  cam.setWheelHandler(null);
  
  p = new Player(0, 0, 100, 20, maxXSpeed, maxYSpeed, g);
}

void draw(){
  background(125, 125, 125);
  
  //render for the player
  pushMatrix();
  //translate(-p.pos.x, -p.pos.y, -p.pos.z);
  
  p.draw();
  popMatrix();
}
