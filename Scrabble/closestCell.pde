

Cell closestCell(Letter l) {
  
  int i = (int)((l.x - XOFF)/S);
  int j = (int)((l.y - YOFF)/S);
  
  if (i >= 0 && i < 15 && j >= 0 && j < 15)
    return grid[i][j];
  return null;
}
//