class Body{
  float m;
  PVector pos;
  PVector vel;
  PVector acc;
  
  Body(float x, float y, float mass){
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    m = mass;
  }
  
  void applyForce(PVector f){
    acc.add(PVector.div(f, m));
    
  }
  
  void physics(){
    pos.add(vel);
    vel.add(acc);
    acc = new PVector(0, 0);
  }
  
}
