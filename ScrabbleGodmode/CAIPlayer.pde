abstract class AIPlayer extends Player implements Runnable{

  Queue<Action> actions;
  boolean acting = false;
  Action curA;

  ProgressBar bar;
  
  AICell[][] ai_grid;

  AIPlayer(PApplet p, int i) {
    super(p, i);
    actions = new ConcurrentLinkedQueue<Action>();
    bar = new ProgressBar(new PVector(P_XOFF + S, index*P_H + 110), 7*S);
    bar.setColors(color(255), DARK_BLUE, LIGHT_BLUE);
    bar.setMinMax(0, 100);
    ai_grid = new AICell[15][15];
  }

  void displayActive() {
    if (acting) {
      if (curA.execute())acting = false;
    } else {
      if (actions.size() > 0) {
        curA = actions.poll();
        acting = true;
      }
    }

    synchronized(bar) {
      bar.draw();
    }
  }
  
  //progress is a percentage
  void update(float progress){
    synchronized(bar){
      bar.update(progress);
    }
  }
  
  boolean moveLetterActual(Letter l, int posX, int posY) {
    if(l.activeForAI){
      int x = l.x;
      int y = l.y;
      int nx = x + constrain(posX - x, 0, 3);
      int ny = y + constrain(posY - y, -3, 3);
      return nx == x && ny == y;
    }else{
      err(561, l);
      return false;
    }
  }


  void moveLetter(final Letter l, final int posX, final int posY) {
    Action a = new Action() {
      public boolean execute() {
        return moveLetterActual(l, posX, posY);
      }
    };
    actions.add(a);
  }
  
  void activate(){
    for(int i = 0; i < 7; set[i++].activeForAI(true));
    for(int i = 0; i < 15; i++){
      for(int j = 0; j < 15; j++){
        if(grid[i][j].empty)ai_grid[i][j] = new AICell(grid[i][j].type);
      }
    }
    new Thread(this).start();
  }
  
  void deactivate(){
    super.deactivate();
    for(int i = 0; i < 7; set[i++].activeForAI(false));
  }
  
  
  abstract void runAI();
  
  public void run(){
    runAI();
    while(actions.size() != 0){
      try{
        Thread.sleep(100);
      }catch (InterruptedException ie){
        System.err.println("Thread has been interrupted. Trying to continue ignoring the interruption :)");
        continue;
      }
    }
    int err = checkMove();
    if(err != 0){
      err(err, nonExistantWord);
      throw new RuntimeException("Error in AI - cannot continue further");
    }
  }
}

interface Action {
  public boolean execute();//must execute the next step of action and return true once done
}

class AICell{
  int type;
  char val;
  
  AICell(int type){
    this(type, '.');
  }
  
  AICell(int type_, char c){
    type = type_;
    val = c;
  }
}