class Triangle {
  int step = 1;
  PVector[] points = new PVector[3];
  Triangle[] children = new Triangle[3];
  boolean active = true;
  Triangle(PVector p1_, PVector p2_, PVector p3_) {
    points[0] = p1_.copy();
    points[1] = p2_.copy();
    points[2] = p3_.copy();
  }

  Triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    points[0] = new PVector(x1, y1);
    points[1] = new PVector(x2, y2);
    points[2] = new PVector(x3, y3);
  }

  void draw() {
    if (active) {
      triangle(points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
    }
    if (children[0] != null) {
      for (Triangle child : children) {
        child.draw();
      }
    }
  }

  void subdivide() {
    step++;
    if (children[0] != null) {
      for (Triangle child : children) {
        child.subdivide();
      }
    }else{
      active = false;
      PVector[] divisionP = new PVector[3];
      for(int i = 0; i<3; i++){
        PVector pa = points[i];
        PVector pb = points[(i+1)%3];
        float x = (pa.x+pb.x)/2;
        float y = (pa.y+pb.y)/2;
        divisionP[i] = new PVector(x, y);
      }
      for(int i = 0; i<3; i++){
        PVector pa = divisionP[i];
        PVector pb = divisionP[(i+1)%3];;
        children[i] = new Triangle(points[(i+1)%3], pa, pb);
      }
    }
  }
}
