
// tab HumanPlayer 

class HumanPlayer extends Player {

  Button show, ok, finish, revert;

  boolean reverting = false;

  HumanPlayer(PApplet p_, int i) {
    super(p_, i);
    finish = new Button(p, P_XOFF + 20, P_YOFF + index*P_H + 70, 110, 30, "Move OK") {
      @Override
        void pressed() {
        finish();
      }
    };
    revert = new Button(p, P_XOFF + 145, P_YOFF + index*P_H + 70, 165, 30, "Change move") {
      @Override
        void pressed() {
        revert();
      }
    };
    
    ok = new Button(p, P_XOFF + 80, P_YOFF + index*P_H + 70, 180, 30, "Check move") {
      @Override
        void pressed() {
        ok();
      }
    };
    show = new Button(p, P_XOFF + 60, P_YOFF + index*P_H + 70, 220, 30, "Show Letters") {
      @Override
        void pressed() {
        showLetters();
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
    textSize(0.5*P_H);
    text(name, P_XOFF+4, y+P_H_A-10); 
    if (finish.visible && !finish.active && finish.hover()) {
      pushStyle();
      textAlign(CENTER, CENTER);      
      textSize(16);
      fill(RED);
      String txt = "Move is illegal!";
      if (err != 0) txt = getErrorMessage(err, nonExistantWord);
      text(txt, P_XOFF+P_W/2, y+P_H_A-0.5*P_H-4-(txt.contains("\n")?0:8));
      popStyle();
    }
    reverting = false;
  }

  void ok() {
    if (!reverting) {
      finish.setVisible(true);
      finish.setActive(false);
      revert.setVisible(true);
      ok.setVisible(false);

      for (int i = 0; i < 7; i++) {
        set[i].active(false);
      }
      int err = checkMove();
      if (words.size() == 0) finish.setText("Pass");
      else finish.setText("Move OK");
      if (err != 0) {
        err(err, nonExistantWord);
        this.err = err;
        if(words.size() == 0 && firstMove){
          finish.setActive(true);
          firstMovePass = true;
        }
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

  void showLetters() {
    show.setVisible(false);
    ok.setVisible(true);
    for (int i = 0; i < 7; i++) {
      set[i].show();
      set[i].active(true);
    }
  }
  
  void activate(){
    show.setVisible(true);
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