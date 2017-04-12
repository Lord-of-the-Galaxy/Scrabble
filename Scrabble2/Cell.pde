class Cell {
  int i, j;
  boolean empty = true;//does it have a letter?
  boolean used = false;//does it permanently have a letter?
  int type;
  //0 = default,
  //1 = star
  //2 = double word
  //3 = triple word
  //4 = double letter
  //5 = triple letter

  Cell(int i_, int j_) {
    this(i_, j_, 0);
  }

  Cell(int i_, int j_, int type_) {
    i = i_;
    j = j_;
    type = type_;
  }

  void draw() {
    pushStyle();
    switch(type) {
    case 5:
      fill(DARK_BLUE);
      break;
    case 4:
      fill(LIGHT_BLUE);
      break;
    case 3:
      fill(RED);
      break;
    case 2:
      fill(ORANGE);
      break;
    case 1:
      fill(ORANGE);
      break;
    default:
      fill(DEFAULT);
    }
    stroke(0);
    rect(i*S + XOFF, j*S + YOFF, S, S);
    if (type == 1)star(i*S + XOFF + S/2, j*S + YOFF + S/2);
    popStyle();
  }
}

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