Object c1;
Object c2;

float y = 200;
float wallX = 10;
int digits = 4;
int numberOfRepetitionsPerSecond = 100;
float initVelocity = -1;

int countOfCollisions = 0;

void setup() {
  size(400, 400);
  c1 = new Object(width/5, height - y - 10, 1, 10);
  c2 = new Object(width/2, height - y - 100, pow(100, digits), 100);
  c2.v = initVelocity/numberOfRepetitionsPerSecond;
}

void draw() {
  background(255);
  fill(255);
  for (int i = 0; i < numberOfRepetitionsPerSecond; i++) {
    c1.update();
    c2.update();
    if (c1.collide(c2) || c1.collideWithWall(wallX)) {
      countOfCollisions++;
    }
  }
  c1.draw();
  c2.draw();
  line(0, height - y, width, height - y);
  line(wallX, 0, wallX, height);
  fill(0);
  textSize(32);
  text(countOfCollisions, width/2, height/4);
  if(c1.v >= 0 && c1.v < c2.v){
    text("The end", width/2, 3*height/4);
  }
}
