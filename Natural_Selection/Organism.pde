class Organism {
  ArrayList<Organism> organisms;

  PVector vel;
  PVector acc;
  PVector pos;

  float maxSpeed, maxForce;

  float w = 10;

  Genome genome;

  PVector targetPos = null;

  public Organism(float x, float y, int numOfGenes, float maxSpeed, float maxForce) {
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    pos = new PVector(x, y);

    this.maxSpeed = maxSpeed;
    this.maxForce = maxForce;

    genome = new Genome(numOfGenes);
  }
  
  void setOrganisms(ArrayList<Organism> organisms){
    this.organisms = organisms;
  }

  void moveTo(PVector target) {
    PVector needed = PVector.sub(target, pos);
    needed.normalize().mult(maxSpeed);
    PVector error = PVector.sub(needed, vel);
    if (error.mag()>maxForce) {
      error.normalize();
      error.mult(maxForce);
    }
    force(error);
  }



  void eatFood(ArrayList<PVector> food) {
    for (int i = 0; i < food.size(); i++) {
      if (sqr(pos.x - food.get(i).x) + sqr(pos.y - food.get(i).y) < 30) {
        // eat the food
        food.remove(i);
        food.add(new PVector(random(0, width), random(0, height)));

        // reset target
        targetPos = null;
      }
    }
  }

  PVector findClosestIndex(ArrayList<PVector> targets) {
    // if already has a target, skip
    if (targetPos != null) {
      return targetPos;
    }

    int index = -1;
    float leastDistanceSquared = -1;

    for (int i = 0; i < targets.size(); i++) {
      // do not pick others targets
      if(checkIfSomebodysTarget(targets.get(i))){
        continue;
      }
      float newDist = sqr(pos.x - targets.get(i).x) + sqr(pos.y - targets.get(i).y);
      if (leastDistanceSquared == -1 || leastDistanceSquared > newDist) {
        leastDistanceSquared = sqr(pos.x - targets.get(i).x) + sqr(pos.y - targets.get(i).y);
        index = i;
      }
    }
    
    targetPos = targets.get(index);

    return targets.get(index);
  }

  boolean checkIfSomebodysTarget(PVector target) {
    for (int i = 0; i < organisms.size(); i++) {
      if (organisms.get(i).targetPos == target) {
        return true;
      }
    }

    return false;
  }



  void physics() {
    vel.add(acc);
    acc = new PVector(0, 0);
    pos.add(vel);
  }

  void force(float x, float y) {
    acc.add(new PVector(x, y));
  }

  void force(PVector f) {
    acc.add(f);
  }





  void draw() {
    pushStyle();
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, w, w);
    popStyle();
  }
}
