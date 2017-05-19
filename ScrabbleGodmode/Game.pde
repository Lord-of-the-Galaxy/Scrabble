
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

void addPlayers() {
  if (!playersLoaded) {
    //make array
    players = new Player[playersN];//change, but only if you know what you're doing

    //define players

    String[] names = {"You", "AI 1", "AI 2", "AI3"};

    players[0] = new HumanPlayer(this, 0);
    players[0].name = names[0];
    players[0].drawLetters();

    for (int i = 1; i < players.length; i++) {
      players[i] = new SampleAIPlayer(this, i);//change this to name of you AI class
      players[i].name=names[i]; 
      players[i].isPlayedByComputer = true;
      players[i].drawLetters();
    }

    players[0].activate();
  } else {
    //make array
    players = new Player[playersN];//change, but only if you know what you're doing
    
    //define players

    String[] names = {"You", "AI 1", "AI 2", "AI 3"};

    players[0] = new HumanPlayer(this, 0);
    players[0].name = names[0];

    for (int i = 1; i < players.length; i++) {
      players[i] = new SampleAIPlayer(this, i);//change this to name of you AI class
      players[i].name=names[i]; 
      players[i].isPlayedByComputer = true;
    }

    giveAllLetters();
    players[0].drawLettersGodmode();
    for (int i = 1; i < players.length; i++) {
      players[i].drawLettersGodmode();
    }
    players[0].activate();
  }
}