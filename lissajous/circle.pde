class Circle {
  float x, y;
  float d;
  float angle = -HALF_PI;
  float px, py;
  float pxraw, pyraw;
  float speed;
  Circle(float x_, float y_, float d_, float speed_) {
    x = x_;
    y = y_;
    d = d_;
    this.speed = speed_;
  }

  void draw() {
    strokeWeight(1);
    stroke(255);
    noFill();
    ellipse(x, y, d, d);

    strokeWeight(16);
    calcPoint();
    point(px, py);


    stroke(255, 50);
    strokeWeight(1);
    if (x>y) {
      line(px, 0, px, height);
    } else {
      line(0, py, width, py);
    }
  }

  void update(float angle_) {
    this.angle = angle_*this.speed;
  }

  void calcPoint() {
    pxraw = cos(this.angle);
    pyraw = sin(this.angle);
    px = pxraw*d/2+x;
    py = pyraw*d/2+y;
  }
}
