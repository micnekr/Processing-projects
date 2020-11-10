class Grid{
  int h, w, d;
  Tile[][][] tiles;
  
  Grid(int _h, int _w, int _d){
    h = _h;
    w = _w;
    d = _d;
    
    tiles = new Tile[w][h][d];
    
    for(int x = 0; x < w; x++){
      for(int y = 0; y < h; y++){
        for(int z = 0; z < d; z++){
          tiles[x][y][z] = new Tile(TileMaterials.Air);
        }
      }
    }
  }
  
  void draw(float tileW, float tileH){
    push();
    stroke(255, 255, 255, 100);
    
    for(int x = 0; x < w; x++){
      for(int y = 0; y < h; y++){
          for(int z = 0; z < d; z++){
            Tile currentTile = tiles[x][y][z];
            int[] colour = new int[3];
            
            switch(currentTile.material){
              case Air:
              colour[0] = 150;
              colour[1] = 150;
              colour[2] = 255;
              break;
              case Brick:
              colour[0] = 200;
              colour[1] = 50;
              colour[2] = 50;
              break;
              default:
              colour[0] = 255;
              colour[1] = 0;
              colour[2] = 255;
            }
            fill(colour[0], colour[1], colour[2]);
            rect(x * tileW, y * tileH, tileW, tileH);
        }
      }
    }
    pop();
  }
}
