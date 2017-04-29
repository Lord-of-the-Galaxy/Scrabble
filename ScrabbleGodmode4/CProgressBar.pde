class ProgressBar{
  //PApplet parent;
  PVector pos;
  float width;
  float height;
  float L;
  int fill;
  color border;
  color background;
  float max;
  float min;
  
  ProgressBar(PVector pos_, float width_){
    //parent = parent_;
    pos = pos_;
    this.width = width_;
    this.height = 30;
    L = 0;
    min = 0;
    max = 100;
    fill = color(0, 250, 0);
    border = color(0);
    background = color(1, 1, 1, 0);
  }
  
  void setColors(color back, color bord, color fil){
    background = back;
    border = bord;
    fill = fil;
  }
  
  void update(float L_){
    L = L_;
  }
  
  void setMinMax(float min_, float max_){
    this.min = min_;
    this.max = max_;
  }
  
  void draw(){
    pushStyle();
    noStroke();
    fill(this.background);
    rect(pos.x, pos.y, this.width, this.height, 5);
    fill(fill);
    float draw_Width = PApplet.map(this.L, this.min, this.max, 0, this.width);
    rect(pos.x, pos.y, draw_Width, this.height, 5);
    stroke(border);
    noFill();
    rect(pos.x, pos.y, this.width, this.height, 5);
    popStyle();
  }
}