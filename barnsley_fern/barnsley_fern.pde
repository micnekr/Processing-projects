
float x= 0;
float y = 0;
int times = 1500;

void setup() {
  //size(600, 600);
  fullScreen();
  background(0);
}

void draw() {  
  stroke(0, 200, 0);
  strokeWeight(1);
  //translate(0, height/2);

  for (int i = 0; i<times; i++) {

    float px = map(x, -2.1820, 2.6558, 0, width);
    float py = map(y, 0, 9.9983, height, 0);
    point(px, py);

    updatePos();
  }
}

void updatePos() {
  float[][] posMul = {{x}, {y}};

  int index = pickOne();
  float[][][] randSet = sets[index];

  float[][] newMat = add(mul(randSet[0], posMul), randSet[1]);
  x = newMat[0][0];
  y = newMat[1][0];
}
