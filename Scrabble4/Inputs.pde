
// tab for Inputs 

void mousePressed() {
  // mouse 
  if (state==startScreen) {
    return;
  }//if

  if (state==options) {
    return;
  }//if

  for (int i = 0; i < letters.size(); letters.get(i++).mousePressed());
  if (scrollbar) {
    btnUp.mousePressed();
    btnDown.mousePressed();
  }
}

void mouseReleased() {
  for (int i = 0; i < letters.size(); letters.get(i++).mouseReleased());

  //for (int i = 0; i < 15; i++) {
  //  for (int j = 0; j < 15; j++) {
  //    if (grid[i][j].empty==false) {
  //      println(i + " " + j + " " + grid[i][j].cur);
  //    }
  //  }
  //}
}

public void mouseClicked(MouseEvent evt) {
  if (evt.getCount() == 2)doubleClicked();
  
  if (state!=options)
    return; 

  int i = idx = -1;
  while (++i != tboxes.length) {
    if (tboxes[i].checkFocus())  
      idx = i;
  }
}

void doubleClicked() {
  for (int i = 0; i < letters.size(); letters.get(i++).doubleClicked());
}

void keyPressed() {

  if (state!=options)
    return; 

  if (key == ESC) {
    // println("esc 2");
    //state=normalGame; 
    key=0;
    return;
  } 

  if (key != CODED | idx < 0)  return;
  final int k = keyCode;

  final TextBox tbox = tboxes[idx];
  final int len = tbox.txt.length();

  if (k == LEFT)  
    tbox.txt = tbox.txt.substring(0, max(0, len-1));
  else if (k == RIGHT & len < tbox.lim-3)  
    tbox.txt += "    ";
}

void keyTyped() {

  if (state!=options)
    return; 

  if (key == ESC) {
    // println("esc 2");
    //state=normalGame; 
    key=0;
    return;
  } 

  final char k = key;

  if (k == CODED | idx < 0)  return;

  final TextBox tbox = tboxes[idx];
  final int len = tbox.txt.length();

  if (k == BACKSPACE) 
    tbox.txt = tbox.txt.substring(0, max(0, len-1));
  else if (len >= tbox.lim)  
    return;
  else if (k == ENTER | k == RETURN) {     
    //tbox.txt += "\n";
  } else if (k == TAB & len < tbox.lim-3)  
    tbox.txt += "    ";
  else if (k == DELETE) 
    tbox.txt = "";
  else if (k >= ' ')     
    tbox.txt += str(k);
}
//