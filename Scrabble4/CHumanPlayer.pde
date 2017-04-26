
// tab HumanPlayer 

class HumanPlayer extends Player {
  
  Button ok, finish, revert;

  boolean reverting = false;

  HumanPlayer(PApplet p_, int i) {
    super(p_, i);
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

  void displayActive() {
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
    reverting = false;
  }

  void drawLetters() {
    super.drawLetters();
    if (activePlayer == index) {
      for (int i = 0; i < 7; i++) {
        set[i].active(true);
      }
    }
  }

  void ok() {
    if(!reverting){
      finish.setVisible(true);
      finish.setActive(false);
      revert.setVisible(true);
      ok.setVisible(false);
  
      for (int i = 0; i < 7; i++) {
        set[i].active(false);
      }
      int err = checkMove();
      if (err != 0) {
        err(err, nonExistantWord);
        this.err = err;
      } else finish.setActive(true);
    }
  }

  void revert() {
    finish.setVisible(false);
    revert.setVisible(false);
    ok.setVisible(true);

    for (int i = 0; i < 7; i++) {
      set[i].active(true);
    }
    reverting = true;
  }

  void activate() {
    ok.setVisible(true);
    for (int i = 0; i < 7; i++) {
      set[i].active(true);
    }
  }

  @Override
    void deactivate() {
    ok.setVisible(false);
    finish.setVisible(false);
    revert.setVisible(false);
    super.deactivate();
  }
}
//