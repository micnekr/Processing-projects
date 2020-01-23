int len = 63;

int minX, maxX;
float scale;



ArrayList<Toothpick> picks;

void setup() {
  size(600, 600, P2D);
  background(255);
  translate(width/2, height/2);
  frameRate(24);
  
  minX = -width/2;
  maxX = width/2;
  
  picks=new ArrayList<Toothpick>();
  picks.add(new Toothpick(0, 0, 1));
  picks.get(0).draw();
}

void draw() {
  translate(width/2, height/2);
  step();
}

void step() {
  
  background(255);
  
  scale = float(width) / (maxX-minX);
  
  scale(scale);
  
  ArrayList<Toothpick> next = new ArrayList<Toothpick>();

  for (Toothpick t : picks) {
    minX = min(t.x1, minX);
    maxX = max(t.x1, maxX);
    t.draw();
    if (t.isNew) {
      Toothpick a = t.create(1, picks);
      Toothpick b = t.create(2, picks);
      if (a != null) {
        next.add(a);
      }
      if (b != null) {
        next.add(b);
      }
    }
  }
  picks.addAll(next);
}
