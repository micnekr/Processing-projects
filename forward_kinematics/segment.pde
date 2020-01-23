class Segment {
  PVector origin;
  PVector end;
  float len;
  float angle;
  Segment child;
  Segment parent;

  Segment(float x, float y, float angle_, float len_) {
    origin = new PVector(x, y);
    end = new PVector();
    angle = angle_;
    len = len_;
    findEnd();
    parent = null;
    child = null;
  }

  Segment(Segment parent_, float angle_, float len_) {
    parent = parent_;
    origin = parent.end.copy();
    end = new PVector();
    angle = angle_;
    len = len_;
    this.findEnd();
    parent.child = this;
  }

  void branch() {
    if (child == null) {
      child = new Segment(this, angle, len/2);
    } else {
      child.branch();
    }
  }

  void branch(int num) {
    for (int i = 0; i < num; i++) {
      branch();
    }
  }

  Segment get(int num) {
    if (num==0) {
      return this;
    } else {
      return child.get(num-1);
    }
  }

  void draw() {
    stroke(51);
    strokeWeight(len/4);
    line(origin.x, origin.y, end.x, end.y);
    if (child != null) {
      child.draw();
    }
  }

  void findEnd() {
    float dx = len*cos(angle);
    float dy = len*sin(angle);
    end.x = origin.x + dx;
    end.y = origin.y + dy;
  }

  void turn(float dangle) {
    angle += dangle;
    findEnd();
    update(dangle);
  }

  void update(float turned) {
    if (child != null) {
      child.updatePos();
      child.turn(turned);
      child.findEnd();
    }
  }

  void updatePos() {
    origin = parent.end.copy();
  }
}
