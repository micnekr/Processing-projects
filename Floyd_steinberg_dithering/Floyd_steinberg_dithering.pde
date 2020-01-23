PImage cat;
int possibilities = 4;
int[][] offsets = {
  {1, 0}, 
  {-1, 1}, 
  {0, 1}, 
  {1, 1}
};
float[] multipliers = {
  7.0/16.0, 3.0/16.0, 5.0/16.0, 1.0/16.0
};

int Iwidth, Iheight;

void setup() {
  cat = loadImage("kitten.jpg");
  size(1024, 512);
  image(cat, 0, 0);
  Iwidth = cat.width;
  Iheight = cat.height;
}

void draw() {
  cat.loadPixels();
  for (int y = 0; y < Iheight; y++) {
    for (int x = 0; x < Iwidth; x++) {
      color pix = cat.pixels[index(x, y)];
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);

      float newR = classify(oldR, possibilities);
      float newG = classify(oldG, possibilities);
      float newB = classify(oldB, possibilities);
      cat.pixels[index(x, y)] = color(newR, newG, newB);

      float dr = oldR-newR;
      float dg = oldG-newG;
      float db = oldB-newB;

      for (int i = 0; i < offsets.length; i++) {
        int newX = x+offsets[i][0];
        int newY = y+offsets[i][1];
        if (newX<Iwidth&&newY<Iheight&&newX>=0) {
          int index = index(newX, newY);
          color c = cat.pixels[index];
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          r += dr*multipliers[i];
          g += dg*multipliers[i];
          b += db*multipliers[i];

          cat.pixels[index] = color(r, g, b);
        }
      }
    }
  }
  cat.updatePixels();
  image(cat, Iwidth, 0);
}

float classify(float val, int possibs) {
  return round(possibs*val/255)*255/possibs;
}

int index(int x, int y) {
  return x+y*Iwidth;
}
