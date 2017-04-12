final static float S = 40;//size of tile/space
final static float XOFF = 15, YOFF = 15;

//change these colors at your discretion
public static final color PEACH = #F7CE91;
public static final color GREEN = #00FF00;
public static final color DEFAULT = #23FF86;
public static final color DARK_BLUE = #0000FF;
public static final color LIGHT_BLUE = #46E8DE;
public static final color ORANGE = #FFC081;
public static final color DARK_ORANGE = #EFA071;
public static final color RED = #FF0000;

HashMap<Character, Integer> values = new HashMap<Character, Integer>();

ArrayList<Letter> letters = new ArrayList<Letter>();

Cell[][] grid = new Cell[15][15];//harcoded becuse we're using official scrabble pattern of double/triple words/letters

void setup(){
  size(1280, 720);
  initLetters();
  initGrid();
  smooth();
}

void draw(){
  background(0);
   for(int i = 0; i < letters.size(); letters.get(i++).draw());
   for(int i = 0; i < 15; i++){
    for(int j = 0; j < 15; j++){
      grid[i][j].draw();
    }
  }
}

void mousePressed(){
  for(int i = 0; i < letters.size(); letters.get(i++).mousePressed());
}

void mouseReleased(){
  for(int i = 0; i < letters.size(); letters.get(i++).mouseReleased());
}