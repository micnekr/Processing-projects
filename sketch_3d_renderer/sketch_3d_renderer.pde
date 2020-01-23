PVector[] points = new PVector[8];

float angle = 0;
float d = 3;

void setup() {
  size(600, 600);


  points[0] = new PVector(-1, -1, -1);
  points[1] = new PVector(1, -1, -1);
  points[2] = new PVector(1, 1, -1);
  points[3] = new PVector(-1, 1, -1);
  points[4] = new PVector(-1, -1, 1);
  points[5] = new PVector(1, -1, 1);
  points[6] = new PVector(1, 1, 1);
  points[7] = new PVector(-1, 1, 1);
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  translate(width/2, height/2);

  // matrices
  float[][] rotZ = {
    {cos(angle), -sin(angle), 0}, 
    {sin(angle), cos(angle), 0}, 
    {0, 0, 1}
  };

  float[][] rotX = {
    {1, 0, 0}, 
    {0, cos(angle), -sin(angle)}, 
    {0, sin(angle), cos(angle)}};

  float[][] rotY = {
    {cos(angle), 0, -sin(angle)}, 
    {0, 1, 0}, 
    { sin(angle), 0, cos(angle)}};
    


  // draw
  PVector[] ps = new PVector[points.length];
  for (int i = 0; i < points.length; i++) {
    PVector p = points[i];
    PVector rotated = mulToVec(rotY, p);
    rotated = mulToVec(rotX, rotated);
    rotated = mulToVec(rotZ, rotated);
    
    // project
    
    float z = 1/(d-rotated.z);
    float[][] projection = {
      {z, 0, 0},
      {0, z, 0}
    };
    
    PVector projected = mulToVec(projection, rotated);
    projected.mult(200);
    ps[i] = projected;
  }
  
  strokeWeight(1);
  for(int i = 0; i < 4; i++){
    connect(i, (i+1)%4, ps);
    connect(4+i, 4+(i+1)%4, ps);
    connect(i, i+4, ps);
  }
  
  angle += radians(1);
}









void connect(int i, int j, PVector[] points){
  PVector a = points[i];
  PVector b = points[j];
  line(a.x, a.y, b.x, b.y);
}
