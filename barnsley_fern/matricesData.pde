float[][] m1 = {
  {0.00, 0.00}, 
  {0.00, 0.16}
};
float[][] m1a = {
  {0.00}, 
  {0.00}
};



float[][] m2 = {
  {0.85, 0.04}, 
  {-0.04, 0.85}
};
float[][] m2a = {
  {0.00}, 
  {1.60}
};



float[][] m3 = {
  {0.20, -0.26}, 
  {0.23, 0.22}
};
float[][] m3a = {
  {0.00}, 
  {1.60}
};



float[][] m4 = {
  {-0.15, 0.28}, 
  {0.26, 0.24}
};
float[][] m4a = {
  {0.00}, 
  {0.44}
};

float[][][] set1 = {
  m1, m1a
};
float[][][] set2 = {
  m2, m2a
};
float[][][] set3 = {
  m3, m3a
};
float[][][] set4 = {
  m4, m4a
};

float[][][][] sets = {
  set1, set2, set3, set4
};





float[] probabs = {
  0.01, 0.85, 0.07, 0.07
};

int pickOne(){
  float r = random(1);
  int index = 0;
  while(r>0){
    r -= probabs[index];
    index++;
  }
  index--;
  return index;
}
