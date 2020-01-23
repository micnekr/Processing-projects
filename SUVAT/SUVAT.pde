Bullet b;
Body target;

PVector g;

void setup() {
  size(600, 600);
  g = new PVector(0, 0.1);
  b = new Bullet(100, 100, 2, 30);
  target = new Body(500, 500, 2);
  //b.applyForce(b.findForce(new PVector(400, 400), g, 10));
  target.applyForce(new PVector(0, -3));
  target.physics();
  
  b.applyForce(b.findForce(new PVector(400, 400), g, 10));
  //b.applyForce(new PVector(2.5, 0));
}

void draw () {
  background(255);
  ellipse(400, 400, 30, 30);
  b.applyForce(g);
  target.physics();
  b.physics();
  ellipse(target.pos.x, target.pos.y, 30, 30);
  b.draw();
}
