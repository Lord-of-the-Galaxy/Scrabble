
// 

public abstract class Button {

  float x, y, w, h;
  String text;
  boolean visible = false, active = true;  //i have my reasons

  public Button(PApplet p, float x_, float y_, 
    float w_, float h_, 
    String t) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = t;
    p.registerMethod("draw", this);
    p.registerMethod("mouseEvent", this);
  }

  public void draw() {
    if(visible){
      pushStyle();
      if(active){
        fill(LIGHT_BLUE);//whatever came to my mind :) Please change if you gat a better idea
        stroke(DARK_BLUE);
      }else{
        fill(ORANGE);//whatever came to my mind :) Please change if you gat a better idea
        stroke(RED);
      }
      rect(x, y, w, h, 4);
      fill(0);
      textSize(h * 0.8);
      text(text, x + w/2 - textWidth(text)/2, y + 0.9*h - 3);
      popStyle();
    }
  }

  public Button setVisible(boolean b) {
    visible = b;
    return this;
  }

  public void mousePressed() {
    if (visible &&  active && 
      mouseX > x && mouseX < (x + w) &&
      mouseY > y && mouseY < (y + h)) {
      pressed();
    }
  }
  
  public void mouseEvent(MouseEvent evt){
    if(evt.getAction() == MouseEvent.PRESS)this.mousePressed();
  }
  
  public Button setActive(boolean a){
    active = a;
    return this;
  }
  
  public boolean hover(){
    return mouseX > x && mouseX < (x + w) &&
      mouseY > y && mouseY < (y + h);
  }
  abstract void pressed() ;
}
//