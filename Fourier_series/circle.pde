class Circle {
  float angle = 0;
  float vel;
  float r;
  float x = 0;
  float y = 0;
  float px, py;
  Circle child;

  Circle(float speed, float radius) {
    vel = speed;
    r = radius;
  }

  void grow(float speed, float radius) {
    getLast().child = new Circle(speed, radius);
  }

  Circle getLast() {
    if (child!=null) {
      return child.getLast();
    }
    return this;
  }

  void setPos(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void update() {
    angle+=vel;
    calcPs();
    if (child!=null) {
      child.setPos(px, py);
      child.update();
    }
  }

  void calcPs() {
    px = r*cos(angle)+x;
    py = r*sin(angle)+y;
  }

  void draw() {
    ellipse(x, y, r*2, r*2);
    line(x, y, px, py);
    if (child!=null) {
      child.draw();
    }
  }
}
