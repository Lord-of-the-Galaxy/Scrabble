
// tabe state game  

boolean firstMove = true;

void normalGame() {

  background(0);

  //first draw the grid
  for (int i = 0; i < 15; i++) {
    for (int j = 0; j < 15; j++) {
      grid[i][j].draw();
    }
  }

  //next the players
  for (int i = 0; i < players.length; i++) {
    players[i].draw();
    //players[i].drawLetters();
  }

  //letters are drawn last
  for (int i = 0; i < letters.size(); i++) {
    Letter currentLetter = letters.get(i);
    currentLetter.draw();
  }
}//func
//