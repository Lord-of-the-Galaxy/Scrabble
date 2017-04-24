
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
  println("Double Click");
  for (int i = 0; i < letters.size(); letters.get(i++).doubleClicked());
}