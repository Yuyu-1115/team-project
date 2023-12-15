class gameSM{
  
  //constant for the game
  static final int stateStandby = 0;
  static final int stateMain = 1;
  static final int stateResult = 2;
  
  // all the variable is here
  int playerCount, frame;
  int gameState;
  int time, acceleration;
  int finishedCount;
  int countdown = 180;
  boolean finished;
  player[] playerList = new player[3];
  int[] slot = new int[5];
  
  // constructor
  gameSM(int player, int time, int acceleration){
    this.gameState = stateStandby;
    this.frame = 0;
    this.playerCount = player;
    this.time = 60 * time;
    this.finishedCount = 0;
    
    
    //create player
    for (int i = 0 ; i < this.playerCount; i++){
      this.playerList[i] = new player(i, acceleration); 
    } 
    for (int i = 0 ; i < 5; i++){
      this.slot[i] = 0;
    }
    
  }
  
  //determine the state
  void operate(){
    if (this.gameState == stateStandby){
      this.standby();
    }
    else if (this.gameState == stateMain){
      this.run();
    }
    else{
      this.result();
    }
  }
 
  void standby(){
    
    if (keyPressed && key == 't' || this.countdown < 180){
      engine.standbySM(this.countdown, this.slot);
      this.countdown--;
    }
    else{
      engine.standbySM(-1, this.slot);
    }
  }
  
  void run(){
    this.finished = true;
    
    if (this.frame >= this.time){
       for (int i = 0; i < this.playerCount; i++){
         if (this.playerList[i].fall && !this.playerList[i].finished){
           this.finished = false;
         }
       }    
    }
    if (this.finished && this.frame >= (this.time + 60)){
         this.gameState = stateResult;
         return;
    }
    this.frame++;
    engine.backgroundSM(this.frame, this.slot);
    for (int i = 0; i < this.playerCount; i++){
      if (this.playerList[i].update(this.frame)){
        this.finishedCount++;
      }
    }
    if (this.finishedCount == this.playerCount){
          this.frame = this.time;
          this.finishedCount = 0;
      }
  }
  
  void result(){
    engine.result();
  }
  
}
