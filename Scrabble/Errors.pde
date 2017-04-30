protected <T> void err(int index, T... vars) {
  try {
    switch(index) {
    case -1:
      System.err.println("Error -1: Insufficient arguments to err(). Error in code!");
      break;
    case 231:
      System.err.println("Error 231: You're trying to put a letter in an occupied cell, " + vars[0].toString() + ". This shouldn't be happening. Error in code!");
      break;
    case 232:
      System.err.println("Error 232: There is no letter in this cell, " + vars[0].toString() + ". This shouldn't be happening. Error in code!");
      break;
    case 311:
      System.err.println("Error 311: This letter, " + vars[0].toString() + " is not a blank. You cannot set another value for it. Error in code!");
      break;
    case 561:
      System.err.println("Error 561: The AI cannot move " + vars[0] + " that does not belong to the player.");
    case 651:
      System.err.println("Error 651: " + getErrorMessage(651, vars).replaceAll("\n", " "));
      break;
    case 661:
      System.err.println("Error 661: " + getErrorMessage(661).replaceAll("\n", " "));
      break;
    case 671:
      System.err.println("Error 671: You ended up with a single letter first word. Error in code!");
      break;
    case 681:
      System.err.println("Error 681: All letters must be in a line");
      break;
    case 682:
      System.err.println("Error 682: " + getErrorMessage(682).replaceAll("\n", " "));
      break;
    case 683:
      System.err.println("Error 683: " + getErrorMessage(683).replaceAll("\n", " "));
      break; 
    case 684:
      System.err.println("Error 684: " + getErrorMessage(684).replaceAll("\n", " "));
      break;  
    case 685:
      System.err.println("Error 685: " + getErrorMessage(685).replaceAll("\n", " "));
      break;  
    case 689:
      System.err.println("Error 689: This isn't really an error ");
      break;
    case 971:
      System.err.println("Error 971: Unknown state "
        + vars[0].toString() 
        + ". Error in code!");
      break;
    default:
      String all_vars = "";
      if (vars.length != 0) {
        all_vars += "\nArguments passed in are:\n";
        for (int i = 0; i < vars.length; i++)all_vars += vars[i].toString() + "\n";
      }
      System.err.println("Error -2: Error code " + index + " does not exist! Error in code!" + all_vars);
    }
  }
  catch(ArrayIndexOutOfBoundsException e) {
    err(-1);
  }
}

protected <T> String getErrorMessage(int err, T... vars) {
  switch(err) {
  case 651:
    return "The word " + vars[0].toString() + " does not exist.";  
  case 661:
    return  "You must set a letter for the blank\nby double-clicking it";
  case 681:
    return getErrorMessage(685);
  case 682:
    return "You must place a letter on the starting\nsquare (STAR) in the first move";
  case 683: 
    return "All words must have at least 2 letters";
  case 684:
    return "The word formed should touch other words";
  case 685:
    return "All letters you place must be in a\nline, with no breaks in it";
  }
  return str(err) + "?";
}