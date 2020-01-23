Ship s = new Ship(300, 300, 4, 0.1);
float maxSpeed = 10;

void setup(){
  size(600, 600);
}

void draw(){
  background(255);
  PVector mouse = new PVector(mouseX, mouseY);
  s.approach(mouse, 100);
  s.physics();
  s.draw();
}
