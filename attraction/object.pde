class Obj extends Physics{
  float m;
  float w;
  color col = color(255);
  
  Obj(float mass, float x, float y){
    super(x, y);
    m = mass;
    w = m*100;
    if(m<0){
      col = color(0);
    }
  }
  
  void attract(Obj sec){
    float forceMag = gravityConst*m*sec.m/pow(pos.dist(sec.pos),2);
    applyAttraction(sec, forceMag);
    sec.applyAttraction(this, forceMag);
  }
  
  void applyAttraction(Obj sec, float forceMag){
    PVector dir = new PVector(sec.pos.x-pos.x, sec.pos.y-pos.y).normalize();
    applyForce(dir.mult(forceMag));
  }
  
  void applyForce(PVector force){
    float accMag = force.mag()/m;
    PVector acc = force.normalize().mult(accMag);
    force(acc);
  }
  
  void draw(){
    fill(col);
    ellipse(pos.x, pos.y, w, w);
  }
}
