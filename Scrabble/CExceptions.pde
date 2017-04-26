class NoWordException extends Exception{
  
  NoWordException(){
    super("No such word.");
  }
}

class DiscontinuousWordException extends Exception{
  DiscontinuousWordException(){
    super("Word is discontinous, i.e. multiple words are forming.");
  }
}