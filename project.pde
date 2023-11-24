
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
  engine.render();
}

void keyPressed(){
  Mouse.action();
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
    if (key == ENTER && state == stateMenu){
      if (pos == 400){
        engine.Game = new game(3);
        state = stateGame;
      }
      if (pos == 450){
        state = stateTutorial;
      }
    }
    if (key == 'b'){
      state = stateMenu;
    }
  }
}

class graphics{
  game Game = new game(3);
  boolean await = false;
  String[] suffix = new String[3];
  graphics(){
    suffix[0] = "st";
    suffix[1] = "nd";
    suffix[2] = "rd";
  }
  
  void render(){
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
  }

  void menu(){
    fill(255);
    background(0, 100, 150);
    textFont(determinationMono, 100);
    text("Safe Landing", 100, 200);
    textFont(determinationMono, 50);
    text("START", 100, 400);
    text("TUTORIAL", 100, 450);
    Mouse.render();
  }
  void tutorial(){
    fill(255);
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
    this.backgroundGame(0);
    fill(255);
    textFont(determinationMono, 50);
    text("Press \"B\" to back to Menu ", 10, 40);
    textFont(determinationMono, 100);
    text("OPTIONS", 200, 150);
  }
  
  void standby(){
    this.await = false;
    background(0, 100, 0);
    
  }
  
  void backgroundGame(int frame){
    rectMode(CORNERS);
    background(200);
    
    //wall
    fill(#7C4D14);
    strokeWeight(3);
    rect(0, 100, 100, height);
    rect(700, 100, width, height);
    
    //ground (floor)
    fill(0, 200, 0);
    noStroke();
    rect(102, 550, 699, height);
    
    //bracket*3
    stroke(150);
    strokeWeight(10);
    for (int i = 180; i < 621; i += 180){
      line(i, 100, i, 550);
      line(i + 80, 100, i + 80, 550);
    }
    
    //timeclock
    stroke(#FFF300);
    strokeWeight(2);
    for (int i = 0; i < 3; i++){
      fill(0);
      rect(160 + 180 * i, 25, 280 + 180 * i, 80);
      fill(255);
      if (!this.Game.playerList[i].finished){
        textFont(determinationMono, 60);
        text(frame / 60, 160 + 180 * i, 75);
        text(".", 190 + 180 * i, 75);
        text((frame % 60) * 5 / 3, 200 + 180 * i, 75);
      }
      else{
        textFont(determinationMono, 60);
        text(this.Game.playerList[i].result[1] / 60, 160 + 180 * i, 75);
        text(".", 190 + 180 * i, 75);
        text((this.Game.playerList[i].result[1] % 60) * 5 / 3, 200 + 180 * i, 75);
      }
    }
  }
  
  void result(){
    
    int y = 200;
    int initX = 100;
    if (!this.await){
      player[] rank = this.sort(this.Game.playerList);
    
      fill(255);
      background(0, 100, 150);
      textFont(determinationMono, 50);
      text("Press \"B\" to back to Menu ", 10, 40);
      textFont(determinationMono, 100);
      text("RESULT", 200, 150);
      textFont(determinationMono, 30);
      
      
      //print the result
      for (int i = 0; i < 3; i++){
        text(i + 1, initX, y);
        text(suffix[i], initX + 15, y);
        text("Player", initX + 70, y);
        text(rank[i].result[0] + 1, initX + 170, y);
        y += 50;
        text(this.Game.playerList[rank[i].result[0]].result[1] / 60, initX, y); 
        text(".", initX + 15, y);
        text((this.Game.playerList[rank[i].result[0]].result[1] % 60) * 5 / 3, initX + 20, y);
        text("sec(s)", initX + 80, y);
        y += 50;
      }
      this.await = true;
    }
    
  }
  
  //default sort() doesn't support custom datatype, so yeah
  player[] sort(player[] list){
    player temp;
    for (int i = 0; i < 3; i++){
      list[i].result[1] = abs(300 - list[i].result[1]);
    }
   
   
    //I know bubble sort is inefficient, but n = 3, so who cares
    for (int i = 0; i < 3; i++){
      for (int j = 0; j < 2 - i; j++){
         if (list[j].result[1] > list[j + 1].result[1]){
             //swap
             temp = list[j + 1];
             list[j + 1] = list[j];
             list[j] = temp;
         }
      }
    }
    return list; 
  }
}



class player{
  int[] result = new int [2];
  int[] pos = new int[2];
  int speed = 0;
  boolean fall = false;
  boolean finished = false;
  char[] dic = new char[3];
  // (x, y) = (pos[0], pos[1])
  
  player(int number){
    this.result[0] = number;
    this.result[1] = 0;
    this.pos[0] = 220 + 180 * this.result[0];
    this.pos[1] = 150;
    this.dic[0] = 'a';
    this.dic[1] = 'g';
    this.dic[2] = 'l';
  }
  
  void move(int frame){
    if (!this.finished){
      if (keyPressed && key == dic[this.result[0]]){
        this.fall = true;
      }
      if (this.fall){
        this.speed += 5 * frame / 60;
        this.pos[1] += this.speed;
      }
      if (this.pos[1] > 500){
        this.pos[1] = 500;
        this.result[1] = frame;
        this.finished = true;
      }
    }
  }
  
  void update(int frame){
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
      engine.backgroundGame(this.frame);
      stroke(#FFFFFF);
      textFont(determinationMono, 50);
      for (int i = 0; i < 3; i++){
          this.playerList[i].update(frame);
      }
    }
  }
  
  void result(){
    engine.result();
  }
  
}
