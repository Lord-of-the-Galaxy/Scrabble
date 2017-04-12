void initLetters() {
  defineValuePoints('A', 1);
  defineValuePoints('B', 3);
  defineValuePoints('C', 3);
  defineValuePoints('D', 2);
  defineValuePoints('E', 1);
  defineValuePoints('F', 4);
  defineValuePoints('G', 2);
  defineValuePoints('H', 4);
  defineValuePoints('I', 1);
  defineValuePoints('J', 8);
  defineValuePoints('K', 5);
  defineValuePoints('L', 1);
  defineValuePoints('M', 3);
  defineValuePoints('N', 1);
  defineValuePoints('O', 1);
  defineValuePoints('P', 3);
  defineValuePoints('Q', 10);
  defineValuePoints('R', 1);
  defineValuePoints('S', 1);
  defineValuePoints('T', 1);
  defineValuePoints('U', 1);
  defineValuePoints('V', 4);
  defineValuePoints('W', 4);
  defineValuePoints('X', 8);
  defineValuePoints('Y', 4);
  defineValuePoints('Z', 10);
  defineValuePoints(' ', 0);

  generateXLetters('A', 9);
  generateXLetters('B', 2);
  generateXLetters('C', 2);
  generateXLetters('D', 4);
  generateXLetters('E', 12);
  generateXLetters('F', 2);
  generateXLetters('G', 3);
  generateXLetters('H', 2);
  generateXLetters('I', 9);
  generateXLetters('J', 1);
  generateXLetters('K', 1);
  generateXLetters('L', 4);
  generateXLetters('M', 2);
  generateXLetters('N', 6);
  generateXLetters('O', 8);
  generateXLetters('P', 2);
  generateXLetters('Q', 1);
  generateXLetters('R', 6);
  generateXLetters('S', 4);
  generateXLetters('T', 6);
  generateXLetters('U', 4);
  generateXLetters('V', 2);
  generateXLetters('W', 2);
  generateXLetters('X', 1);
  generateXLetters('Y', 2);
  generateXLetters('Z', 1);
  generateXLetters(' ', 2);
}

void defineValuePoints(char c, int s) {
  values.put(c, s);
}

void generateXLetters(char c, int no){
  for(int i = 0; i < no; i++){
    
  }
}