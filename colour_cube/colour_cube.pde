import peasy.*;

int cols = 20;
PeasyCam cam;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, width/2, height/2, width/2, 200);
  strokeWeight(8);
  background(0);
  plot();
}

void draw(){
  background(0);
  plot();
}

void plot() {
  float step = width/cols;
  for (int i = 0; i<cols; i++) {
    for (int j = 0; j<cols; j++) {
      for (int l = 0; l<cols; l++) {
        stroke(color(i*step, j*step, l*step));
        point(i*step, j*step, l*step);
      }
    }
  }
}
