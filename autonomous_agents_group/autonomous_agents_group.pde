//Ship s = new Ship(0, 300, 10, 1);
ArrayList<Ship> ships = new ArrayList<Ship>();
int shipNum = 1000;

void setup() {
  //size(600, 600);
  fullScreen();
  for (int i = 0; i< shipNum; i++) {
    ships.add(new Ship(random(width), random(height), 4, 0.1));
  }
}

void draw() {
  background(255);
  for (Ship ship : ships) {
    ship.forceMult = 2;
    ship.separate(ships, 60);
    ship.forceMult = 1;
    ship.align(ships, 300);
    ship.forceMult = 1.5;
    ship.group(ships, 100);
    //ship.follow(new PVector(mouseX, mouseY));
    if(ship.pos.x<0){
      ship.pos.x = width;
    }
    if(ship.pos.x>width){
      ship.pos.x = 0;
    }
    if(ship.pos.y<0){
      ship.pos.y = height;
    }
    if(ship.pos.y>height){
      ship.pos.y = 0;
    }
    ship.physics();
    ship.draw();
  }
}
