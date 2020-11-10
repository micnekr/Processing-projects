enum TileMaterials{
  Air,
  Brick,
  Grass
}


class Tile{
  TileMaterials material;
  
  Tile(TileMaterials _material){
    material = _material;
  }
  
  void setMaterial(TileMaterials _material){
    material = _material;
  }
}
