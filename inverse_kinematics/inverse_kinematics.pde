// variables
float startLen = 30;


Segment base1;
Segment base2;

void setup() {
  size(600, 600);
  base1 = new Segment(300, 300, radians(0), 100, 0.5);
  base1.branch(10);
  base2 = new Segment(500, 500, radians(0), 1, 1);
  base2.branch(200);
}

void draw() {
  background(255);
  base1.follow(mouseX, mouseY);
  base1.draw();
  Segment last = base1.getLast();
  base2.follow(last.end.x, last.end.y);
  base2.draw();
}
