class Point{
  float x, y;
  Point(PVector p){
    x = p.x;
    y = p.y;
  }
  
  Point(float x_, float y_){
    x = x_;
    y = y_;
  }
  
  
  float dist(Point p2){
    float dx = x-p2.x;
    float dy = y-p2.y;
    return sqrt(dx*dx+dy*dy);
  }
  
  void draw(){
    point(x, y);
  }
}

Point randomP(){
  return new Point(random(width), random(height));
}
