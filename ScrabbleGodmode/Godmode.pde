boolean boardLoaded = false;


void loadProgram() {
  File start1 = new File(sketchPath("data\\situations\\"));
  start1 = selectFilteredInput("Select a file to write to:", start1, new ExtensionFilter("Scrabble Situation", "*.sbs"));

  boolean success = parseProgram(loadStrings(start1.getAbsolutePath()));
}

boolean parseProgram(String[] list) {

  try {
    boolean loadBoard = false;
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list[i].length(); j++) {
        if (list[j].charAt(i) == '#') break;
        if(!boardLoaded){  
          if(list[j].charAt(i) == '*'){
            loadBoard = true;
            break;
          }
          println(list[j].charAt(i) );
          //grid[i][j].empty = false;
          //grid[i][j].used = true;
          println (i+", "+j);
          int x = int(i*S + XOFF + S/2);
          int y = int(j*S + YOFF + S/2);
          letters.add(new Letter( list[j].charAt(i) ).show(x, y));
          grid[i][j].put(letters.get(letters.size()-1));
          grid[i][j].save();
        }
      }
    }
  }
  catch(Exception e) {
    e.printStackTrace();
    return false;
  }


  return true;
}