class Physics {
  PVector vel;
  PVector acc;
  PVector pos;
  boolean kinematic = false;

  Physics(float x, float y) {
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    pos = new PVector(x, y);
  }

  void physics() {
    if (!kinematic) {
      vel.add(acc);
      acc = new PVector(0, 0);
      pos.add(vel);
      if(pos.x<0){
        pos.x = 0;
        vel.x = 0;
      }
      if(pos.x>width){
        pos.x = width;
        vel.x = 0;
      }
      if(pos.y<0){
        pos.y = 0;
        vel.y = 0;
      }
      if(pos.y>height){
        pos.y = height;
        vel.y = 0;
      }
    }
  }

  void force(float x, float y) {
    PVector acceleration = new PVector(x, y);
    changeSpeed(acceleration);
  }

  void force(PVector f) {
    PVector acceleration = f;
    changeSpeed(acceleration);
  }
  
  void changeSpeed(PVector speed){
    acc.add(speed);
  }
}
