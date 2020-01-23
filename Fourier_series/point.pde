class Point{
  PVector pos;
  Point(PVector position){
    pos = position;
  }
  
  void slide(float amount){
    pos.x+=amount;
  }
}
