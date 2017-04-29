
// class Cell and some consts and vars

final int gridDefault       = 0; 
final int gridStar          = 1; 
final int gridDoubleWord    = 2;
final int gridTripleWord    = 3; 
final int gridDoubleLetter  = 4;
final int gridTripleLetter  = 5;

final color[] colorType = {
  DEFAULT, 
  ORANGE, 
  ORANGE, 
  RED, 
  LIGHT_BLUE, 
  DARK_BLUE
};

final String[] listType = { 
  "", 
  "Star (Double Word)", 
  "Double Word", 
  "Triple Word", 
  "Double Letter", 
  "Triple Letter"
}; 

final String[] listTypeShort = { 
  "", 
  "", 
  "2 W", 
  "3 W", 
  "2 L", 
  "3 L"
}; 

class Cell {

  int i, j;

  boolean empty = true;//does it have a letter?
  boolean used = false;//does it permanently have a letter?

  int type = gridDefault;

  Letter cur = null;

  Cell(int i_, int j_) {    
    i = i_;
    j = j_;
  }

  void setType(int typeTemp_) {
    type=typeTemp_;
  }

  void draw() {
    pushStyle();
    // set color based on type
    fill(colorType[type]);    
    stroke(0);
    rect(i*S + XOFF, j*S + YOFF, S, S);
    if (type == gridStar)
      star(i*S + XOFF + S/2, j*S + YOFF + S/2);
    displayType(); 
    popStyle();
  }

  void displayType() {
    fill(0);
    
    //had to remove --- I don't mind ---- Pushed it inside :) ----- And removed it again
    if (mouseX>i*S + XOFF&&mouseX<i*S + XOFF+S &&
      mouseY>j*S + XOFF&&mouseY<j*S + XOFF+S) {
      fill(255);
      textSize(24);
      text(listType[type], 
        50, height-30);
      //fill(0);
      //textAlign(CENTER, CENTER);
      //textSize(12);
      //text(listTypeShort[type], i*S + XOFF + S/2, j*S + YOFF + S/2);
      //textAlign(LEFT, TOP);
      //textSize(12);
    }    //if
  }//func

  void star(float x, float y) {

    float f=3.9; 

    pushMatrix();
    translate(x, y);
    rotate(-.29);
    starHelper(0, 0, 
      30/f, 70/f, 
      5); 
    popMatrix();
  }

  void starHelper(float x, float y, 
    float radius1, float radius2, 
    int npoints) {

    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;

    fill(DARK_ORANGE);
    noStroke(); 
    beginShape();

    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }

  void put(Letter l) {
    if (empty) {
      cur = l;
      empty = false;
    } else err(231, this);
  }

  void save() {
    if (!empty) {
      used = true;
      cur.active(false).p = null;
    } else err(232, this);
  }

  void remove() {
    if (!empty && !used) {
      cur = null;
      empty = true;
    } else err(232, this);
  }

  @Override
    public String toString() {
    String r =  "Cell " + i + " " + j;
    if (!empty)r += ", containing " + cur.toString();
    return r;
  }
} //class
//