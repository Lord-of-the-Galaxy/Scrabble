
// tab for Inputs 

void mousePressed() {

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
}

void doubleClicked() {
  for (int i = 0; i < letters.size(); letters.get(i++).doubleClicked());
}

//