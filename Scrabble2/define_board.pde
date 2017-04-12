//PLEASE DO THE JOB HERE - I NEED YOU TO SET THE TYPE FOR THE CELLS CORRECTLY. THANKS!

void initGrid(){
  for(int i = 0; i < 15; i++){
    for(int j = 0; j < 15; j++){
      if(i == 7 && j == 7)grid[i][j] = new Cell(i, j, 1);
      else grid[i][j] = new Cell(i, j);
    }
  }
}