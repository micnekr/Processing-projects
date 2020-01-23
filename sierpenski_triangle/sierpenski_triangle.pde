
float len = 300;
float r32 = sqrt(3)/2;
Triangle t = new Triangle(0, 0, -len/2, r32*len, len/2, r32*len);

void setup(){
  size(600, 600);
  frameRate(1);
}

void draw(){
  background(255);
  strokeWeight(1/t.step);
  translate(width/2, 100);
  scale(1.5);
  t.draw();
  if(t.step<11){
    t.subdivide();
  }
}
