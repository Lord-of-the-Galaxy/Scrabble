

// scores 

// for scrolling in the list 
Button btnUp, btnDown;

int start = 0; // for scrolling when words > 5

int wordsSize; 

void showScoreTable(ArrayList<Word> words, PApplet p) {

  btnUp = new Button(p, P_XOFF + ST_W, P_H + 410, 30, 30, "up") {
    @Override 
      public void pressed() {
      start--;
      if (start<0)
        start=0;
    }
  };
  btnDown = new Button(p, P_XOFF + ST_W, P_H + 490, 30, 30, "dn") {
    @Override
      public void pressed() {
      start++;
      checkStart();
    }
  };

  pushStyle();
  strokeWeight(3);
  stroke(DARK_GREEN);
  fill(LIGHT_GREEN);
  rect(P_XOFF, ST_Y, ST_W, ST_H, 6);
  fill(0);
  textSize(28);
  text("Score Table", 
    P_XOFF + ST_W/2 - textWidth("Score Table")/2, ST_Y + 32);
  line(P_XOFF, ST_Y + 35, P_XOFF + ST_W, ST_Y + 35);
  strokeWeight(1);
  int h = int((ST_H - 35)/5);
  for (int i = 0; i < 4; i++) {
    line(P_XOFF, ST_Y + 35 + h*(i+1), P_XOFF + ST_W, ST_Y + 35 + h*(i+1));
  }

  boolean mouse = mouseX > P_XOFF && mouseX < P_XOFF + ST_W;

  if (words.size() <= 5) {  

    displayScrollableList(words);

    /*
    textSize(22);
     for (int i = 0; i < words.size(); i++) {
     Word w = words.get(i);
     if (mouse && mouseY > ST_Y + 35 + h*i && mouseY < ST_Y + 35 + h*(i+1)) {
     pushStyle();
     noStroke();
     fill(GREEN);
     if (i != 4)
     rect(P_XOFF + 2, ST_Y + 37 + h*i, ST_W - 4, h - 2);
     else 
     rect(P_XOFF + 2, ST_Y + 37 + h*i, ST_W - 4, h - 2, 0, 0, 6, 6);
     displayWordScoreBreakup(w);
     popStyle();
     }
     text(w.val, P_XOFF + 20, ST_Y + 27 + h*(i+1));
     text(":", P_XOFF + ST_W - 140, ST_Y + 30 + h*(i+1));
     text(w.score, P_XOFF + ST_W - 20 - textWidth(str(w.score)), ST_Y + 27 + h*(i+1));
     }
     */
  } else {
    //TO BE COMPLETED // !!! ?????????????????
    displayScrollableList(words);
  }//else
  popStyle();
}

void checkStart() {
  if ( start > wordsSize - 5 ) {
    start=wordsSize - 5;    
    if (start<0)  
      start=0;
  }// if
}

void displayScrollableList(ArrayList<Word> words) {
  // !!!!!!!!!????????????

  boolean mouse = mouseX > P_XOFF && mouseX < P_XOFF + ST_W;
  int h = int((ST_H - 35)/5);

  wordsSize=words.size(); 

  btnUp.setVisible(true); 
  btnDown.setVisible(true); 

  btnUp.draw(); 
  btnDown.draw();

  line(P_XOFF + ST_W/2, ST_Y + 32, 
    P_XOFF + ST_W/2, ST_Y + ST_H);

  textSize(22);
  int k=0; 
  for (int i = start; i < min(start+5, words.size()); i++) {
    Word w = words.get(i); 
    if (mouse && mouseY > ST_Y + 35 + h*k && mouseY < ST_Y + 35 + h*(k+1)) {
      pushStyle(); 
      noStroke(); 
      fill(GREEN); 
      if (k != 4)
        rect(P_XOFF + 2, ST_Y + 37 + h*k, ST_W - 4, h - 2); 
      else 
      rect(P_XOFF + 2, ST_Y + 37 + h*k, ST_W - 4, h - 2, 0, 0, 6, 6); 
      displayWordScoreBreakup(w); 
      popStyle();
    }
    text(w.val, P_XOFF + 20, ST_Y + 27 + h*(k+1)); 
    text(":", P_XOFF + ST_W - 140, ST_Y + 30 + h*(k+1)); 
    text(w.score, P_XOFF + ST_W - 20 - textWidth(str(w.score)), ST_Y + 27 + h*(k+1));
    k++;
  }//for
}// func 

void displayWordScoreBreakup(Word w) {
  println(w.toString()); 
  pushStyle(); 
  strokeWeight(3); 
  stroke(DARK_GREEN); 
  fill(LIGHT_GREEN); 
  rect(W_S_X, W_S_Y, W_S_W, W_S_H, 6); 
  fill(0); 
  textSize(26); 
  text("Score Table", W_S_X + W_S_W/2 - textWidth("Score Table")/2, W_S_Y + 30); 
  line(W_S_X, W_S_Y + 35, W_S_X + W_S_W, W_S_Y + 35); 
  strokeWeight(1); 
  for (int i = 0; i < 3; line(W_S_X + (++i)*W_S_W/4, W_S_Y + 35, W_S_X + i*W_S_W/4, W_S_Y + W_S_H - 105)); 
  float h = constrain((W_S_H - 140)/w.val.length(), 14, 28); 
  textSize(h - 4); 
  textAlign(CENTER); 

  for (int i = 0; i < w.val.length(); i++) {
    if (i != w.val.length()-1 && 35 + h*(i+1) - W_S_H < 155)
      line(W_S_X, W_S_Y + 35 + h*(i+1), W_S_X + W_S_W, W_S_Y + 35 + h*(i+1)); 
    text(w.chars.get(i), W_S_X+W_S_W/8, W_S_Y + 35 + h*(i+1) - 2); 
    text(w.scores.get(i), W_S_X+W_S_W/8 + W_S_W/4, W_S_Y + 35 + h*(i+1) - 2); 
    text(w.mults.get(i), W_S_X+W_S_W/8 + W_S_W/2, W_S_Y + 35 + h*(i+1) - 2); 
    text(w.scores.get(i)*w.mults.get(i), W_S_X+W_S_W/8 + 3*W_S_W/4, W_S_Y + 35 + h*(i+1) - 2);
  }
  textAlign(LEFT); 
  strokeWeight(3); 
  textSize(22); 
  line(W_S_X, W_S_Y + W_S_H - 105, W_S_X + W_S_W, W_S_Y + W_S_H - 105); 
  line(W_S_X, W_S_Y + W_S_H - 70, W_S_X + W_S_W, W_S_Y + W_S_H - 70); 
  line(W_S_X, W_S_Y + W_S_H - 35, W_S_X + W_S_W, W_S_Y + W_S_H - 35); 
  text("Sum", W_S_X + 10, W_S_Y + W_S_H - 75); 
  text("Total", W_S_X + 5, W_S_Y + W_S_H - 5); 
  text(":", W_S_X + W_S_W/2, W_S_Y + W_S_H - 75); 
  text(":", W_S_X + W_S_W/2, W_S_Y + W_S_H - 5); 
  text(w.score/w.mult, W_S_X + W_S_W - textWidth(str(w.score/w.mult)) - 5, W_S_Y + W_S_H - 75); 
  text("x" + w.mult, W_S_X + W_S_W - 30, W_S_Y + W_S_H - 40); 
  text(w.score, W_S_X + W_S_W - textWidth(str(w.score)) - 5, W_S_Y + W_S_H - 5); 
  popStyle();
}