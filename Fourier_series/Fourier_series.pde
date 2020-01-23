Circle circle;
ArrayList<Point> wave;
int max = 1000;
float scale = 200;
float speed = 1;
int plotsPerFrame = 1;
int circlesNum = 100;

void setup() {
  size(600, 600);

  wave = new ArrayList<Point>();

  circle = new Circle(radians(speed), scale/PI);
  float radiusChange = 3;
  for (int i = 0; i<circlesNum; i++) {
    circle.grow(radians(speed*radiusChange), scale/(PI*radiusChange));
    radiusChange+=2;
  }
  circle.setPos(300, 300);
}

void draw() {
  for (int plot = 0; plot<plotsPerFrame; plot++) {
    background(255);
    circle.update();
    circle.draw();
    Circle last = circle.getLast();
    wave.add(new Point(new PVector(400, last.py)));

    noFill();

    beginShape();
    for (int i = 0; i<wave.size(); i++) {
      Point point = wave.get(i);
      point.slide(1);
      vertex(point.pos.x, point.pos.y);
    }
    endShape();

    if (wave.size()>max) {
      wave.remove(0);
    }
  }
}
