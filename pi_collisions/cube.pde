class Object {
  float v;
  float m;
  float w;
  float x, y;

  Object(float x_, float y_, float m_, float w_) {
    x = x_;
    y = y_;
    m = m_;
    w = w_;
  }

  void update() {
    x += v;
  }

  boolean collideWithWall(float xWall) {
    if (this.x <= xWall) {
      this.v *= -1;
      return true;
    }
    return false;
  }

  boolean collide(Object other) {
    if (this.x + this.w >= other.x && other.x + other.w >= this.x) {
      float mSum = this.m + other.m;
      float m1MinusM2 = this.m - other.m;
      float thisV = this.v;
      this.v = (this.v * m1MinusM2/mSum) +  (2*other.m * other.v/mSum); 
      other.v = (2*this.m * thisV/mSum) + (-m1MinusM2 * other.v/mSum);
      return true;
    }
    return false;
  }

  void draw() {
    pushStyle();
    rect(x, y, w, w);
    popStyle();
  }
}
