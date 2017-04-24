
// CheckBox for mouse 

public class CheckBox {

  float x, y, 
    w, h;
  boolean value=false;
  String textCB; 

  public CheckBox( PApplet p, float x_, float y_, 
    float w_, float h_, 
    boolean value_, 
    String textCB_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    value=value_;

    textCB=textCB_; 

    // p.registerMethod("draw", this);
    p.registerMethod("mouseEvent", this);
  }

  public void draw() {
    pushStyle();

    // rect: frame white and fill black
    // fill(0);
    noFill(); 
    stroke(255); 
    rect(x, y, w, h);

    // text 
    fill(255);
    textSize(15);//12 is way too small
    text(textCB, x-140, y+h/2+3);

    // text 
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(h*.8);
    if (value) {
      fill(GREEN);  
      text (char(10003), x+w/2, y+h/2-3);
    } else {
      fill(RED); 
      text (char(10007), x+w/2, y+h/2-3);
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
    if (evt.getAction() == MouseEvent.PRESS)
      this.mousePressed();
  }

  //void setActive(boolean a) {
    // active = a;
    // return this;
  //}

  public boolean hover() {
    return mouseX > x && mouseX < (x + w) &&
      mouseY > y && mouseY < (y + h);
  }

  public void pressed(){
    value = !value;
  }
}
//