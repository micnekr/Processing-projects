// variables
float startLen = 30;


Segment arm;

void setup() {
  size(600, 600);
  arm = new Segment(300, 300, radians(0), 100);
  arm.branch(3);
}

void draw() {
  background(255);
  arm.turn(radians(1));
  arm.get(2).turn(radians(1));
  arm.draw();
}
