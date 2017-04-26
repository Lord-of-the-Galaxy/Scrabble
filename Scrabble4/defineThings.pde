
//TAB : DEFINE THINGS

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
  grid[7][3].setType(gridDoubleLetter);
  grid[8][2].setType(gridDoubleLetter);
  grid[6][2].setType(gridDoubleLetter);
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

void initLetters() {
  defineValuePoints('A', 1);
  defineValuePoints('B', 3);
  defineValuePoints('C', 3);
  defineValuePoints('D', 2);
  defineValuePoints('E', 1);
  defineValuePoints('F', 4);
  defineValuePoints('G', 2);
  defineValuePoints('H', 4);
  defineValuePoints('I', 1);
  defineValuePoints('J', 8);
  defineValuePoints('K', 5);
  defineValuePoints('L', 1);
  defineValuePoints('M', 3);
  defineValuePoints('N', 1);
  defineValuePoints('O', 1);
  defineValuePoints('P', 3);
  defineValuePoints('Q', 10);
  defineValuePoints('R', 1);
  defineValuePoints('S', 1);
  defineValuePoints('T', 1);
  defineValuePoints('U', 1);
  defineValuePoints('V', 4);
  defineValuePoints('W', 4);
  defineValuePoints('X', 8);
  defineValuePoints('Y', 4);
  defineValuePoints('Z', 10);
  defineValuePoints(' ', 0);

  generateXLetters('A', 9);
  generateXLetters('B', 2);
  generateXLetters('C', 2);
  generateXLetters('D', 4);
  generateXLetters('E', 12);
  generateXLetters('F', 2);
  generateXLetters('G', 3);
  generateXLetters('H', 2);
  generateXLetters('I', 9);
  generateXLetters('J', 1);
  generateXLetters('K', 1);
  generateXLetters('L', 4);
  generateXLetters('M', 2);
  generateXLetters('N', 6);
  generateXLetters('O', 8);
  generateXLetters('P', 2);
  generateXLetters('Q', 1);
  generateXLetters('R', 6);
  generateXLetters('S', 4);
  generateXLetters('T', 6);
  generateXLetters('U', 4);
  generateXLetters('V', 2);
  generateXLetters('W', 2);
  generateXLetters('X', 1);
  generateXLetters('Y', 2);
  generateXLetters('Z', 1);
  generateXLetters(' ', 2);

  Collections.shuffle(pile);
  println("Contents of pile:");
  // for (int i = 0; i < pile.size(); println(pile.get(i++)));
}

void defineValuePoints(char c, int s) {
  values.put(c, s);
}

void generateXLetters(char c, int no) {
  for (int i = 0; i < no; i++) {
    Letter l = new Letter(c);
    letters.add(l);
    pile.add(l);
  }
}
//