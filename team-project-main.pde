
//some constant
final int stateMenu = 0;
final int stateTutorial = 1;
final int stateConfiguration = 2;
final int stateGame = 3;

final int stateStandby = 0;
final int stateMain = 1;
final int stateResult = 2;

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
  ellipseMode(CENTER);
  
}

void draw(){
  engine.render(Mouse);
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
        state = 3;
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
  game Game = new game(3);
  String[] rank = new String[3];
  graphics(){
    rank[0] = "st";
    rank[1] = "nd";
    rank[2] = "rd";
  }
  
  void render(cursor Mouse){
    if (state == stateMenu){
      this.menu();
    }
    if (state == stateTutorial){
      this.tutorial();
    }
    if (state == stateConfiguration){
      this.configuration();
    }
    if (state == stateGame){
      this.Game.operate();
    }
    if (keyPressed){
      Mouse.action();
    }
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
  
  void configuration(){
    this.backgroundGame();
    textFont(determinationMono, 50);
    text("Press \"B\" to back to Menu ", 10, 40);
    textFont(determinationMono, 100);
    text("OPTIONS", 200, 150);
  }
  
  void standby(){
    background(0, 100, 0);
  }
  
  void backgroundGame(){
    background(0, 100, 150);
  }
  
  void result(int[] finishedFrame){
    int y = 300;
    
    background(0, 100, 150);
    textFont(determinationMono, 50);
    text("Press \"B\" to back to Menu ", 10, 40);
    textFont(determinationMono, 100);
    text("RESULT", 200, 150);
    textFont(determinationMono, 30);
    for (int i = 0; i < 3; i++){
      text(finishedFrame[i], 200, y);
      y += 50;
    }
    
  }
}



class player{
  int number, finishedFrame;
  int[] pos = new int[2];
  int speed = 0;
  boolean fall = false;
  char[] dic = new char[3];
  // (x, y) = (pos[0], pos[1])
  
  player(int number){
    this.number = number;
    this.pos[0] = 300 + 100 * number;
    this.pos[1] = 50;
    this.dic[0] = 'a';
    this.dic[1] = 'g';
    this.dic[2] = 'l';
  }
  
  void move(int frame){
    if (this.finishedFrame == 0){
      if (keyPressed && key == dic[this.number]){
        this.fall = true;
      }
      if (this.fall){
        this.speed += 5 * frame / 60;
        this.pos[1] += this.speed;
      }
      if (this.pos[1] > 500){
        this.pos[1] = 500;
        this.finishedFrame = frame;
      }
    }
  }
  
  void render(int frame){
    this.move(frame);
    ellipse(pos[0], pos[1], 20, 20);
  }
}

class game{
  
  // all the variable is here
  int playerCount, frame;
  int gameState;
  player[] playerList = new player[3];
  
  // constructor
  game(int player){
    this.gameState = stateStandby;
    this.frame = 0;
    this.playerCount = player;
    //create player
    for (int i = 0 ; i < playerCount; i++){
      this.playerList[i] = new player(i);
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
    engine.standby();
    if (keyPressed && key == 't'){
      this.gameState = stateMain;
    }
  }
  
  void run(){
    if (frame == 300){
         this.gameState = stateResult;
         return;
    }
    else{
      this.frame += 1;
      engine.backgroundGame();
      textFont(determinationMono, 50);
      text(frame / 60, width / 2, height / 2);
      text((frame % 60) * 5 / 3, width / 2 + 50, height / 2);
      for (int i = 0; i < 3; i++){
          this.playerList[i].render(frame);
      }
    }
  }
  
  void result(){
    int[] finishedFrame = new int[3];
    for (int i = 0; i < 3; i++){
      finishedFrame[i] = 500 - this.playerList[i].finishedFrame;
    }
    engine.result(finishedFrame);
  }
  
}
