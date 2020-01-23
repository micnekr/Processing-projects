Cell[] grid;

int cols = 10;
int rows = 10;



int w, h;

void setup() {
  size(600, 600);
  w = floor(width/cols);
  h = floor(height/rows);

  grid = new Cell[cols*rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
    grid[index(i, j)] = new Cell(i, j, (i+j)%2==0);
  }}
}

void draw() {
  noStroke();
  for (int i = 0; i < cols*rows; i++) {
    fill(grid[i].draw());
    rect(grid[i].x, grid[i].y, w, h);
  }
}

int index(int x, int y) {
  return rows * y + x;
}
