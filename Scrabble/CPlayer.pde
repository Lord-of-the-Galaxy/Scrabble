
// tab Player 

abstract class Player {

  Letter[] set;

  boolean checked = false;

  int index;

  int score;

  String name=""; 

  String nonExistantWord = "";

  ArrayList<Word> words = new ArrayList<Word>();

  int err = 0;

  PApplet p;

  boolean isPlayedByComputer=false; 

  Player(PApplet p_, int i) {
    index = i;
    set = new Letter[7];

    p=p_; 

    score = 0;
  }

  void draw() {

    // draw player 

    pushStyle();
    if (activePlayer != index) {
      fill(LIGHT_GREEN);
      stroke(DARK_GREEN);
      strokeWeight(3);
      float y = index*P_H + P_YOFF;
      if (activePlayer < index)
        y += P_H_A-P_H;
      rect(P_XOFF, y, P_W, P_H, 6);
      fill(0); 
      textSize(0.5*P_H);
      text(name + (isPlayedByComputer ? " (AI)" : ""), P_XOFF+4, y+P_H-10);
    } else {
      displayActive();
      if (checked) {
        showScoreTable(words);
      }
    }
    float y = index*P_H + P_YOFF;
    if (activePlayer < index)
      y += P_H_A-P_H;
    textSize(0.5*P_H);
    fill(0);
    text(score, P_XOFF + P_W - 25 - textWidth(str(score))/2, y+P_H + (activePlayer==index?P_H_A-P_H:0) -10);
    popStyle();
  }


  abstract void displayActive();//Human and AI have different

  void drawLetters() {

    int x = (int)P_XOFF + 40;
    int y = (int)(P_YOFF + this.index*P_H  + S*0.9);

    for (int i = 0; i < 7; i++) {
      int r = (int)random(pile.size());
      set[i] = pile.get(r);
      pile.remove(r);
      set[i].show(x + (int)(S+2)*i, y);
      set[i].player(this, i);
      set[i].hide();
    }
  }

  @SuppressWarnings("null")
    int checkMove() {
    checked = false;
    words.clear();
    ArrayList<Cell> cells_temp = new ArrayList<Cell>();
    for (int i = 0; i < 7; i++) {
      if (closestCell(set[i]) != null) {
        cells_temp.add(closestCell(set[i]));
      }
    }
    Cell[] cells = new Cell[cells_temp.size()];
    cells_temp.toArray(cells);
    for (Cell c : cells) {
      if (c.cur.blank && c.cur.val == ' ')return 661;
    }
    Cell temp = null;
    boolean v = true;
    for (int i = 0; i < cells.length; i++) {
      if (i == 0) {
        temp = cells[i];
      } else if (i == 1) {
        if (cells[i].i == temp.i) {
          v = true;
        } else if (cells[i].j == temp.j) {
          v = false;
        } else return 681;
      } else {
        if (v) {
          if (cells[i].i != temp.i) return 681;
        } else {
          if (cells[i].j != temp.j) return 681;
        }
      }
    } 
    if (firstMove) {
      boolean c = false;
      for (int i = 0; i < cells.length; i++) {
        if (cells[i].i == 7 && cells[i].j == 7) {
          c = true;
          break;
        }
      }
      if (!c)return 682;
      Word w = null;
      if (cells.length == 1)return 683;
      try {
        if (!v) {
          w = extendAndCheckHorizontal(cells[0], cells);
        } else {
          w = extendAndCheckVertical(cells[0], cells);
        }
        words.add(w);
      }
      catch(NoWordException nwe) {
        return 671;
      }
      catch(DiscontinuousWordException dwe) {
        return 685;
      }

      for (Word word : words) {
        if (!wordExists(word.val)) {
          nonExistantWord = word.val;
          return 651;
        }
      }
      checked = true;
      return 0;
    }
    if (cells.length > 1) {
      Word w = null;
      try {
        if (!v) {
          w = extendAndCheckHorizontal(cells[0], cells);
        } else {
          w = extendAndCheckVertical(cells[0], cells);
        }
        words.add(w);
      }
      catch(NoWordException nwe) {
        return 683;
      }
      catch(DiscontinuousWordException dwe) {
        return 685;
      }
      boolean ok = false;
      for (int n = 0; n < cells.length; n++) {
        Cell s = cells[n];
        if (!ok) {
          int i = s.i;
          int j = s.j;

          boolean u = false, d = false, l = false, r = false;
          if (i < 14) {
            r = grid[i+1][j].used;
          }
          if (i > 0) {
            l = grid[i-1][j].used;
          }
          if (j < 14) {
            d = grid[i][j+1].used;
          }
          if (j > 0) {
            u = grid[i][j-1].used;
          }
          if (u || d || l || r)ok = true;
        }
        Word next = null;
        try {
          if (v) {
            next = extendHorizontal(s);
          } else {
            next = extendVertical(s);
          }
        }
        catch(NoWordException nwe) {
          continue;
        }
        words.add(next);
      }
      if (!ok)return 684;
    } else if (cells.length == 1) {
      Word vert;
      Word hor;
      try {  
        vert = extendVertical(cells[0]);
      }
      catch(NoWordException nwe) {
        vert = null;
      }
      try {  
        hor = extendHorizontal(cells[0]);
      }
      catch(NoWordException nwe) {
        hor = null;
      }

      if (hor == null && vert == null)return 683;
      else if (hor == null) words.add(vert);
      else if (vert == null)words.add(hor);
      else {
        words.add(vert);
        words.add(hor);
      }
    }

    //CHECK IF WORDS EXIST
    for (Word w : words) {
      if (!wordExists(w.val)) {
        nonExistantWord = w.val;
        return 651;
      }
    }
    checked = true;
    return 0;
  }

  void finish() {
    IntList replace = new IntList();
    for (int i = 0; i < 7; i++) {
      if (closestCell(set[i]) != null) replace.append(i);
    }
    int x = (int)P_XOFF + 40;
    int y = (int)(P_YOFF + this.index*P_H  + S*0.9);
    for (int i = 0; i < replace.size(); i++) {
      int index = replace.get(i);
      closestCell(set[index]).save();
      int r = (int)random(pile.size());
      set[index] = pile.get(r);
      pile.remove(r);
      set[index].show(x + (int)(S+2)*index, y);
      set[index].player(this, index);
      set[index].hide();
    }
    for (int i = 0; i < words.size(); i++) {
      score+=words.get(i).score;
    }
    if (firstMove) {
      if (firstMovePass)firstMovePass = false;
      else firstMove = false;
    }
    checked = false;
    deactivate();
  }

  abstract void activate();//Human and AI have different

  void deactivate() {
    activePlayer = (index+1)%players.length;
    players[activePlayer].activate();
    for (int i = 0; i < 7; i++) {
      set[i].hide();
    }
  }

  Word extendHorizontal(Cell s) throws NoWordException {
    int i = s.i;
    boolean l = true, r = true;
    if (i > 0) {
      l = grid[i-1][s.j].empty;
    }
    if (i < 14) {
      r = grid[i+1][s.j].empty;
    }
    if (l && r)throw new NoWordException();

    while (i > 0) {
      Cell c = grid[i-1][s.j];
      if (c.empty)break;
      i--;
    }
    Cell word_start = grid[i][s.j];
    Word w = new Word(word_start, false);
    while (i < 15) {
      Cell c = grid[i++][s.j];
      if (c.empty)break;
      int m_temp = 1;
      if (!c.used) {
        if (c.type == gridDoubleLetter) {
          m_temp = 2;
        } else if (c.type == gridTripleLetter) {
          m_temp = 3;
        }

        if (c.type == gridDoubleWord || c.type == gridStar) {
          w.mult(2);
        } else if (c.type == gridTripleWord) {
          w.mult(3);
        }
      }
      w.add(c.cur.val, c.cur.score, m_temp);
    }
    w.init();
    return w;
  }

  //Somewhere about here I forgot my original plan, and I had forgotten to write it down preoperly :(
  Word extendAndCheckHorizontal(Cell s, Cell[] all) throws NoWordException, DiscontinuousWordException {
    int i = s.i;
    boolean l = true, r = true;
    if (i > 0) {
      l = grid[i-1][s.j].empty;
    }
    if (i < 14) {
      r = grid[i+1][s.j].empty;
    }
    if (l && r)throw new NoWordException();

    while (i > 0) {
      Cell c = grid[i-1][s.j];
      if (c.empty)break;
      i--;
    }

    Cell word_start = grid[i][s.j];
    IntList checked = new IntList();
    Word w = new Word(word_start, false);
    while (i < 15) {
      Cell c = grid[i++][s.j];
      if (c.empty)break;
      checked.append(i-1);
      int m_temp = 1;
      if (!c.used) {
        if (c.type == gridDoubleLetter) {
          m_temp = 2;
        } else if (c.type == gridTripleLetter) {
          m_temp = 3;
        }

        if (c.type == gridDoubleWord || c.type == gridStar) {
          w.mult(2);
        } else if (c.type == gridTripleWord) {
          w.mult(3);
        }
      }
      w.add(c.cur.val, c.cur.score, m_temp);
    }
    w.init();
    for (int n = 0; n < all.length; n++) {
      if (!checked.hasValue(all[n].i))throw new DiscontinuousWordException();
    }
    return w;
  }

  Word extendVertical(Cell s) throws NoWordException {
    int j = s.j;
    boolean u = true, d = true;
    if (j > 0) {
      u = grid[s.i][j - 1].empty;
    }
    if (j < 14) {
      d = grid[s.i][j + 1].empty;
    }
    if (u && d)throw new NoWordException();
    while (j > 0) {
      Cell c = grid[s.i][j-1];
      if (c.empty)break;
      j--;
    }

    Cell word_start = grid[s.i][j];
    Word w = new Word(word_start, true);
    while (j < 15) {
      Cell c = grid[s.i][j++];
      if (c.empty)break;
      int m_temp = 1;
      if (!c.used) {
        if (c.type == gridDoubleLetter) {
          m_temp = 2;
        } else if (c.type == gridTripleLetter) {
          m_temp = 3;
        }

        if (c.type == gridDoubleWord || c.type == gridStar) {
          w.mult(2);
        } else if (c.type == gridTripleWord) {
          w.mult(3);
        }
      }
      w.add(c.cur.val, c.cur.score, m_temp);
    }
    w.init();
    return w;
  }

  //Somewhere about here I forgot my original plan, and I had forgotten to write it down preoperly :(
  Word extendAndCheckVertical(Cell s, Cell[] all) throws NoWordException, DiscontinuousWordException {
    int j = s.j;
    boolean u = true, d = true;
    if (j > 0) {
      u = grid[s.i][j - 1].empty;
    }
    if (j < 14) {
      d = grid[s.i][j + 1].empty;
    }
    if (u && d)throw new NoWordException();

    while (j > 0) {
      Cell c = grid[s.i][j-1];
      if (c.empty)break;
      j--;
    }
    Cell word_start = grid[s.i][j];
    IntList checked = new IntList();
    Word w = new Word(word_start, true);
    while (j < 15) {
      Cell c = grid[s.i][j++];
      if (c.empty)break;
      checked.append(j-1);
      int m_temp = 1;
      if (!c.used) {
        if (c.type == gridDoubleLetter) {
          m_temp = 2;
        } else if (c.type == gridTripleLetter) {
          m_temp = 3;
        }

        if (c.type == gridDoubleWord || c.type == gridStar) {
          w.mult(2);
        } else if (c.type == gridTripleWord) {
          w.mult(3);
        }
      }
      w.add(c.cur.val, c.cur.score, m_temp);
    }
    w.init();
    for (int n = 0; n < all.length; n++) {
      if (!checked.hasValue(all[n].j))throw new DiscontinuousWordException();
    }
    return w;
  }
}