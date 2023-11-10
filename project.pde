
//some constant
final int stateMenu = 0;
final int stateTutorial = 1;
final int stateGame = 2;

//global variables
int state = 0;
int time = 0;
cursor Mouse = new cursor();
graphics engine = new graphics();

//images and fonts
PFont dotGothic, determinationMono;

void setup(){
  size(800, 600);
  
  // load the background
  //PImage menuBg = loadImage("menu.jpg");
  //image(menuBg, 0, 0);
  
  //load the font
  
  dotGothic = createFont("DotGothic16-Regular.ttf", 100);
  determinationMono  = createFont("DeterminationMonoWebRegular-Z5oq.ttf", 100);
  
}

void draw(){
  if (state == stateMenu){
    engine.menu();
  }
  if (state == stateTutorial){
    engine.tutorial();
  }
  if (state == stateGame){
    engine.game();
  }
  if (keyPressed){
      Mouse.action();
  }
}

class cursor{
  int pos;
  
  cursor(){
    pos = 400;
  }
  void render(){
    text(">", 75, pos);
  }
  void action(){
    if (key == 'w' && pos == 450){
      pos = 400;
    }
    if (key == 's' && pos == 400){
      pos = 450;
    }
    if (key == ENTER){
      if (pos == 400){
        state = 2;
      }
      if (pos == 450){
        state = 1;
      }
    }
    if (key == 'b'){
      state = 0;
    }
  }
}

class graphics{
  graphics(){
  }

  void menu(){
    background(0, 100, 150);
    textFont(determinationMono, 100);
    text("Safe Landing", 100, 200);
    textFont(determinationMono, 50);
    text("START", 100, 400);
    text("TUTORIAL", 100, 450);
    Mouse.render();
  }
  void tutorial(){
    background(0, 100, 150);
    textFont(determinationMono, 50);
    text("Press \"B\" to back to Menu ", 10, 40);
    textFont(determinationMono, 100);
    text("TUTORIAL", 200, 150);
    textFont(determinationMono, 30);
    text("1. Try to fall to the ground in exactly 5 seconds!", 30, 200);
    text("2. Click the corresponding button whenever you", 30, 230);
    text("   want, and your character will fall.", 30, 260);
    text("3. If you land within 5 secs, you're fine.", 30, 290);
    text("4. But if you spend more than 5 secs, you lose.", 30, 320);
    text("5. The player whose landing time is the closest to ", 30, 350);
    text("   5 secs won.", 30, 380);
  }
  
  void game(){
    background(0, 100, 150);
  }
}



class player{
  int[] pos = new int[2];
  boolean fall = false;
  // (x, y) = (pos[0], pos[1])
  void keyPressed(){
     //to fall
  }
}

class Game{
  // constant for readability
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
  
  void await(){
    while (!keyPressed){
      
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
