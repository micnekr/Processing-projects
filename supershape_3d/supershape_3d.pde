import peasy.*;

float delta = 0;

float m1 = 5.7;
float n11 = 0.5;
float n21 = 1;
float n31 = 2.5;

float m2 = 10;
float n12 = 3;
float n22 = 0.2;
float n32 = 1;

float a = 1;
float b = 1;

float objSize = 200;

int resolution = 150;





PeasyCam cam;

PVector[][] globe;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 500);
  globe = new PVector[resolution+1][resolution+1];
  colorMode(HSB);
  noStroke();
}

void draw() {
  background(0);
  lights();
  
  //m1 = map(sin(delta), -1, 1, -10, 10);
  //m2 =m1;
  //delta += 0.01;
  for (int i = 0; i <= resolution; i++) {
    float lat = map(i, 0, resolution, -HALF_PI, HALF_PI);
    
    float r2 = getR(lat, m2, n12, n22, n32);
    for (int j = 0; j <= resolution; j++) {
      float lon = map(j, 0, resolution, -PI, PI);
      
      float r1 = getR(lon, m1, n11, n21, n31);
      float x = objSize*r1*cos(lon)*r2*cos(lat);
      float y = objSize*r1*sin(lon)*r2*cos(lat);
      float z = objSize*r2*sin(lat);
      globe[i][j] = new PVector(x, y, z);
    }
  }

  for (int i = 0; i < resolution; i++) {
    //stroke(255);
    //noFill();
    beginShape(TRIANGLE_STRIP);
    fill(map(i, 0, resolution, 0, 255*6)%255, 255, 255);
    for (int j = 0; j < resolution+1; j++) {
      PVector v1 = globe[i][j];
      vertex(v1.x, v1.y, v1.z);
      PVector v2 = globe[i+1][j];
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
}

float getR(float angle, float m, float n1, float n2, float n3) {
  float part1 = abs((1/a)*cos(m*angle/4));
  part1 = pow(part1, n2);
  float part2 = abs((1/b)*sin(m*angle/4));
  part2 = pow(part2, n3);
  float part3 = part1+part2;
  return pow(part3, -1/n1);
}
