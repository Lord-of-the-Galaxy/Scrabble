
// tab input keyboard

void keyPressed() {

  if (state!=options)
    return; 

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