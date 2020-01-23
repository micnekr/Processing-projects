class Toothpick {
  int x1, y1, x2, y2;
  int dir;
  boolean isNew = true;

  Toothpick(int x, int y, int orientation) {
    dir = orientation;
    if (orientation==1) {
      x1 = x-len/2;
      x2 = x+len/2;

      y1=y;
      y2=y;
    } else {
      y1 = y-len/2;
      y2 = y+len/2;

      x1=x;
      x2=x;
    }
  }

  void draw(boolean highlight) {
    if (highlight) {
      stroke(255, 0, 0);
    } else {
      stroke(0);
    }
    strokeWeight(3);
    line(x1, y1, x2, y2);
  }

  void draw() {
    stroke(0);
    strokeWeight(1/scale);
    line(x1, y1, x2, y2);
  }

  Toothpick create(int end, ArrayList<Toothpick> others) {
    int endX, endY;
    if (end==1) {
      endX=x1;
      endY=y1;
    } else {
      endX=x2;
      endY=y2;
    }
    isNew = false;
    for (Toothpick other : others) {
      if (other != this && this.intersects(other, endX, endY)) {
        return null;
      }
    }
    Toothpick child = new Toothpick(endX, endY, dir*-1);
    child.draw(true);
    return child;
  }

  boolean intersects(Toothpick other, int X, int Y) {
    boolean intersecting = (other.x1==X && other.y1==Y)||(other.x2==X && other.y2==Y);
    return  intersecting;
  }
}
