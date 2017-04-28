import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.Queue;
import javax.swing.JOptionPane;

// SCRABBLE - GODMODE
// Here, you test AI against yourself, and can test AIs against each other also
// You can also create any situation you want and load it into the game
// However, loaded situations don't take into account the fact that it uses up letters to make words, so all letters remain in pile
// This will change soon, and be with a choice.
// Open the Game tab to instantiate your AIs


final static boolean GODMODE = true;//set to true if you want to load a situation, example provided in "data/situations/" folder

// main tab

//size of tile/space
final static float S = 40;

// what is this ? 
final static float XOFF = 15, YOFF = 15;

final static float P_XOFF = 640, P_YOFF = 30, P_W = 440, P_H = 80, P_H_A = 165;

final static float ST_Y = 480, ST_H = 220, ST_W = 440; 

final static float W_S_X = 1100, W_S_W = 160, W_S_Y = 320, W_S_H = 380;

// colors 
public static final color PEACH = #F7CE91;
public static final color GREEN = #00FF00;
public static final color DARK_GREEN = #035A02;
public static final color LIGHT_GREEN = #A1FFA0;
public static final color DEFAULT = #23FF86;
public static final color DARK_BLUE = #0000FF;
public static final color LIGHT_BLUE = #46E8DE;
public static final color ORANGE = #FFC081;
public static final color DARK_ORANGE = #EFA071;
public static final color RED = #FF0000;

public static final color TEXT_BOX_TEXT_COLOR = #000000;
public static final color TEXT_BOX_BASE_COLOR = #FFFFFF;
public static final color TEXT_BOX_BORDER_COLOR = #000000;
public static final color TEXT_BOX_FOCUSED_BORDER_COLOR = DARK_BLUE;

// program states
/** not required for Godmode
final int startScreen = 0; // constants must be unique numbers 
final int options     = 1; 
final int normalGame  = 2; 
final int gameOver    = 3; 
int state = startScreen;   // current 
*/

HashMap<Character, Integer> values = new HashMap<Character, Integer>();

ArrayList<Letter> letters = new ArrayList<Letter>();
ArrayList<Letter> pile = new ArrayList<Letter>();

//harcoded because we're using official scrabble pattern of double/triple words/letters
Cell[][] grid = new Cell[15][15];

Player[] players;
int activePlayer = 0;

// ---------------------------------------------------------------

void setup() {

  size(1280, 720, FX2D);

  initLetters();
  initGrid();
  initDictionary();
  
  if(GODMODE){
    loadProgram();
    firstMove = false;//VERY IMPORTANT THAT THE STAR IS COVERED IN THE SITUATION
  }
  
  addPlayers();
  
  background(0);
}

void draw() {
   normalGame();
}//func
//