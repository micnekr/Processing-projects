class Path {
  ArrayList<PVector> points;
  float r;

  Path(PVector start_, PVector end_, float r_) {
    points = new ArrayList<PVector>();
    points.add(start_.copy());
    points.add(end_.copy());
    r = r_;
  }

  Path(float x1, float y1, float x2, float y2, float r_) {
    points = new ArrayList<PVector>();
    points.add(new PVector(x1, y1).copy());
    points.add(new PVector(x2, y2).copy());
    r = r_;
  }

  void addPoint(PVector point) {
    points.add(point);
  }

  void addPoint(float x, float y) {
    PVector point = new PVector(x, y);
    points.add(point);
  }

  void draw() {
    strokeWeight(r*2);
    stroke(0, 100);
    for (int i = 0; i<points.size()-1; i++) {
      PVector cur = points.get(i);
      PVector next = points.get(i+1);
      line(cur.x, cur.y, next.x, next.y);
    }
    strokeWeight(1);
    stroke(0);
    for (int i = 0; i<points.size()-1; i++) {
      PVector cur = points.get(i);
      PVector next = points.get(i+1);
      line(cur.x, cur.y, next.x, next.y);
    }
  }
}
