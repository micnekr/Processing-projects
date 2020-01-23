class Vector {
  int dims;
  float[] vals;

  Vector(float x_, float y_, float z_, float w_) {
    dims = 4;
    vals = new float[dims];
    vals[0] = x_;
    vals[1] = y_;
    vals[2] = z_;
    vals[3] = w_;
  }

  Vector(float x_, float y_, float z_) {
    dims = 3;
    vals = new float[dims];
    vals[0] = x_;
    vals[1] = y_;
    vals[2] = z_;
  }

  Vector(float[] vals_) {
    dims = vals_.length;
    vals = new float[dims];
    for (int i = 0; i < dims; i++) {
      vals[i] = vals_[i];
    }
  }













  PVector to3D() {
    return new PVector(vals[0], vals[1], vals[2]);
  }



  Vector copy() {
    return new Vector(vals);
  }

  Vector addVal(float val) {
    float[] newVals = new float[vals.length+1];
    for (int i = 0; i<vals.length; i++) {
      newVals[i] = vals[i];
    }
    newVals[vals.length] = val;
    return new Vector(newVals);
  }
}
