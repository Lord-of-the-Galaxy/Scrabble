class Letter {
  char val;
  int score;
  int x, y;
  boolean visible = false;
  boolean active = false;
  boolean dragging = false;
  
  Letter(char v){
    val = v;
    score = values.get(val);
  }

  Letter(char v, int x_, int y_) {
    val = v;
    score = values.get(val);
    x = x_;
    y = y_;
  }
  
  void active(boolean a){
    active = a;
  }
  
  void draw() {
    if(visible){
      if(dragging){
        x = mouseX;
        y = mouseY;
      }
      
      pushStyle();
      fill(PEACH);
      stroke(GREEN);
      if (active) strokeWeight(2);
      else noStroke();
      rectMode(CENTER);
      if (active)rect(x, y, S, S, 4);
      else rect(x, y, S, S, 2);
  
      if (score!=10) {
        fill(0);
        textSize(0.8*S);
        text(val, x - textWidth(val)/2 - 2, y + 0.27*S);
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
  
  void mousePressed(){
    if(visible && active && mouseX > (x - S/2) && mouseX < (x + S/2) && mouseY > (y - S/2) && mouseY < (y + S/2)){
      dragging = true;
    }
  }
  
  void mouseReleased(){
    if(visible)dragging = false;
    //more logic to come
  }
  
  void show(int x_, int y_){
    visible = true;
    x = x_;
    y = y_;
  }
}