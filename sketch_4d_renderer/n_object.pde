class Obj {
  Vector[] points;
  Vector[] renderP;
  int dims;
  Vector pos, scale;
  ArrayList<PVector> rots;

  Obj(Vector[] ps) {
    points = new Vector[ps.length];
    dims = ps[0].dims;
    for (int i = 0; i < ps.length; i++) {
      Vector point = ps[i];
      if (point.dims!=dims) {
        println("dimensions mismatch");
        return;
      }
      points[i] = new Vector(point.vals);
    }
    clear();
  }
  
  void clear(){
    float[] zeros = new float[dims];
    float[] ones = new float[dims];
    for (int i = 0; i<dims; i++) {
      zeros[i] = 0;
      ones[i] = 1;
    }
    pos = new Vector(zeros);
    scale = new Vector(ones);
    rots = new ArrayList<PVector>();
  }

  void addRot(int axis1, int axis2, float angle) {
    rots.add(new PVector(axis1, axis2, angle));
  }
  
  void translate(int axis, float amount){
    pos.vals[axis]+=amount;
  }
  
  void scale(int axis, float amount){
    scale.vals[axis]*=amount;
  }







  void render(float dist) {
    PVector[] projected = new PVector[points.length];
    renderP = new Vector[points.length];

    for (int i = 0; i<points.length; i++) {
      renderP[i] = new Vector(points[i].vals);
    }

    for (int i = 0; i<renderP.length; i++) {
      Vector point = renderP[i];

      // rotate
      for (int j = 0; j < rots.size(); j++) {
        PVector rotation = rots.get(j);
        point = rotate(point, int(rotation.x), int(rotation.y), dims, rotation.z);
      }
      
      //translate
      point = toVec(elAdd(toMat(point), toMat(pos)));
      
      //scale
      point = toVec(elMult(toMat(point), toMat(scale)));

      // project
      projected[i] = projectFull(point, dims, dist).to3D();
    }
    // clear
    clear();
    
    // draw
    draw(projected);
  }

  void draw(PVector[] points) {
    beginShape(TRIANGLE_STRIP);
    for(PVector p:points){
      vertex(p.x, p.y, p.z);
    }
    endShape(CLOSE);
  }
}
