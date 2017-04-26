
// tab for class Letter 

class Letter {

  char val=' ';
  int score=0;

  int x, y;

  boolean visible = false;
  boolean active = false;
  boolean dragging = false;
  boolean activeForAI = false;

  final boolean blank;

  Player p;//despite my best tries, had to add this :(
  int set_i;

  Letter(char v) {
    val = v;
    score = values.get(val);

    if (v == ' ')blank = true;
    else blank = false;
  }

  Letter(char v, int x_, int y_) {
    val = v;
    if (values.get(val)!=null) 
      score = values.get(val);
    x = x_;
    y = y_;

    if (v == ' ')blank = true;
    else blank = false;
  }

  Letter active(boolean a) {
    active = a;
    return this;
  }

  void draw() {
    if (visible) {
      if (dragging) {
        x = mouseX;
        y = mouseY;
      }

      pushStyle();
      fill(PEACH);
      if(active){
        stroke(DARK_BLUE);
        strokeWeight(2);
      }else if(activeForAI){
        stroke(RED);
        strokeWeight(2);
      }else noStroke();
      rectMode(CENTER);
      if (active)
        rect(x, y, S, S, 4);
      else rect(x, y, S, S, 2);

      if (score!=10) {
        fill(blank?127:0);
        textSize(0.8*S);
        text(val, x - textWidth(val)/2 - 2, y + 0.27*S);
        fill(0);
        textSize(0.3*S);
        text(score, x + S/3 - textWidth(str(score))/2, y + S/2.5);//I had problems with score=10
      } else {
        fill(0);
        textSize(0.75*S);
        text(val, x - textWidth(val)/2 - 4, y + 0.25*S);
        textSize(0.25*S);
        text('1', x + S/4.8, y + S/2.5);
        text('0', x + S/3, y + S/2.5);
      }
      popStyle();
    }
  }

  void doubleClicked() {
    if (blank && visible && active &&
      mouseX > (x - S/2) && mouseX < (x + S/2) && 
      mouseY > (y - S/2) && mouseY < (y + S/2)) {
      String s = null;
      int count = 0;
      char c = ' ';
      while ((s == null || c == ' ') && count < 3) {
        if(count != 0)JOptionPane.showMessageDialog(null, "Please enter a valid character");
        count++;
        s = JOptionPane.showInputDialog("Enter the value you want to use for the blank:");
        if(s == null)continue;
        s = s.toUpperCase();
        if ((int)s.charAt(0) >= 65 && (int)s.charAt(0) <= 90)c = s.charAt(0);
      }
      if (c == ' ')JOptionPane.showMessageDialog(null, "Failed to set a character to blank", "Try again!", JOptionPane.ERROR_MESSAGE);
      else val = c;
    }
  }

  void mousePressed() {
    if (visible && active &&
      mouseX > (x - S/2) && mouseX < (x + S/2) && 
      mouseY > (y - S/2) && mouseY < (y + S/2)) {

      dragging = true;
      Cell c = closestCell(this);
      if (c != null) {
        if (!c.empty && c.cur == this)c.remove();
      }
    }
  }

  void mouseReleased() {
    if (visible && active && dragging) {
      dragging = false;
      Cell c = closestCell(this);
      if (c != null) {
        x = int(c.i*S + XOFF + S/2);
        y = int(c.j*S + YOFF + S/2);
        if (c.empty)c.put(this);
        else {
          x = (int)P_XOFF + 60 + set_i*(int)(S+2);//stupid, I know
          y = (int)(P_YOFF + p.index*P_H + (activePlayer<p.index?P_H_A-P_H:0) + P_H/2);
        }
      } else {
        x = (int)P_XOFF + 60 + set_i*(int)(S+2);//stupid, I know
        y = (int)(P_YOFF + p.index*P_H + (activePlayer<p.index?P_H_A-P_H:0) + P_H/2);
      }
    }
    //more logic to come
  }

  Letter show(int x_, int y_) {
    visible = true;
    x = x_;
    y = y_;
    return this;
  }

  Letter player(Player p_, int i) {
    p = p_;
    set_i = i;
    return this;
  }

  void setVal(char c) {
    if (blank)val = c;
    else err(311, this);
  }

  @Override
    String toString() {
    return "Letter: " + val + ", Score: " + score;
  }
  
  void activeForAI(boolean a){
    activeForAI = a;
  }
}



Cell closestCell(Letter l) {
  
  int i = (int)((l.x - XOFF)/S);
  int j = (int)((l.y - YOFF)/S);
  
  if (i >= 0 && i < 15 && j >= 0 && j < 15)
    return grid[i][j];
  return null;
}
//