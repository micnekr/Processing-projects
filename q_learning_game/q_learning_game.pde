Grid grid;
Player player;

//actions
enum Actions{
  //DO_NOTHING,
  GO_LEFT,
  GO_RIGHT,
  JUMP
}

//player
float initPlayerX = 30;
float initPlayerY = 30;

float maxXSpeed = 5;
float maxYSpeed = 6;
float jumpForce = 6;

//grid
float tileW = 70;
float tileH = 70;

//Learning variables
final PVector targetPoint = new PVector(390, 100);
final float maxProximityToTargetForVictory = 50;

final int positionNumberOfStates = 20;
final int velocityNumberOfStates = 20;

final float learningRate = 0.05;
final float discount = 0.99;
final float randomActionsFrequency = 0.2;

final int showEveryEpisode = 10000;

final int framesUntilCompletion = 600;

int windowSize = 400;

// variables
int framesPassed = 0;
int episodeIndex = 0;
boolean isShowing = false;
int winsSinceLastShown = 0;

QTable table;

void setup(){
  int[] stateNumbers = {positionNumberOfStates, positionNumberOfStates, velocityNumberOfStates, velocityNumberOfStates};
  table = new QTable(Actions.values().length, stateNumbers, -1, 0);
  
  
  grid = loadFile("lvl3.lvl");
  
  //calculate the height
  tileW = tileH = windowSize/grid.tiles.length;
  
  player = new Player(initPlayerX,initPlayerY, 20, 20, maxXSpeed, maxYSpeed, grid);
  
  size(400, 400);
}

void draw(){
  if(!isShowing){
    for(int i = 0; i < showEveryEpisode; i++){
      println(episodeIndex);
      //evaluates to true when the game finishes
      while(!qLearnStep()){}
      episodeIndex++;
    }
    println(episodeIndex);
    println("Wins percentage:");
    println(float(winsSinceLastShown)/showEveryEpisode * 100);
  }
  
  winsSinceLastShown = 0;
  isShowing = !qLearnStep();
  //if(keyPressed){
  //  float movementSpeed = 0.5;
  //  if(keyCode == UP){
  //    if(player.isOnGround) player.addForce(new PVector(0, -jumpForce));
  //  }else if(keyCode == RIGHT){
  //    player.walk(movementSpeed);
  //  }else if(keyCode == LEFT){
  //    player.walk(-movementSpeed);
  //  }
  //}
  
  //only draw if the episode number is correct
  background(255);
  
  grid.draw(tileW, tileH);
  //player.addForce(new PVector(0, 0.1));
  //player.applyPhysics(tileW, tileH);
  //draw an ellipse at the target
  push();
  fill(0, 255, 0);
  ellipse(targetPoint.x, targetPoint.y, maxProximityToTargetForVictory, maxProximityToTargetForVictory);
  pop();
  player.draw();
}

Grid loadFile(String fileName){
  String[] fileLines = loadStrings(fileName);
  
  //first row is the size
  String metaDataRow = fileLines[0];
  String[] metaData = split(metaDataRow, ',');
  
  int w = int(metaData[0]);
  int h = int(metaData[1]);
  
  //the next ones are the tiles in the level
  Grid level = new Grid(w, h);
  
  for(int y = 0; y < h; y++){
    String[] row = split(fileLines[y+1], ",");
    for(int x = 0; x < w; x++){
      TileMaterials material = TileMaterials.values()[int(row[x])];
      level.tiles[x][y].setMaterial(material);
    }
  }
  
  return level;
}

QRow getActionQValues(Player p) throws Exception{
  int xIndex = floor(p.pos.x / (tileW * grid.w) * positionNumberOfStates);
  int yIndex = floor(p.pos.y / (tileH * grid.h) * positionNumberOfStates);
  
  //division by slightly more than what is needed because it will round to one more than needed if maxSpeed is an integer otherwise and cause an array overflow
  int xVelocityIndex = floor(p.vel.x/(maxXSpeed * 2.01) * velocityNumberOfStates + (velocityNumberOfStates / 2f));
  int yVelocityIndex = floor(p.vel.y/(maxYSpeed * 2.01) * velocityNumberOfStates + (velocityNumberOfStates / 2f));
  return (QRow) table.table.get(xIndex).get(yIndex).get(xVelocityIndex).get(yVelocityIndex);
}

int getMaxIndex(QRow possibleActions){
  int chosenActionIndex = 0;
  float chosenActionValue = ((QValue)possibleActions.get(0)).value;
  
  for(int actionIndex = 0; actionIndex < possibleActions.entries.length; actionIndex++){
    float actionValue = ((QValue)possibleActions.get(actionIndex)).value;
    if(chosenActionValue < actionValue){
      chosenActionIndex = actionIndex;
      chosenActionValue = actionValue;
    }
  }
  
  return chosenActionIndex;
}

boolean qLearnStep(){
  //TODO: only find the qvalues once per loop
  boolean hasBeenReset = false;
  
  //determine the state and action
  int chosenActionIndex;
  QRow possibleActions;
    try{
      possibleActions = getActionQValues(player);
    }catch(Exception e){
      println("Table indexing issue, please check the table shape");
      e.printStackTrace(System.out);
      return false;
    }
    
  if(randomActionsFrequency < random(1)){
    chosenActionIndex = getMaxIndex(possibleActions);
  }else{
    chosenActionIndex = floor(random(Actions.values().length));
  }
  float chosenActionValue = ((QValue)possibleActions.get(chosenActionIndex)).value;
    
  Actions currentAction = Actions.values()[chosenActionIndex];
  
  //float movementSpeed = player.isOnGround ? 0.5 : 0.2;
  float movementSpeed = 0.5;
  //play out the action
  switch(currentAction){
    //case DO_NOTHING:
    //break;
    case GO_LEFT:
    player.walk(-movementSpeed);
    break;
    case GO_RIGHT:
    player.walk(movementSpeed);
    break;
    case JUMP:
    if(player.isOnGround) player.addForce(new PVector(0, -jumpForce));
    break;
    default:
    break;
  }
  
  //apply actions
  player.addForce(new PVector(0, 0.1));
  player.applyPhysics(tileW, tileH);
  
  //get the score
  float score = -0.1;
  PVector vectorToTarget = PVector.sub(targetPoint, player.pos);
  
  //compare the squares of distances
  if(vectorToTarget.x * vectorToTarget.x + vectorToTarget.y * vectorToTarget.y < maxProximityToTargetForVictory * maxProximityToTargetForVictory){
    score = 100;
    //reset the player
    player.reset(initPlayerX, initPlayerY);
    framesPassed = 0;    
    hasBeenReset = true;
    println("won!");
    winsSinceLastShown++;
  }else if(!player.isAlive){
    score = -50;
    player.reset(initPlayerX, initPlayerY);
    framesPassed = 0;
    hasBeenReset = true;
  }
  
  // check if it is the last frame and reset everything if it is
  if(framesPassed >= framesUntilCompletion) {
    score = -50;
    player.reset(initPlayerX, initPlayerY);
    framesPassed = 0;
    hasBeenReset = true;
  }
  
  //update the q values
  //get the future max q value
  QRow futureActions;
  try{
    futureActions = getActionQValues(player);
  }catch(Exception e){
    println("Table indexing issue, please check the table shape");
    e.printStackTrace(System.out);
    return false;
  }
  float futureActionValue = ((QValue)futureActions.get(getMaxIndex(futureActions))).value;
  //generate the new q value
  float newActionValue = (1 - learningRate) * chosenActionValue + learningRate * (score + discount * futureActionValue);
  //println(chosenActionValue, futureActionValue, newActionValue);
    
  possibleActions.set(chosenActionIndex, new QValue(newActionValue));
    
  if(hasBeenReset) return true;
  
  framesPassed++;
  
  return false;
}
