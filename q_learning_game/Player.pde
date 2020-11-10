class Player{
  float w, h;
  
  PVector pos, vel, acc;
  
  boolean isOnGround = false;
  boolean hasCollidedWithWalls = false;
  
  float frictionCooficient = 0.1;
  float maxXSpeed, maxYSpeed;
  
  PVector colour;
  
  boolean isAlive = true;
  
  Grid grid;
  
  Player(float _x, float _y, float _w, float _h, float _maxXSpeed, float _maxYSpeed, Grid _grid){
    pos = new PVector(_x, _y);
    acc = new PVector();
    vel = new PVector();
    colour = new PVector(50, 50, 255);
    w = _w;
    h = _h;
    maxXSpeed = _maxXSpeed;
    maxYSpeed = _maxYSpeed;
    grid = _grid;
  }
  
  void draw(){
    push();
    fill(colour.x, colour.y, colour.z);
    rect(pos.x - w/2, pos.y - h/2, w, h);
    pop();
  }
  
  void reset(float x, float y){
    pos.x = x;
    pos.y = y;
    vel.x = 0;
    vel.y = 0;
    
    isAlive = true;
  }
  
  void applyPhysics(float tileW, float tileH){
    pos.add(vel);
    vel.add(acc);
    acc.x = 0;
    acc.y = 0;
    
    isOnGround = false;
    hasCollidedWithWalls = false;
    
    
    //check for collisions
    //get the tiles that are touching the blob
    int minXIndex = floor((pos.x - w/2 - 0.01)/tileW);
    int minYIndex = floor((pos.y - h/2 - 0.01)/tileH);
    int maxXIndex = floor((pos.x + w/2 + 0.01)/tileW);
    int maxYIndex = floor((pos.y + h/2 + 0.01)/tileH);
    int[][] touchedSquaresIndexes = {
      {minXIndex, minYIndex},
      {maxXIndex, minYIndex},
      {minXIndex, maxYIndex},
      {maxXIndex, maxYIndex}
    };
    
    //filter out dublicates
    ArrayList<int[]> touchedSquaresIndexesArrayList = new ArrayList<int[]>();
    for(int i = 0; i < touchedSquaresIndexes.length; i++){
      //try to find in arraylist
      boolean hasFound = false;
      for(int j = 0; j < touchedSquaresIndexesArrayList.size(); j++){
        int[] checkedEntry = touchedSquaresIndexesArrayList.get(j);
        if(checkedEntry[0] == touchedSquaresIndexes[i][0] && checkedEntry[1] == touchedSquaresIndexes[i][1]){
          hasFound = true;
          break;
        }
      }
      if (!hasFound) touchedSquaresIndexesArrayList.add(touchedSquaresIndexes[i]);
    }
    
    int[] fills = {0, 100, 200, 255};
    
    for(int i = 0; i < touchedSquaresIndexesArrayList.size(); i++){
      //try array out of bounds
      try{
        int[] currentPoint = touchedSquaresIndexesArrayList.get(i);
        Tile currentTile = grid.tiles[currentPoint[0]][currentPoint[1]];
        
        //check collisions if not air
        if(currentTile.material != TileMaterials.Air){
          collideWithCell(currentPoint[0], currentPoint[1], tileW, tileH);
        }
      }catch(ArrayIndexOutOfBoundsException e){
        kill();
        return;
      }
    }
    
    //friction if collided
    if(isOnGround){
      vel = vel.mult(1 - frictionCooficient);
    }
    
    //clamp the y velocity
    if(Math.abs(vel.y) > maxYSpeed){
      vel.y = maxYSpeed * Math.signum(vel.y);
    }
  }
  
  void addForce(PVector force){
    acc.add(force);
  }
  
  void walk(float acceleration){
    //if less than max
    if(Math.abs(vel.x + acceleration) < maxXSpeed){
      addForce(new PVector(acceleration, 0));
    // if in the opposite direction
    } else if(Math.signum(acceleration) != Math.signum(vel.x)){
      addForce(new PVector(acceleration, 0));
     //if need to clamp
    }else if(Math.abs(vel.x) < maxXSpeed){
      vel.x = maxXSpeed * Math.signum(acceleration);
    }
  }
  
  void kill(){
    isAlive = false;
  }
  
  boolean collideWithCell(int tileXIndex, int tileYIndex, float tileW, float tileH){
    //check if the border is not encasing the player
    float currentTileCentreY = (tileYIndex * tileH + tileH/2);
    float distanceY = pos.y - currentTileCentreY;
    float currentTileCentreX = (tileXIndex * tileW + tileW/2);
    float distanceX = pos.x - currentTileCentreX;
    
    boolean isConfinedByY = Math.abs(distanceY) < tileH/2 + h/2;
    boolean isConfinedByX = Math.abs(distanceX) < tileW/2 + w/2;
    
    if(isConfinedByX && isConfinedByY){
      //find the scale factor of the velocity vector
      float distanceYToEdge = Math.signum(distanceY) * (tileH/2 + h/2 - Math.abs(distanceY));
      float distanceXToEdge = Math.signum(distanceX) * (tileW/2 + w/2 - Math.abs(distanceX));
      
      if(Math.abs(distanceXToEdge) > Math.abs(distanceYToEdge)){
        //reset
        vel.y = 0;
        pos.y = currentTileCentreY + Math.signum(distanceY) * (tileH/2 + h/2);
        //check if on ground and not on the ceiling
        if(Math.signum(distanceY) < 0) isOnGround = true;
      }else{
        pos.x = currentTileCentreX + Math.signum(distanceX) * (tileW/2 + w/2);
        vel.x = 0;
        hasCollidedWithWalls = true;
      }
    }
    
    return isConfinedByX && isConfinedByY;
  }
}
