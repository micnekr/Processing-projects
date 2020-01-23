class Cell{
  int x, y;
  boolean isAlive= true;
  
  Cell(int x, int y, boolean isAlive){
    this.x = x;
    this.y = y;
    this.isAlive = isAlive;
  }
  
  
  
  color draw(){
    return isAlive ? color(255, 255, 255) : color(0, 0, 0);
  }
}
