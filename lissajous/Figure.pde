class Figure{
  ArrayList<PVector> points;
  PVector loading;
  float x, y, w;
  Figure(float x_, float y_, float w_){
    x = x_;
    y = y_;
    w = w_;
    points = new ArrayList<PVector>();
    loading = new PVector();
  }
  
  void draw(){
    beginShape();
    for(PVector vec: points){
      vertex(vec.x*w+x, vec.y*w+y);
    }
    endShape();
  }
  
  void apply(){
    points.add(loading);
    loading = new PVector();
  }
}
