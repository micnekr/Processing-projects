Ship s = new Ship(0, 300, 10, 1);
Path p;

void setup() {
  //size(600, 600);
  fullScreen();
  p = new Path(0, 0, 200, 200, 30);
}

void draw() {
  background(255);
  if (mousePressed&&mouseButton!=RIGHT) {
    PVector mouse = new PVector(mouseX, mouseY);
    s.approach(mouse, 50);
  } else {
    s.follow(p);
  }
  s.physics();
  p.draw();
  s.draw();
}

void mousePressed() {
  if (mouseButton==RIGHT) {
    p.addPoint(mouseX, mouseY);
  }
}
