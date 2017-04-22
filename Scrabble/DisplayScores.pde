void showScoreTable(ArrayList<Word> words){
  pushStyle();
  strokeWeight(3);
  stroke(DARK_GREEN);
  fill(LIGHT_GREEN);
  rect(P_XOFF, ST_Y, ST_W, ST_H, 6);
  fill(0);
  textSize(30);
  text("Score Table", P_XOFF + ST_W/2 - textWidth("Score Table")/2, ST_Y + 32);
  line(P_XOFF, ST_Y + 35, P_XOFF + ST_W, ST_Y + 35);
  strokeWeight(1);
  int h = int((ST_H - 35)/5);
  for(int i = 0; i < 4; i++){
    line(P_XOFF, ST_Y + 35 + h*(i+1), P_XOFF + ST_W, ST_Y + 35 + h*(i+1));
  }
  if(words.size() <= 5){  
    textSize(22);
    for(int i = 0; i < words.size(); i++){
      Word w = words.get(i);
      text(w.val, P_XOFF + 20, ST_Y + 27 + h*(i+1));
      text(": " + w.score, P_XOFF + ST_W - 80, ST_Y + 30 + h*(i+1));
    }
  }else{
    //TO BE COMPLETED
    line(P_XOFF + ST_W/2, ST_Y + 32, P_XOFF + ST_W/2, ST_Y + ST_H);
    for(int i = 0; i < 5; i++){
    }
    for(int i = 5; i < words.size(); i++){
    }
  }
  popStyle();
}