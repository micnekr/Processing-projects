class Ship extends Physics {
  float w = 30;
  float maxSpeed, maxForce;

  Ship(float x, float y, float maxSpeed_, float maxForce_) {
    super(x, y);
    maxSpeed=maxSpeed_;
    maxForce=maxForce_;
  }

  void draw() {
    ellipse(pos.x, pos.y, w, w);
  }

  void follow(PVector target) {
    moveTo(target, maxSpeed);
  }

  void follow(Path path) {
    PVector next = predict();
    PVector normPoint = null;
    int firstPt = 0;
    float recordDist = 0;
    for (int i = 0; i < path.points.size()-1; i++) {
      PVector p1 = path.points.get(i);
      PVector p2 = path.points.get(i+1);

      PVector candidate = getNormal(next, p1, p2);
      if (!(candidate.x>min(p1.x, p2.x)&&candidate.x<max(p1.x, p2.x))) {
        if (candidate.dist(p1)>candidate.dist(p2)) {
          candidate = p2.copy();
        } else {
          candidate = p1.copy();
        }
      }

      float dist = candidate.dist(next);
      if (dist<recordDist||recordDist==0) {
        firstPt = i;
        recordDist = dist;
        normPoint = candidate.copy();
      }
    }

    strokeWeight(64);
    stroke(255, 0, 0);
    point(normPoint.x, normPoint.y);
    strokeWeight(1);
    stroke(0);


    PVector pathDir = PVector.sub(path.points.get(firstPt+1), path.points.get(firstPt)).normalize();

    // if needed, follow a point
    if (recordDist>path.r) {
        pathDir.mult(maxSpeed*10);
        PVector target = PVector.add(normPoint, pathDir);
      follow(target);
    }
  }

  PVector getNormal(PVector next, PVector p1, PVector p2) {
    PVector fromStart = PVector.sub(next, p1);
    PVector pathDir = PVector.sub(p2, p1);  

    return PVector.add(PVector.mult(pathDir.normalize(), fromStart.dot(pathDir)), p1);
  }

  void approach(PVector target, float r) {
    float dist = pos.dist(target);
    if (dist>r) {
      follow(target);
    } else {
      moveTo(target, map(dist, 0, r, 0, maxSpeed));
    }
  }

  PVector predict() {
    return PVector.add(pos, vel);
  }

  void moveTo(PVector target, float mSpeed) {
    PVector needed = PVector.sub(target, pos);
    needed.normalize().mult(mSpeed);
    PVector error = PVector.sub(needed, vel);
    if (error.mag()>maxForce) {
      error.normalize();
      error.mult(maxForce);
    }
    force(error);
  }
}
