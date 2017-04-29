

String[] list ;

void loadProgram() {

  File start1 = new File(sketchPath("data\\situations\\"));
  start1 = selectFilteredInput("Select a file to write to:", 
    start1, 
    new ExtensionFilter("Scrabble Situation", "*.sbs"));

  list = loadStrings(start1.getAbsolutePath());

  for (int i = 0; i < 15; i++) {
    for (int j = 0; j < 15; j++) {
      if (list[j].charAt(i) != '_') {
        println(list[j].charAt(i) );
        //grid[i][j].empty = false;
        //grid[i][j].used = true;
        //  println (j+", "+i);
        int x = int(i*S + XOFF + S/2);
        int y = int(j*S + YOFF + S/2);
        letters.add(new Letter( list[j].charAt(i) ).show(x, y));
        grid[i][j].put(letters.get(letters.size()-1));
        grid[i][j].save();
      }//if
    }
  }
}
//