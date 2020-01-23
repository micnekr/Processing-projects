class Physics{
  PVector vel;
  PVector acc;
  PVector pos;
  
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
    acc.add(new PVector(x, y));
  }
  
  void force(PVector f){
    acc.add(f);
  }
}
