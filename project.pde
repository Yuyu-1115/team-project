
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
  
  //load the font
  dotGothic = createFont("DotGothic16-Regular.ttf", 100);
  determinationMono  = createFont("DeterminationMonoWebRegular-Z5oq.ttf", 100);
  ellipseMode(CENTER);
  
}

void draw(){
  engine.render();
}

void keyPressed(){
  if (state == stateConfiguration){
    Mouse.actionConfiguration();
  }
  else{
    Mouse.actionMenu();
  }
}

class cursor{
  int now;
  int[] max = new int[3];
  
  cursor(){
    now = 0;
    max[0] = 3;
    max[1] = 10;
    max[2] = 200;
  }
  void render(){
    fill(255, 255, 0);
    text(">", 75, 400 + 50 * now);
  }
  void actionMenu(){
    if (key == 'w' && now > 0){
      now--;
    }
    if (key == 's' && now < 2){
      now++;
    }
    if (key == ENTER && state == stateMenu){
      if (now == 0){
        engine.Game = new game(engine.config[0], engine.config[1], engine.config[2]);
        state = stateGame;
      }
      if (now == 1){
        state = stateTutorial;
      }
      if (now == 2){
        state = stateConfiguration;
      }
    }
    if (key == 'b'){
      state = stateMenu;
      now = 0;
    }
  }
  void actionConfiguration(){
    if (key == 'b'){
      state = stateMenu;
      now = 0;
    }
    if (key == 'w' && now > 0){
      now--;
    }
    if (key == 's' && now < 2){
      now++;
    }
    if (key == 'a'){
      if (engine.config[now] > 1){
        engine.config[now]--;
      }
    }
    
    if (key == 'd'){
      if (engine.config[now] < this.max[now]){
        engine.config[now]++;
      }
    }
    
    
    
  }
}

class graphics{
  game Game;
  int[] config = new int[3];
  boolean await = false;
  String[] suffix = new String[3];
  String[] option = new String[3];
  String[] menu = new String[3];
  graphics(){
    suffix[0] = "st";
    suffix[1] = "nd";
    suffix[2] = "rd";
    option[0] = "PLAYERS";
    option[1] = "TIME";
    option[2] = "SPEED";
    config[0] = 3;
    config[1] = 5;
    config[2] = 5;
    menu[0] = "START";
    menu[1] = "TUTORIAL";
    menu[2] = "OPTION";
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
    
    
    for (int i = 0; i < 3; i++){
      if (i == Mouse.now){
        fill(255, 255, 0);
      }
      else{
        fill(255);
      }
      text(this.menu[i], 100, 400 + i * 50);
    }
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
    text("1. Try to fall to the ground in the exact time", 30, 200);
    text("2. Click the corresponding button whenever you", 30, 230);
    text("   want, and your character will fall.", 30, 260);
    text("3. If you land within times, you're fine.", 30, 290);
    text("4. But if you think too long, you lose.", 30, 320);
    text("5. The player whose landing time is the closest to ", 30, 350);
    text("   the given time won.", 30, 380);
  }
  
  void configuration(){
    
    
    background(0, 100, 120);
    fill(255);
    textFont(determinationMono, 50);
    text("Press \"B\" to back to Menu ", 10, 40);
    textFont(determinationMono, 100);
    text("OPTIONS", 200, 150);
    
    textFont(determinationMono, 50);
    for (int i = 0; i < 3; i++){
      if (i == Mouse.now){
        fill(255, 255, 0);
      }
      else{
        fill(255);
      }
      text(this.option[i], 100, 300 + i * 50);
      text("<     >", 300, 300 + i * 50);
      text(this.config[i], 380, 300 + i * 50);
    }
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
    strokeWeight(10);
    for (int i = 1; i < this.Game.playerCount + 1; i += 1){
      stroke(this.Game.playerList[i - 1].colour[0], this.Game.playerList[i - 1].colour[1], this.Game.playerList[i - 1].colour[2]);
      line(180 * i, 100, 180 * i, 550);
      line(180 * i + 80, 100, 180 * i + 80, 550);
    }
    
    //clock
    strokeWeight(2);
    for (int i = 0; i < this.Game.playerCount; i++){
      stroke(this.Game.playerList[i].colour[0], this.Game.playerList[i].colour[1], this.Game.playerList[i].colour[2]);
      fill(0);
      rect(160 + 180 * i, 25, 280 + 180 * i, 80);
      fill(255);
      textFont(determinationMono, 60);
      if (!this.Game.playerList[i].finished){
        text(frame / 60, 160 + 180 * i, 75);
        text(".", 190 + 180 * i, 75);
        text((frame % 60) * 5 / 3, 200 + 180 * i, 75);
      }
      else{
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
      player[] rank = this.ranking(this.Game.playerList);
    
      fill(255);
      background(0, 100, 150);
      textFont(determinationMono, 50);
      text("Press \"B\" to back to Menu ", 10, 40);
      textFont(determinationMono, 100);
      text("RESULT", 250, 150);
      textFont(determinationMono, 30);
      
      
      //print the result
      for (int i = 0; i < this.Game.playerCount; i++){
        text(i + 1, initX, y);
        text(suffix[i], initX + 15, y);
        text("Player", initX + 70, y);
        text(rank[i].result[0] + 1, initX + 170, y);
        y += 50;
        if (this.Game.playerList[rank[i].result[0]].result[1] == 10000){
          text("Failed", initX, y); 
        }
        else{
          text(this.Game.playerList[rank[i].result[0]].result[1] / 60, initX, y); 
          text(".", initX + 15, y);
          text((this.Game.playerList[rank[i].result[0]].result[1] % 60) * 5 / 3, initX + 20, y);
          text("sec(s)", initX + 80, y);
        }
        y += 50;
      }
      this.await = true;
    }
    
  }
  
  //default sort() doesn't support custom datatype, so yeah
  player[] ranking(player[] list){
    int[] test = new int[3];
    player temp;
    for (int i = 0; i < this.Game.playerCount; i++){
      test[i] = list[i].result[1];
      list[i].result[1] = abs(this.Game.time - list[i].result[1]);
    }
   
    // sort   
    //I know bubble sort is inefficient, but n = 3, so who cares
    for (int i = 0; i < this.Game.playerCount; i++){
      for (int j = 0; j < this.Game.playerCount - 1 - i; j++){
         if (list[j].result[1] > list[j + 1].result[1]){
             //swap
             temp = list[j + 1];
             list[j + 1] = list[j];
             list[j] = temp;
         }
      }
    }
    for (int i = 0; i < this.Game.playerCount; i++){
      list[i].result[1] = test[i];
    }
    
    
    return list; 
  }
}



class player{
  int[] result = new int [2];
  int[] pos = new int[2];
  int[] colour = new int[3];
  int speed = 0;
  int time = 0;
  int acceleration;
  boolean fall = false;
  boolean finished = false;
  char[] dic = new char[3];
  // (x, y) = (pos[0], pos[1])
  
  player(int number, int acceleration){
    this.acceleration = acceleration;
    this.result[0] = number;
    this.result[1] = 10000;
    this.pos[0] = 220 + 180 * this.result[0];
    this.pos[1] = 150;
    this.dic[0] = 'a';
    this.dic[1] = 'g';
    this.dic[2] = 'l';
    for (int i = 0 ; i < 3; i++){
      if (i == this.result[0]){
        this.colour[i] = 255;
      }
      else{
        this.colour[i] = 0;
      }
    }
    
  }
  boolean update(int frame, int time){
    if (!this.finished){
      if (keyPressed && key == dic[this.result[0]]){
        this.fall = true;
      }
      if (this.fall){
        this.time++;
        this.speed += this.acceleration * this.time / 60;
        this.pos[1] += this.speed;
      }
      if (this.pos[1] > 500){
        this.pos[1] = 500;
        this.result[1] = frame > time ? 10000 : frame;
        this.finished = true;
        return true;
      }
    }
    stroke(0);
    fill(this.colour[0], this.colour[1], this.colour[2]);
    ellipse(this.pos[0], this.pos[1], 20, 20);
    return false;
  }
}

class game{
  
  // all the variable is here
  int playerCount, frame;
  int gameState;
  int time, acceleration;
  int finishedCount;
  player[] playerList = new player[3];
  
  // constructor
  game(int player, int time, int acceleration){
    this.gameState = stateStandby;
    this.frame = 0;
    this.playerCount = player;
    this.time = 60 * time;
    //create player
    for (int i = 0 ; i < this.playerCount; i++){
      this.playerList[i] = new player(i, acceleration);
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
    boolean finished = true;
    
    if (this.frame >= this.time){
       for (int i = 0; i < this.playerCount; i++){
         if (this.playerList[i].fall && !this.playerList[i].finished){
           finished = false;
         }
       }
       if (finished && this.frame == this.time + 60){
           this.gameState = stateResult;
           return;
       }    
    }
    this.frame++;
    engine.backgroundGame(this.frame);
    for (int i = 0; i < this.playerCount; i++){
      this.playerList[i].update(this.frame, this.time);
    }
  }
  
  void result(){
    engine.result();
  }
  
}