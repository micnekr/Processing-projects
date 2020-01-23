float w = 500;
float speed = 1;
float spacing = 0.8;


float angle = -HALF_PI;
int rows;
int cols;

Circle[] circlesX;
Circle[] circlesY;
Figure[][] figures;

void setup() {
  fullScreen(P2D);

  rows = floor(height/w)-1;
  cols = floor(width/w)-1;
  circlesY = new Circle[rows];
  circlesX = new Circle[cols];
  figures = new Figure[cols][rows];

  for (int i = 0; i<cols; i++) {
    circlesX[i] = new Circle(w*(1.5+i), w/2, w*spacing, i+1);
  }
  for (int i = 0; i<rows; i++) {
    circlesY[i] = new Circle(w/2, w*(1.5+i), w*spacing, i+1);
  }
  initFig();
}

void draw() {
  background(0);
  for (int i = 0; i < cols; i++) {
    Circle c = circlesX[i];
    c.update(angle);
    c.draw();
    for(int j = 0; j < rows; j++){
      figures[i][j].loading.y = c.pyraw;
    }
  }
  for (int i = 0; i < rows; i++) {
    Circle c = circlesY[i];
    c.update(angle);
    c.draw();
    for(int j = 0; j < cols; j++){
      figures[j][i].loading.x = c.pxraw;
    }
  }
  stroke(255);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      figures[i][j].apply();
      figures[i][j].draw();
    }
  }
  angle += radians(speed);
  if(angle > PI+HALF_PI){
    angle = -HALF_PI;
    initFig();
  }
}



void initFig(){
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      figures[i][j] = new Figure(w*(1.5+i), w*(1.5+j), w*spacing/2);
    }
  }
}
