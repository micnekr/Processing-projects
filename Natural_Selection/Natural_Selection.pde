ArrayList<PVector> food;
ArrayList<Organism> organisms;

Organism h1 = new Organism(0, 0, 1, 10, 1);
Organism h2 = new Organism(600, 600, 1, 10, 1);

void setup() {
  size(600, 600);

  food = new ArrayList<PVector>();
  organisms = new ArrayList<Organism>();

  food.add(new PVector(random(0, width), random(0, height)));
  food.add(new PVector(random(0, width), random(0, height)));
  food.add(new PVector(random(0, width), random(0, height)));
  
  organisms.add(h1);
  organisms.add(h2);
  
  h1.setOrganisms(organisms);
  h2.setOrganisms(organisms);
}

void draw() {
  background(255);

  h1.moveTo(h1.findClosestIndex(food));

  h1.physics();
  
  h1.eatFood(food);

  h1.draw();
  
  h2.moveTo(h2.findClosestIndex(food));

  h2.physics();
  
  h2.eatFood(food);

  h2.draw();

  pushStyle();
  fill(0, 255, 0);
  for (int i = 0; i < food.size(); i++) {
    ellipse(food.get(i).x, food.get(i).y, 10, 10);
  }
  popStyle();
}

float sqr(float a) {
  return a*a;
}
