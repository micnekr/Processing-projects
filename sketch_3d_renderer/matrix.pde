float[][] toMat(PVector vec) {
  float[][] m = new float[3][1];
  m[0][0] = vec.x;
  m[1][0] = vec.y;
  m[2][0] = vec.z;
  return m;
}

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




PVector toVec(float [][] m) {
  PVector v = new PVector();
  if (m.length != 2 && m.length !=3) {
    println("not enough values for conversion");
    return null;
  }
  v.x = m[0][0];
  v.y = m[1][0];
  if (m.length==3) {
    v.z = m[2][0];
  }
  return v;
}


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


PVector mulToVec(float[][]a, float[][] b){
  return toVec(mul(a, b));
}

PVector mulToVec(float[][]a, PVector b){
  return toVec(mul(a, toMat(b)));
}
