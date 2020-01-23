class Segment {
  PVector origin;
  PVector end;
  PVector joint;
  float len;
  float angle;
  float reduction;
  Segment child;
  Segment parent;

  Segment(float x, float y, float angle_, float len_, float reduction_) {
    origin = new PVector(x, y);
    end = new PVector();
    joint = origin.copy();
    reduction = reduction_;
    angle = angle_;
    len = len_;
    findEnd();
    parent = null;
    child = null;
  }

  Segment(Segment parent_, float angle_, float len_, float reduction_) {
    parent = parent_;
    origin = parent.end.copy();
    end = new PVector();
    reduction = reduction_;
    angle = angle_;
    len = len_;
    this.findEnd();
    parent.child = this;
  }

  void branch() {
    if (child == null) {
      child = new Segment(this, angle, len*reduction, reduction);
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

  Segment getLast() {
    if (child == null) {
      return this;
    } else {
      return child.getLast();
    }
  }

  void draw() {
    stroke(51);
    strokeWeight(len/10);
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

  void follow(float targetX, float targetY) {
    getLast().followTarget(targetX, targetY);
  }

  void followTarget(float targetX, float targetY) {
    PVector target = new PVector(targetX, targetY);
    PVector dir = PVector.sub(target, origin);
    angle = dir.heading();

    dir.setMag(len);
    dir.mult(-1);

    origin = PVector.add(target, dir);

    findEnd();

    if (parent != null) {
      parent.followTarget(origin.x, origin.y);
    } else {
      shiftBack();
    }
  }

  void turnTo(float angle_) {
    turn(angle_-angle);
  }

  void shift(float x, float y) {
    float newX = x;
    float newY = y;
    origin.set(newX, newY);
    findEnd();
    if (child!=null) {
      child.shift(end.x, end.y);
    }
  }

  void shiftBack() {
    shift(joint.x, joint.y);
  }
}
