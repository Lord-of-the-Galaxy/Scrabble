
// CheckBox for mouse 

public abstract class CheckBox {

  float x, y, 
    w, h;
  boolean value=false;

  public CheckBox( float x_, float y_, 
    float w_, float h_, 
    boolean value_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    value=value_; 

    //p.registerMethod("draw", this);
    //p.registerMethod("mouseEvent", this);
  }

  public void draw() {
    pushStyle();
    fill(255);
    rect(x, y, w, h);
    fill(0);
    textSize(h * 0.8);
    if (value) {
      text (char(10007), x, y);
    } else {
      text (char(10003), x, y);
    }      
    popStyle();
  }

  //public CheckBox setVisible(boolean b) {
  //  visible = b;
  //  return this;
  //}

  void mousePressed() {
    if ( mouseX > x && mouseX < (x + w) &&
      mouseY > y && mouseY < (y + h)) {
      pressed();
    }
  }

  public void mouseEvent(MouseEvent evt) {
    if (evt.getAction() == MouseEvent.PRESS)this.mousePressed();
  }

  void setActive22222222222222(boolean a) {
    // active = a;
    // return this;
  }

  public boolean hover() {
    return mouseX > x && mouseX < (x + w) &&
      mouseY > y && mouseY < (y + h);
  }

  abstract void pressed() ;
}
//