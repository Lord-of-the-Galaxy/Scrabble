


void initGrid() {
  for (int i = 0; i < 15; i++) {
    for (int j = 0; j < 15; j++) {
      grid[i][j] = new Cell(i, j); // set all cells to type default
    }
  }
  setSpecialTypes();
}

void setSpecialTypes() {

  // source http://bazaar.launchpad.net/~guillaumemiranda/javascrabble/gandalf/view/head:/src/principale/Plateau.java

  grid[7][7].setType(gridStar);

  // case  motcomptetriple
  grid[0][0].setType(gridTripleWord);
  grid[14][14].setType(gridTripleWord);
  grid[14][0].setType(gridTripleWord);
  grid[0][14].setType(gridTripleWord);
  grid[0][7].setType(gridTripleWord);
  grid[7][0].setType(gridTripleWord);
  grid[14][7].setType(gridTripleWord);
  grid[7][14].setType(gridTripleWord);

  // case motcomptedouble
  grid[1][1].setType(gridDoubleWord);
  grid[2][2].setType(gridDoubleWord);
  grid[3][3].setType(gridDoubleWord);
  grid[4][4].setType(gridDoubleWord);
  grid[10][10].setType(gridDoubleWord);
  grid[11][11].setType(gridDoubleWord);
  grid[12][12].setType(gridDoubleWord);
  grid[13][13].setType(gridDoubleWord);
  grid[13][1].setType(gridDoubleWord);
  grid[12][2].setType(gridDoubleWord);
  grid[11][3].setType(gridDoubleWord);
  grid[10][4].setType(gridDoubleWord);
  grid[4][10].setType(gridDoubleWord);
  grid[3][11].setType(gridDoubleWord);
  grid[2][12].setType(gridDoubleWord);
  grid[1][13].setType(gridDoubleWord);

  // case lettrecomptedouble
  grid[3][0].setType(gridDoubleLetter);
  grid[11][7].setType(gridDoubleLetter);
  grid[7][11].setType(gridDoubleLetter);
  grid[6][12].setType(gridDoubleLetter);
  grid[8][12].setType(gridDoubleLetter);
  grid[12][8].setType(gridDoubleLetter);
  grid[12][6].setType(gridDoubleLetter);
  grid[2][6].setType(gridDoubleLetter);
  grid[2][8].setType(gridDoubleLetter);
  grid[3][7].setType(gridDoubleLetter);
  grid[7][4].setType(gridDoubleLetter);
  grid[8][3].setType(gridDoubleLetter);
  grid[6][3].setType(gridDoubleLetter);
  grid[14][11].setType(gridDoubleLetter);
  grid[11][14].setType(gridDoubleLetter);
  grid[14][3].setType(gridDoubleLetter);
  grid[3][14].setType(gridDoubleLetter);
  grid[0][11].setType(gridDoubleLetter);
  grid[11][0].setType(gridDoubleLetter);
  grid[6][6].setType(gridDoubleLetter);
  grid[6][8].setType(gridDoubleLetter);
  grid[8][6].setType(gridDoubleLetter);
  grid[8][8].setType(gridDoubleLetter);
  grid[0][3].setType(gridDoubleLetter);

  // case lettrecomptetriple
  grid[5][1].setType(gridTripleLetter);
  grid[13][9].setType(gridTripleLetter);
  grid[9][13].setType(gridTripleLetter);
  grid[5][13].setType(gridTripleLetter);
  grid[13][5].setType(gridTripleLetter);
  grid[9][9].setType(gridTripleLetter);
  grid[5][5].setType(gridTripleLetter);
  grid[5][9].setType(gridTripleLetter);
  grid[9][5].setType(gridTripleLetter);
  grid[9][1].setType(gridTripleLetter);
  grid[1][9].setType(gridTripleLetter);
  grid[1][5].setType(gridTripleLetter);
}// func
//