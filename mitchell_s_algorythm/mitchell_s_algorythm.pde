int maxPoints = 10;
int pointsNum = width*height/30;

ArrayList<Point> points = new ArrayList<Point>();

void setup() {
  //size(600, 600);
  fullScreen();
  background(255);
  points.add(randomP());
  strokeWeight(8);
}

void draw() {
  for (int i = 0; i < points.size(); i++) {
    Point point = points.get(i);
    point.draw();
  }
  if (points.size()<pointsNum) {
    points.add(generate());
  }else{
    println("finished");
    stroke(255, 0, 0);
    for(int i = 0; i < pointsNum; i++){
      point(random(width), random(height));
    }
    noLoop();
  }
}

Point generate() {
  Point best = randomP();
  float bestDist = minDist(best);
  for (int i = 1; i < maxPoints; i++) {
    Point candidate = randomP();
    float dist = minDist(candidate);
    if (dist>bestDist) {
      bestDist = dist;
      best = candidate;
    }
  }
  return best;
}

float minDist(Point p) {
  float bestDist = p.dist(points.get(0));
  for (int i = 1; i < points.size(); i++) {
    Point point = points.get(i);
    float dist = p.dist(point);
    if (dist<bestDist) {
      bestDist=dist;
    }
  }
  return bestDist;
}
