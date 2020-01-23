int pointsNum(int dim) {
  return int(pow(2, dim));
}

Vector[] constructCube(Vector[] points, int dims, float mag) {
  int pointsNum = 2;

  float[] magP = new float[1];
  float[] magN = new float[1];
  magP[0] = mag;
  magN[0] = -mag;

  points[0] = new Vector(magP);
  points[1] = new Vector(magN);
  for (int i = 0; i<dims-1; i++) {
    for (int j = 0; j<pointsNum; j++) {
      points[j+pointsNum] = points[j].copy();
      points[j] = points[j].addVal(mag);
      points[j+pointsNum] = points[j+pointsNum].addVal(-mag);
    }
    pointsNum *= 2;
  }
  return points;
}

Cube constructCubeObj(Vector[] points, int dims, float mag){
  return new Cube(constructCube(points, dims, mag));
}





 

class Cube extends Obj{
  Cube(Vector[] ps){
    super(ps);
  }
  
  void draw(PVector[] points) {
    connect(points);
  }
  
  void connect(PVector[] points) {
  if (points.length==2) {
    PVector a = points[0];
    PVector b = points[1];
    line(a.x, a.y, a.z, b.x, b.y, b.z);
    return;
  }
  PVector[] half = new PVector[points.length/2];
  for (int i = 0; i < points.length/2; i++) {
    half[i] = points[i];
  }
  connect(half);
  PVector[] halfsec = new PVector[points.length/2];
  for (int i = 0; i < points.length/2; i++) {
    halfsec[i] = points[i+points.length/2];
  }
  connect(halfsec);

  for (int i = 0; i<points.length/2; i++) {
    PVector a = points[i];
    PVector b = points[i+points.length/2];
    line(a.x, a.y, a.z, b.x, b.y, b.z);
  }
}
}
