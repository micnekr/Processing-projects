class Physics{
  PVector vel;
  PVector acc;
  PVector pos;
  float forceMult = 1;
  
  Physics(float x, float y){
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    pos = new PVector(x, y);
  }
  
  void physics(){
    vel.add(acc);
    acc = new PVector(0, 0);
    pos.add(vel);
  }
  
  void force(float x, float y){
    acc.add(PVector.mult(new PVector(x, y), forceMult));
  }
  
  void force(PVector f){
    acc.add(PVector.mult(f,forceMult));
  }
}
