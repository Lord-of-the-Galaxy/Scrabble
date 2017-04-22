class Word {
  Cell start;
  boolean vertical;

  ArrayList<Character> chars;
  ArrayList<Integer> scores;
  ArrayList<Integer> mults;
  int mult;
  
  int score;
  String val;

  Word(Cell start_, boolean vertical_) {
    start = start_;
    vertical = vertical_;
    mult = 1;
    mults = new ArrayList<Integer>();
    scores = new ArrayList<Integer>();
    chars = new ArrayList<Character>();
  }
  
  void add(char c, int s, int m){
    chars.add(c);
    scores.add(s);
    mults.add(m);
  }
  
  void mult(int m){
    mult+=m;
  }
  
  void init(){
    StringBuilder sb = new StringBuilder();
    
    score = 0;
    
    for(int i = 0; i < chars.size(); i++){
      sb.append(chars.get(i));
      score += (scores.get(i)*mults.get(i));
    }
    
    score *= mult;
    
    val = sb.toString();
  }
  
  @Override
  String toString(){
    return "Word: " + val + ", Score: " + score;
  }
}