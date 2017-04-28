
// tab for states / all called by draw() 

String text1="Welcome to Scrabble";
String text2="Welcome";

Letter[] letterWelcome = new Letter[text1.length()]; 
Letter[] letterWelcome2 = new Letter[text2.length()];

Button[] buttonsStartScreen = new Button[3];   

void initWelcomeScreen() {

  // define part ----------------------------

  // define I
  for (int i=0; i<text1.length(); i++) {
    letterWelcome[i] = 
      new Letter (text1.charAt(i), 40*i + 80, 280 );
  }//for 

  // define II
  for (int i=0; i<text2.length(); i++) {
    letterWelcome2[i] = 
      new Letter (text2.charAt(i), 40*1 + 80, i*40+280-(1*40));
  }//for 

  // define III
  
  
  buttonsStartScreen[0] =  new Button(this, width-150, height-200, 144, 30, "2 Players") {
    public void pressed() {
      //what to do when button is pressed
      players = new HumanPlayer[2];
      addPlayers() ;
      instantiateBoxes();
      defineButtons(); 
      state=options;
    }
  }.setVisible(true);

  buttonsStartScreen[1] = new Button(this, width-150, height-160, 144, 30, "3 Players") {
    public void pressed() {
      //what to do when button is pressed
      players = new HumanPlayer[3];
      addPlayers();
      instantiateBoxes();
      defineButtons(); 
      state=options;
    }
  }.setVisible(true);

  buttonsStartScreen[2] =  new Button(this, width-150, height-120, 144, 30, "4 Players") {
    public void pressed() {
      //what to do when button is pressed
      players = new HumanPlayer[4];
      addPlayers() ;
      instantiateBoxes();
      defineButtons(); 
      state=options;
    }
  }.setVisible(true);
}

void showWelcomeScreen() {

  // display  --------------------------------------------------

  background(0);

  // display I 
  for (int i=0; i<text1.length(); i++) {
    letterWelcome[i].visible=true; 
    letterWelcome[i].draw();
  }

  // display II 
  for (int i=0; i<text2.length(); i++) {
    letterWelcome2[i].visible=true; 
    letterWelcome2[i].draw();
  }

  // display IV
  // further text
  fill(255);
  textAlign(LEFT);
  textSize(22); 
  text("Players make their moves alternating.\n"
    +"At the beginning click 'Draw Letters' to get 8 letters.\n"
    +"To make a move drag the letters from your 8 letter stack\n"
    +"to the big main field left. When you placed your word\n"
    +"click 'Finish move' and then 'Move OK'.\n\n"
    +"You receive new letters until you have 7 letters again.\n"
    +"Now it's your friend's turn to make a move.\n\n", 280+40, 422);

  // display IV
  textAlign(CENTER); 
  text("Click here to start", 
    buttonsStartScreen[0].x, buttonsStartScreen[0].y-70, 
    130, 200);
  textAlign(LEFT);
  //
} //func 

void addPlayers() {

  //define players

  String[] names = {"Peter", "Mary", "Anna", "Paul"};

  for (int i = 0; i < players.length; i++) {
    players[i] = new HumanPlayer(this, i);
    players[i].name=names[i]; 
    players[i].drawLetters();
  }
}
//