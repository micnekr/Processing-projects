import peasy.*;

PeasyCam cam;

float angle = 0;
float angle2 = 0;
float waxis = 0;

float d = 600;
int dims = 4;

Cube cube;

void setup() {
  fullScreen(P3D);
  cam = new PeasyCam(this, width/2, height/2, 0, 200);
  //cam.setYawRotationMode(); 
  
  Vector[] points = new Vector[pointsNum(dims)];
  //points = constructCube(points, dims, 100);
  cube = constructCubeObj(points, dims, 100);
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  translate(width/2, height/2);
  
  cube.addRot(Z, W, angle);
  cube.translate(W, waxis);
  cube.render(d);

  // rotate
  angle += radians(0.5);
  angle2 += radians(0.5);
  waxis+=0.1;
}






//PVector[] ps = new PVector[points.length];
  //for (int i = 0; i < points.length; i++) {
  //  Vector p = points[i];
  //  Vector rotated = rotate(p, Z, W, dims, angle);
  //  //rotated = rotate(rotated, Z, V, dims, angle2);

  //  // project
  //  PVector projected = projectFull(rotated, dims, d).to3D();
  //  ps[i] = projected;
  //}

  //connect(ps);
