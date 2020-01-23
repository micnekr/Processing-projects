int dir = 0;
int xl, yl;
int steps = 10000;

void setup() {
  size(200, 200);
  //fullScreen();
  background(255);
  xl = width/2;
  yl = height/2;
}

void draw() {
  for (int i = 0; i<steps; i++) {
    loadPixels();
    int index = index(xl, yl);
    color state = pixels[index];
    LAstep(classify(state));
    pixels[index] = color(255-red(state));
    updatePixels();
  }
}

int index(int x, int y) {
  x = int(mod(x, width));
  y = int(mod(y, height));
  return x + y*width;
}

float mod(float num1, float num2) {
  num1 %= num2;
  while (num1<0) {
    num1+=num2;
  }
  return num1;
}

void LAstep(int state) {
  if (state==0) {
    dir--;
    if (dir<0) {
      dir = 3;
    }
  } else {
    dir++;
    if (dir>3) {
      dir = 0;
    }
  }
  switch(dir) {
  case 0:
    yl--;
    break;
  case 1:
    xl++;
    break;
  case 2:
    yl++;
    break;
  case 3:
    xl--;
    break;
  }
}

int classify(color state){
  int r = int(red(state));
  int g = int(green(state));
  int b = int(blue(state));
  if(r==0){
    return 0;
  }else{
    return 255;
  }
}
