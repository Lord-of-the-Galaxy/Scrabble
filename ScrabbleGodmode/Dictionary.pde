

// tab for dictionary purposes 


// full DICTIONARY
Table tableDictionary;

TableRow row;

final String BLANK_LETTER  ="_";

final int WORD_OK        =0; 
final int WORD_POSSIBLE  =1; 
final int WORD_WRONG     =2;
final int WORD_EMPTY     =3;

int xShowMore=0; 

void initDictionary() {
  // load full DICTIONARY
  tableDictionary = loadTable("wordsEn.csv");
}//func   

boolean wordExists(String word) {

  // check in DICTIONARY, return boolean 

  // 1. empty word = false!!! 
  word = trim(word); 
  word = word.toLowerCase();
  if (word.equals(""))
    return false; // fail

  // 2. normal word found = true 
  row = tableDictionary.findRow(word, 0);
  if (row!=null) { 
    return true; // success
  }

  // 3. no blank letter = false 
  if (!word.contains(BLANK_LETTER))
    return false; // fail 

  // 4. we have a blank letter, now check 
  row = tableDictionary.matchRow(toREGEX(word), 0);
  if (row!=null) { 
    return true; // success
  }//if

  return false; // fail
} // func 

int wordExistsInt(String word) {

  // check in DICTIONARY, returns INT 

  // similar to above but tells different situations by the int it returns

  word = trim(word); 
  word=word.toLowerCase();
  if (word.equals(""))
    return WORD_EMPTY; // fail

  row = tableDictionary.findRow(word, 0);
  if (row!=null) { 
    return  WORD_OK; // success
  }

  if (!word.contains(BLANK_LETTER))
    return WORD_WRONG; // fail 

  row = tableDictionary.matchRow(toREGEX(word), 0);
  if (row!=null) { 
    return WORD_POSSIBLE; // success
  }

  return WORD_WRONG; // fail
}//func 

void showMore22222222222222(String word, float y) { // not in use ?????

  // simply prints a String array 

  float i=y; 
  String[] list = getWordList(word); 

  // println(list.length); 

  for (String s1 : list) {
    fill(110); // GRAY 
    text(s1, xShowMore, i);
    i+=29;
  }
  text("("+list.length+")", xShowMore, i);
  xShowMore+=155;
} 

String[] getWordList(String word) {

  // returns all matches as a string array 

  String result=""; 
  for (TableRow row : tableDictionary.matchRows(toREGEX(word), 0)) {
    result+=row.getString(0)+"#";
  }// for
  result=result.substring(0, result.length()-1);
  return split(result, "#");
} 

String toREGEX(String word) {
  String result = trim(word); 
  result=result.toLowerCase();
  result=result.replace(BLANK_LETTER, ".");
  result="^"+result+"$"; 

  return result;
}// func 

//