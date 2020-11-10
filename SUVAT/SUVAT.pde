Bullet b1, b2;
Body target;

PVector g;

void setup() {
  size(600, 600);
  g = new PVector(0, 0.1);
  b1 = new Bullet(100, 100, 2, 30);
  b2 = new Bullet(100, 100, 2, 30);
  
  target = new Body(500, 500, 2);

  target.applyForce(new PVector(0, -3));
  target.physics();
  
  b1.applyForce(b1.findForce(new PVector(400, 400), g, 3.4));
  //println(b2.findForce(target, g, 10, 10));
}

void draw () {
  background(255);
  ellipse(400, 400, 30, 30);
  b1.applyForce(g);
  target.physics();
  b1.physics();
  ellipse(target.pos.x, target.pos.y, 30, 30);
  b1.draw();
}
