// matrix multiplication
float[][] mul(float[][]a, float[][] b) {
  int colsM1 = a[0].length;
  int rowsM1 = a.length;

  int colsM2 = b[0].length;
  int rowsM2 = b.length;

  if (colsM1!=rowsM2) {
    println("columns of first matrix are not matching rows of the second matrix");
    return null;
  }

  float [][]result = new float[rowsM1][colsM2];

  for (int i = 0; i < rowsM1; i++) {
    for (int j = 0; j < colsM2; j++) {
      float sum = 0;
      for (int k = 0; k < rowsM1; k++) {
        sum += a[i][k] * b[k][j];
      }
      result[i][j] = sum;
    }
  }

  return result;
}






// elementwise
float[][] elAdd(float[][]a, float[][] b){
  int colsA = a[0].length;
  int rowsA = a.length;

  int colsB = b[0].length;
  int rowsB = b.length;
  
  if (!(colsA==colsB&&rowsA==rowsB)) {
    println("sizes of matrices do not match");
    return null;
  }
  
  float [][]result = new float[rowsA][colsA];
  
  for (int i = 0; i < rowsA; i++) {
    for (int j = 0; j < colsA; j++) {
      result[i][j] = a[i][j]+b[i][j];
    }
  }
  
  return result;
}

float[][] elAdd(float[][]a, Vector b){
  int colsA = a[0].length;
  int rowsA = a.length;

  int sizeB = b.vals.length;
  
  if (rowsA!=sizeB) {
    println("rows of matrix and vector do not match");
    return null;
  }
  
  float [][]result = new float[rowsA][colsA];
  
  for (int i = 0; i < rowsA; i++) {
    for (int j = 0; j < colsA; j++) {
      result[i][j] = a[i][j]+b.vals[i];
    }
  }
  
  return result;
}



float[][] elMult(float[][]a, float[][] b){
  int colsA = a[0].length;
  int rowsA = a.length;

  int colsB = b[0].length;
  int rowsB = b.length;
  
  if (!(colsA==colsB&&rowsA==rowsB)) {
    println("sizes of matrices do not match");
    return null;
  }
  
  float [][]result = new float[rowsA][colsA];
  
  for (int i = 0; i < rowsA; i++) {
    for (int j = 0; j < colsA; j++) {
      result[i][j] = a[i][j]*b[i][j];
    }
  }
  
  return result;
}

float[][] elMult(float[][]a, Vector b){
  int colsA = a[0].length;
  int rowsA = a.length;

  int sizeB = b.vals.length;
  
  if (rowsA!=sizeB) {
    println("rows of matrix and vector do not match");
    return null;
  }
  
  float [][]result = new float[rowsA][colsA];
  
  for (int i = 0; i < rowsA; i++) {
    for (int j = 0; j < colsA; j++) {
      result[i][j] = a[i][j]*b.vals[i];
    }
  }
  
  return result;
}






// displaying
void printM(float[][] m) {
  int cols = m[0].length;
  int rows = m.length;
  println(rows+"x"+cols);
  println("---");
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      print(m[i][j] + " ");
    }
    println();
  }
  println();
  println();
}




















//converting
Vector mulToVec(float[][]a, Vector b) {
  float[][] m = mul(a, toMat(b));
  return toVec(m);
}

Vector toVec(float[][] m) {
  float[] vecVals = new float[m.length];
  for (int i = 0; i < m.length; i++) {
    vecVals[i] = m[i][0];
  }
  return new Vector(vecVals);
} 

float[][] toMat(Vector vec) {
  float[][] m = new float[vec.vals.length][1];
  for (int i = 0; i < vec.vals.length; i++) {
    m[i][0] = vec.vals[i];
  }
  return m;
}
















// graphics
Vector project(Vector point, int dims, float dist) {
  float scale = dist/(dist-point.vals[dims-1]);
  if(scale<0){
    println("too close to see object");
  }
  float[][] projMat = new float[dims-1][dims];
  for (int i = 0; i<dims-1; i++) {
    for (int j = 0; j<dims; j++) {
      if (i==j) {
        projMat[i][j] = scale;
      } else {
        projMat[i][j] = 0;
      }
    }
  }
  return mulToVec(projMat, point);
}

Vector projectFull(Vector startPoint, int startDims, float dist) {
  if (startDims==3) {
    return startPoint;
  } else {
    Vector point = project(startPoint, startDims, dist);
    return projectFull(point, startDims-1, dist);
  }
}










int X = 0;
int Y = 1;
int Z = 2;
int W = 3;
int V = 4;

Vector rotate(Vector point, int axis1, int axis2, int dims, float angle_) {
  if (axis1>=axis2) {
    println("Invalid rotation");
    return null;
  }
  float[][] rotMat = new float[dims][dims];
  for (int i = 0; i < dims; i++) {
    for (int j = 0; j < dims; j++) {
      rotMat[i][j] = 0;
    }
  }


  for (int i = 0; i < dims; i++) {
    if (i==axis1||i==axis2) {
      rotMat[axis1][axis1] = cos(angle_);
      rotMat[axis1][axis2] = -sin(angle_);
      rotMat[axis2][axis1] = sin(angle_);
      rotMat[axis2][axis2] = cos(angle_);
    } else {
      for (int j = 0; j < dims; j++) {
        if (j==i) {
          rotMat[i][j] = 1;
        }
      }
    }
  }
  return mulToVec(rotMat, point);
}




Vector scale(Vector p, float factor){
  Vector result = new Vector(p.vals);
  for(int i = 0; i<result.vals.length; i++){
    result.vals[i] *= factor;
  }
  return result;
}

Vector scale(Vector p, Vector factor){
  Vector result = new Vector(p.vals);
  for(int i = 0; i<result.vals.length; i++){
    result.vals[i] *= factor.vals[i];
  }
  return result;
}
