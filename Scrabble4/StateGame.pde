
// tabe state game  

boolean firstMove = true;

void normalGame() {

  scrollbar = false;

  background(0);

  if (godmode) {

    if (firstTimeGodmode) {

      firstTimeGodmode=false;

      printArray(list);

      for (int i = 0; i < 15; i++) {
        for (int j = 0; j < 15; j++) {
          if (list[j].charAt(i) != '_') {
            println(list[j].charAt(i) );
            //grid[i][j].empty = false;
            //grid[i][j].used = true;
            println (i+", "+j);
            int x = int(i*S + XOFF + S/2);
            int y = int(j*S + YOFF + S/2);
            grid[i][j].put ( new Letter( list[j].charAt(i) ).show(x, y));
            grid[i][j].save();
          }//if
        }
      }
    }
  }

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