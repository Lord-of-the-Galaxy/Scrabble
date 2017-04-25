
// tab Player 

class Player {

  Letter[] set;
  Button ok, finish, revert;

  boolean reverting = false;

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
    set = new Letter[8];

    p=p_; 

    score = 0;

    finish = new Button(p, P_XOFF + 40, index*P_H + 110, 120, 30, "Move OK") {
      @Override
        void pressed() {
        finish();
      }
    };
    revert = new Button(p, P_XOFF + 180, index*P_H + 110, 180, 30, "Change move") {
      @Override
        void pressed() {
        revert();
      }
    };
    ok = new Button(p, P_XOFF + 100, index*P_H + 110, 200, 30, "Check move") {
      @Override
        void pressed() {
        ok();
      }
    };
  }

  void draw() {

    // draw player 

    if (activePlayer != index) {
      pushStyle();
      fill(LIGHT_GREEN);
      stroke(DARK_GREEN);
      strokeWeight(3);
      float y = index*P_H + P_YOFF;
      if (activePlayer < index)
        y += P_H_A-P_H;
      rect(P_XOFF, y, P_W, P_H, 6);
      fill(0); 
      textSize(0.4*S);
      text(name + (isPlayedByComputer ? " (PC)" : ""), P_XOFF+4, y+P_H-5); 
      popStyle();
    } else {
      pushStyle();
      fill(LIGHT_GREEN);
      stroke(DARK_GREEN);
      strokeWeight(2);
      float y = index*P_H + P_YOFF;
      rect(P_XOFF, y, P_W, P_H_A, 6);
      fill(0); 
      textSize(0.4*S);
      text(name + (isPlayedByComputer ? " (PC)" : ""), P_XOFF+4, y+P_H_A-6);
      if (finish.visible && !finish.active && finish.hover()) {
        fill(RED);
        String txt = "Move is illegal!";
        if (err != 0) txt = getErrorMessage(err, nonExistantWord);
        text(txt, P_XOFF+P_W - textWidth(txt) - 5, y+P_H_A-10-(txt.contains("\n")?S/2:0));
      }
      if (finish.visible && finish.active) {
        showScoreTable(words);
      }
      popStyle();
    }
    reverting = false;
    float y = index*P_H + P_YOFF;
    if (activePlayer < index)
      y += P_H_A-P_H;
    textSize(0.6*S);
    text(score, P_XOFF + P_W - 25 - textWidth(str(score))/2, y + (activePlayer == index?P_H_A:P_H)/2 + 0.3*S);
  }

  void drawLetters() {

    int x = (int)P_XOFF + 40;
    int y = (int)(P_YOFF + this.index*P_H + (activePlayer<index?P_H_A-P_H:0) + P_H/2);

    for (int i = 0; i < 8; i++) {
      int r = (int)random(pile.size());
      set[i] = pile.get(r);
      pile.remove(r);
      set[i].show(x + (int)(S+2)*i, y);
      set[i].player(this, i);
      if (activePlayer == index)
        set[i].active(true);
    }
  }

  void ok() {
    int err = checkMove();
    if (err != 0) {
      err(err, nonExistantWord);
      this.err = err;
    }
  }

  @SuppressWarnings("all")
    int checkMove() {
    if (!reverting) {
      finish.setVisible(true);
      finish.setActive(false);
      revert.setVisible(true);
      ok.setVisible(false);

      for (int i = 0; i < 8; i++) {
        set[i].active(false);
      }
      words.clear();
      ArrayList<Cell> cells_temp = new ArrayList<Cell>();
      for (int i = 0; i < 8; i++) {
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
        println("Checking words against dictionary");
        for (Word word : words) {
          if (!wordExists(word.val)) {
            nonExistantWord = word.val;
            return 651;
          } else {
            println("Word " + word.val + " exists!");
          }
        }
        finish.setActive(true);
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

      finish.setActive(true);
      return 0;
    } else return 689;
  }

  void finish() {
    IntList replace = new IntList();
    for (int i = 0; i < 8; i++) {
      if (closestCell(set[i]) != null) replace.append(i);
    }
    int x = (int)P_XOFF + 40;//stupid, I know
    int y = (int)(P_YOFF + this.index*P_H + (activePlayer<index?P_H_A-P_H:0) + P_H/2);
    for (int i = 0; i < replace.size(); i++) {
      int index = replace.get(i);
      closestCell(set[index]).save();
      int r = (int)random(pile.size());
      set[index] = pile.get(r);
      pile.remove(r);
      set[index].show(x + (int)(S+2)*index, y);
      set[index].player(this, index);
    }
    for (int i = 0; i < words.size(); i++) {
      score+=words.get(i).score;
    }
    if (firstMove)firstMove = false;
    deactivate();
  }

  void revert() {
    finish.setVisible(false);
    revert.setVisible(false);
    ok.setVisible(true);

    for (int i = 0; i < 8; i++) {
      set[i].active(true);
    }
    reverting = true;
  }

  void activate() {
    ok.setVisible(true);
    for (int i = 0; i < 8; i++) {
      set[i].active(true);
    }
  }

  void deactivate() {
    ok.setVisible(false);
    finish.setVisible(false);
    revert.setVisible(false);
    activePlayer = (index+1)%players.length;
    players[activePlayer].activate();
    if (activePlayer == 0) {
      for (int i = 1; i < players.length; i++) {
        players[i].moveLetters();
      }
    } else {
      players[activePlayer].moveLetters();
    }
  }

  void moveLetters() {
    int x = (int)P_XOFF + 40;//stupid, I know
    int y = (int)(P_YOFF + this.index*P_H + (activePlayer<index?P_H_A-P_H:0) + P_H/2);
    for (int i = 0; i < 8; i++) {
      set[i].show(x + (int)(S+2)*i, y);
    }
  }

  Word extendHorizontal(Cell s) throws NoWordException {
    int i = s.i;
    boolean l = false, r = false;
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
    boolean l = false, r = false;
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
    boolean u = false, d = false;
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
    boolean u = false, d = false;
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
//