int pointsNum = 3;
int steps = 50000;

PVector[] points = new PVector[pointsNum];

float x;
float y;


void setup() {
  size(600, 600);

  x = width/2;
  y = height/2;

  points[0] = new PVector(width/2, 0);
  points[1] = new PVector(0, height);
  //points[2] = new PVector(width, 0);
  points[2] = new PVector(width, height);
  for (int i = 0; i < pointsNum; i++) {
    //points[i] = new PVector(random(width), random(height));
  }
}

void draw() {
  background(255);
  stroke(255, 0, 0);
  strokeWeight(16);
  for (int i = 0; i < pointsNum; i++) {
    PVector point = points[i];
    point(point.x, point.y);
  }
  stroke(0);
  strokeWeight(1);
  for (int i = 0; i<steps; i++) {
    PVector chosen = chooseOne();
    x = (x+chosen.x)/2;
    y = (y+chosen.y)/2;
    point(x, y);
  }
}

PVector chooseOne() {
  return points[floor(random(pointsNum))];
}
