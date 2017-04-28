

// SCRABBLE

// main tab

import javax.swing.JOptionPane;
import java.util.Collections;
import java.util.*;
// import javax.swing.*;
import java.util.concurrent.*;

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
final int startScreen = 0; // constants must be unique numbers 
final int options     = 1; 
final int normalGame  = 2; 
final int gameOver    = 3; 
final int stateWaitForLoad = 4; 
int state = startScreen;   // current 

String loadPath=""; 

HashMap<Character, Integer> values = new HashMap<Character, Integer>();

ArrayList<Letter> letters = new ArrayList<Letter>();
ArrayList<Letter> pile = new ArrayList<Letter>();

//hard coded because we're using official scrabble pattern of double/triple words/letters
Cell[][] grid = new Cell[15][15];

HumanPlayer[] players;
int activePlayer = 0;

String[] list; 

// ---------------------------------------------------------------

void setup() {

  size(1280, 720);

  initLetters();
  initGrid();
  initDictionary(); 
  initWelcomeScreen(); 

  background(0);
}

void draw() {
  switch(state) {

  case startScreen:
    // start screen
    showWelcomeScreen();
    break; 

  case options: 
    // enter names 
    showOptions(); 
    break;

  case normalGame:
    // Game 
    normalGame();
    break; 

  case gameOver:
    // display message
    showGameOver(); 
    break;   

  case stateWaitForLoad:
    //
    if (!loadPath.equals("")) {
      list=loadStrings(loadPath); 
      state=normalGame;
    }
    break; 

  default:
    // error
    err(971, state);
    exit(); 
    break;
  } // switch 
  //
}//func
//