float maxAInit = 2;
float maxBInit = 2;
float minAInit = -2;
float minBInit = -2;
float maxA, maxB, minA, minB;
float offsetX = -1;
float offsetY = 0;
float scaleX = 1;
float scaleY = 1;

int num = 100;
float maxNum = 2;

void setup() {
  size(1000, 1000);
  //fullScreen();
  updateTransform();
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float a = map(x, 0, width, minA, maxA);
      float b = map(y, 0, height, minB, maxB);

      color col;
      Complex c = new Complex(a, b);
      int tends = mandelbrotTest(c);

      float brightness = map(tends, 0, num, 0, 1);

      if (tends == num) {
        brightness = 0;
      }

      col = color(map(sqrt(brightness), 0, 1, 0, 255));

      pixels[index(x, y)] = col;
    }
  } 
  updatePixels();
  if (mousePressed) {
    offsetX += map(mouseX-pmouseX, 50, -50, -0.1, 0.1)*scaleX;
  }
  updateTransform();
}

void keyPressed() {
  if (keyCode == UP) {
    scaleX *= 0.90;
    scaleY *= 0.90;
  }else if(keyCode == DOWN){
    scaleX *= 1.1;
    scaleY *= 1.1;
  }else if(keyCode == RIGHT){
    num += 10;
  }else if(keyCode == LEFT){
    num -= 10;
    if(num<=0){
      num = 10;
    }
  }
}


int mandelbrotTest(Complex c) {
  Complex z = new Complex(0, 0);
  for (int n = 0; n < num; n++) {
    z = mandelbrotFun(z, c);

    if (abs(z.a)>maxNum || abs(z.b)>maxNum) {
      return n;
    }
  }
  return num;
}

Complex mandelbrotFun(Complex z, Complex c) {
  return z.mult(z).add(c);
}

int index(int x, int y) {
  return x + y*width;
}

void updateTransform() {
  maxA = scaleX*maxAInit;
  maxB = scaleY*maxBInit;
  minA = scaleX*minAInit;
  minB = scaleY*minBInit;
  maxA += offsetX;
  minA += offsetX;
  maxB += offsetY;
  minB += offsetY;
}
