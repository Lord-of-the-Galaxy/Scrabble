class SampleAIPlayer extends AIPlayer{
  
  SampleAIPlayer(PApplet p, int i){
    super(p, i);
  }
  
  //HERE COMES THE AI CODE
  void runAI(){
    
    //A lightweight storage grid, always access only this to prevent errors. DO NOT try accessing the main grid itself.
    AICell c = ai_grid[0][0];
    
    //The corresponding cell in the main grid is empty
    if(c.val == '.')println("Empty");
    //Has a letter
    else println("Has letter " + c.val);
    
    //Type of the cell, same values as in main grid
    println(listType[c.type]);
    
    //A lightweight storage for the letters, always access only this to prevent errors. DO NOT try accessing the set of letters itself.
    AILetter l = ai_set[0];
    
    //Letter of the piece
    println("Letter: " + l.val);
    //Score (value) of the piece
    println("Score: " + l.score);
    //Is it a blank?
    println(l.blank?"Blank":"Not blank");
    
    //Move a letter on the screen to a position on the grid
    moveLetter(l, 6, 8);//Places the previously created (loaded, more like) letter in the fourth column and fifth row (I think at least. Second parameter determines X position, third determines Y position, just in case I messed up my English).
    
    //Set a value for a blank
    if(l.blank)l.setVal(this, 'C');
    
    //Update the progress bar, takes a prcentage
    update(25);
    
    //NOW USE ALL THIS FRAMEWORK TO CREATE YOUR OWN AI FOR SCRABBLE!
    println();//buffer space
  }
}