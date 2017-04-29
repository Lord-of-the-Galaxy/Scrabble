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
    
    //Move a letter on the screen
    
    //NOW USE ALL THIS FRAMEWORK TO CREATE YOUR OWN AI FOR SCRABBLE!
  }
}