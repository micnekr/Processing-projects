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

float[][] add(float[][]a, float[][] b){
  int colsA = a[0].length;
  int rowsA = a.length;
  int colsB = b[0].length;
  int rowsB = b.length;
  if(rowsA!=rowsB){
    println("rows of matrices are not matching");
    return null;
  }
  float[][] result = new float[rowsA][colsA];
  for(int i = 0; i<rowsA; i++){
    for(int j = 0; j<colsA; j++){
      result[i][j] = 0;
      result[i][j] = a[i][j] + b[i][0];
    }
  }
  return result;
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
