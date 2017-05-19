boolean boardLoaded = false;
boolean playersLoaded = false;
int playersN = 2;

void loadProgram() {
  File start1 = new File(sketchPath("data\\situations"));

  start1 = selectFilteredInput("Select a Scrabble Board Situation:", start1, new ExtensionFilter("Scrabble Board Situation", "*.sbs"));//Load dialog

  boolean success = parseProgram(loadStrings(start1.getAbsolutePath()));
  if (!success) {
    System.err.println("Error in the loaded situation!");
    System.exit(461);
  }
}

//TODO - Write more efficient and neat code
boolean parseProgram(String[] list) {
  try {
    boolean comment = false;
    boolean loadBoard = false;
    boolean playersNLoaded = false;
    int boardCount = 0;
    boolean[] playerLoaded = new boolean[playersN];

    for (int i = 0; i < list.length; i++) {

      boolean commentA = false;
      boolean findNo = false;
      boolean findLetters = false;
      int playerN = -1;
      if (loadBoard) {
        for (int j = 0; j < 15; j++) {
          char c = list[i].charAt(j);
          if (c != '-') {
            c = str(c).toUpperCase().charAt(0);
            Letter l = findAndRemove(c);
            if (l == null) {
              System.err.println("Letters insufficient");
              return false;
            } else {
              Cell cell = grid[j][boardCount];//IDK why
              int x = int(cell.i*S + XOFF + S/2);
              int y = int(cell.j*S + YOFF + S/2);
              l.show(x, y);
              cell.put(l);
              cell.save();
            }
          }
        }
        boardCount++;
        if (boardCount == 15) {
          loadBoard = false;
          boardLoaded = true;
        }
      } else {
        for (int j = 0; j < list[i].length(); j++) {
          if (j != list[i].length()-1 && list[i].charAt(j)=='/' && list[i].charAt(j+1)=='/') break;
          if (!comment) {
            if (commentA) {
              if (list[i].charAt(j) == '*') {
                comment = true;
              }
              commentA = false;
            } else {
              if (list[i].charAt(j) == '/')commentA = true;
            }
          } else {
            if (commentA) {
              if (list[i].charAt(j) == '/') {
                comment = false;
              }
              commentA = false;
            } else {
              if (list[i].charAt(j) == '*')commentA = true;
            }
          }

          if (!boardLoaded) { 
            if (j != list[i].length()-1 && list[i].charAt(j)=='B' && list[i].charAt(j+1)=='*') {
              if (list.length > i+16 && list[i+16].length() > 1 && list[i+16].charAt(0) == '*' && list[i+16].charAt(1) == 'B') {
                loadBoard = true;
              }
            }
          }


          if (!playersNLoaded) {
            if (findNo) {
              if ((int)list[i].charAt(j) >= 50 && (int)list[i].charAt(j) < 53) {
                playersN = (int)list[i].charAt(j) - 48;
                findNo = false;
                playersNLoaded = true;
                playerLoaded = new boolean[playersN];
                for (int n = 0; n < playersN; n++) {
                  playerLoaded[n] = false;
                }
              } else {
                if (j == list[i].length()-1) {
                  return false;
                }
              }
            }

            if (j != list[i].length()-1 && list[i].charAt(j)=='*' && list[i].charAt(j+1)=='P') {
              findNo = true;
              j+=2;
            }
          } else {
            if (findLetters) {
              char c = list[i].toUpperCase().charAt(j);
              if(c == ' ')break;
              Letter l = findAndRemove(c);
              if (l == null) {
                if (c == '_') {
                  l = findAndRemove(' ');
                  if (l != null) {
                    giveLetter(playerN, l);
                    playersLoaded = true;
                  } else {
                    System.err.println("Letters insufficient");
                    return false;
                  }
                } else {
                  System.err.println("Letters insufficient");
                  return false;
                }
              } else {
                giveLetter(playerN, l);
                playersLoaded = true;
              }
            } else {
              if (j <= list[i].length()-2 && list[i].charAt(j)=='*' && list[i].charAt(j+1)=='P' && (int)list[i].charAt(j+2) >= 49 && (int)list[i].charAt(j+2) < 53) {
                playerN = (int)list[i].charAt(j+2) - 49;
                findLetters = true;
                playerLoaded[playerN] = true;
                j+=3;
              }
            }
          }
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

Letter findAndRemove(char c) {
  for (int i = 0; i < pile.size(); i++) {
    Letter l = pile.get(i);
    if (l.val == c) {
      pile.remove(i);
      return l;
    }
  }
  return null;
}

ArrayList<Letter> ls = new ArrayList<Letter>();
ArrayList<Integer> is = new ArrayList<Integer>();

void giveLetter(int n, Letter l) {
  ls.add(l);
  is.add(n);
}

void giveAllLetters() {
  println();
  for (int i = 0; i < ls.size(); i++) {
    players[is.get(i)].giveLetter(ls.get(i));
  }
}