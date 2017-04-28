
// tab for state show Options

TextBox[] tboxes;
int idx; // index for current tbox

// same number of check boxes as text boxes 
CheckBox[] checkBoxesOptionsScreen;

// ONE button 
Button[] buttonsOptionsScreen = new Button[1];   

boolean godmode=false;
boolean firstTimeGodmode=true; 

void instantiateBoxes() {

  tboxes = new TextBox[players.length]; 
  checkBoxesOptionsScreen = new CheckBox[players.length];

  for (int i = 0; i < players.length; i++) {

    tboxes[i] = new TextBox(
      "Player "+str(i+1) + ", please enter your name: ", 
      330 + i * 66, i*129+264, // x, y
      300, 33, // w, h
      215, // lim
      TEXT_BOX_TEXT_COLOR, TEXT_BOX_BASE_COLOR, // textC, baseC
      TEXT_BOX_BORDER_COLOR, TEXT_BOX_FOCUSED_BORDER_COLOR, // bordC, slctC 
      players[i].name);

    checkBoxesOptionsScreen[i] = new CheckBox( this, 270 + i * 66, i*129+224, 33, 33, false, 
      "Computer Player?");
  }//for
}

void defineButtons() {  
  // define

  if (buttonsStartScreen[0] != null)buttonsStartScreen[0].setVisible(false);
  if (buttonsStartScreen[1] != null)buttonsStartScreen[1].setVisible(false);
  if (buttonsStartScreen[2] != null)buttonsStartScreen[2].setVisible(false);

  buttonsOptionsScreen[0] = new Button(this, width-150, height-240, 144, 30, "Done") {
    public void pressed() {
      //what to do when button is pressed
      for (int i = 0; i < players.length; i++) {
        players[i].name=tboxes[i].txt;
      }//for
      if ( godmode ) {
        loadProgram();
      } else 
      state=normalGame;

      this.setVisible(false);
      players[0].activate();
    }//method
  }
  .setVisible(true); // new
} // func 

void loadProgram() {
  //
  state=stateWaitForLoad;
  loadPath="";
  File start1 = 
    new File(sketchPath("")+"/Situations/*.txt"); 
  selectInput("Select a file to write to:", 
    "fileSelectedForLoad", 
    start1);
}

void fileSelectedForLoad(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    state=normalGame;
  } else {
    loadPath=selection.getAbsolutePath(); 
    println("User selected " + selection.getAbsolutePath());
  }
}

void showOptions() {

  background(0);

  fill(RED);
  text ( "Options ", width/2, 29 );

  for (int i = 0; i < players.length; i++) {

    checkBoxesOptionsScreen[i].draw();

    if (checkBoxesOptionsScreen[i].value)
      tboxes[i].title=  "Please enter this AI's name: ";
    else 
    tboxes[i].title=  "Player "
      +trim(str(i+1)) 
      + ", please enter your name: ";

    //TODO - ADD PROPER AI FRAMEWORK
    players[i].isPlayedByComputer = 
      checkBoxesOptionsScreen[i].value;

    tboxes[i].display();
  } //for

  if (tboxes[0].txt.equals("Godmode")) {
    //
    godmode=true;
  } else godmode=false;

  // display 
  textAlign(CENTER); 
  text("Click here to start", 
    buttonsOptionsScreen[0].x, buttonsOptionsScreen[0].y-70, 
    130, 200);
  textAlign(LEFT);
}
//