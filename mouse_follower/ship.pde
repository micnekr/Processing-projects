class Ship extends Physics {
  float w = 30;
  float maxSpeed, maxForce;

  Ship(float x, float y, float maxSpeed_, float maxForce_) {
    super(x, y);
    maxSpeed=maxSpeed_;
    maxForce=maxForce_;
  }

  void draw() {
    ellipse(pos.x, pos.y, w, w);
  }

  void follow(PVector target) {
    moveTo(target, maxSpeed);
  }
  
  void approach(PVector target, float r){
    float dist = pos.dist(target);
    if(dist>r){
      follow(target);
    }else{
      moveTo(target, map(dist, 0, r, 0, maxSpeed));
    }
  }
  
  void moveTo(PVector target, float mSpeed){
    PVector needed = PVector.sub(target, pos);
    needed.normalize().mult(mSpeed);
    PVector error = PVector.sub(needed, vel);
    if (error.mag()>maxForce) {
      error.normalize();
      error.mult(maxForce);
    }
    force(error);
  }
}
