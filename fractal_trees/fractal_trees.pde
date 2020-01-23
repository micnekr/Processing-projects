int totalSteps = 10;
float angle = PI/1.5;
float shortening = 0.5;
float min = 1;

void setup() {
  size(2000, 2000);
  background(51);
  stroke(255);
  strokeWeight(1);

  // start branching
  translate(width/2, height);
  branch(height/2);
}

void branch(float len) {
  if (len<min) {
    return;
  }
  line(0, 0, 0, -len);
  translate(0, -len);
  
  pushMatrix();
  rotate(angle);
  branch(len*shortening);
  popMatrix();
  
  pushMatrix();
  rotate(-angle);
  branch(len*shortening);
  popMatrix();
  
  pushMatrix();
  branch(len*shortening);
  popMatrix();
}
