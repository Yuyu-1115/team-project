


int time = 0;

void setup(){
  size(800, 600);
  background(122);
}

void draw(){
 
}


class player{
  int[] pos = new int[2];
  boolean fall = false;
  // (x, y) = (pos[0], pos[1])
  void keyPressed(){
     //to fall
  }
  void 
}

class Game{
  // constant for readibility
  final int STATE_READY = 0;
  final int STATE_MAIN = 1;
  final int STATE_RESULT = 2;
  
  // all the variable is here
  int playerCount, frame;
  player[] playerList = new player[3];
  
  // constructor
  Game(int player){
    frame = 0;
    playerCount = player;
    //create player
    for (int i = 0 ; i < playerCount; i++){
      playerList[i] = new player();
    } 
    
  }
  
  //where the game run
  void operate(int gameState){
    switch(gameState){
      case STATE_READY:
        //do something
      case STATE_MAIN:
        //do something
      case STATE_RESULT:
        //do something
    }
  }
  
  
}
