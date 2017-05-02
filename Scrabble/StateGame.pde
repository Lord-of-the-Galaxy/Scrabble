
// tabe state game  

boolean firstMove = true;
boolean firstMovePass = false;

void normalGame() {

  scrollbar = false;

  background(0);

  //first draw the grid
  for (int i = 0; i < 15; i++) {
    for (int j = 0; j < 15; j++) {
      grid[i][j].draw();
    }
  }

  //next draw the players
  for (int i = 0; i < players.length; i++) {
    players[i].draw();
  }

  //letters are drawn last
  for ( Letter currentLetter : letters) {  
    currentLetter.draw();
  }
}//func
//