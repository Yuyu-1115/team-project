int state = 0;
cursor Mouse = new cursor();
graphics engine = new graphics();

//images and fonts
PFont determinationMono;

void setup(){
  //initialization
  size(800, 600);
  //load the font
  determinationMono  = createFont("DeterminationMonoWebRegular-Z5oq.ttf", 100);
  
}

void draw(){
  engine.render();
}

void keyPressed(){
  Mouse.update();
}

class cursor{
  int now;
  int[] max = new int[3];
  int[] underline = new int[3];
  
  cursor(){
    //initialization
    now = 0;
    max[0] = 3;
    max[1] = 9;
    max[2] = 200;
    underline[0] = 220;
    underline[1] = 295;
    underline[2] = 245;
  }
  void render(){
    stroke(255, 255, 0);
    line(100, 405 + 50 * now, this.underline[now], 405 + 50 * now);
    engine.texting(">", 75, 400 + 50 * now, 2, determinationMono, 50, 255, 255, 0);
  }
  
  void update(){
    if (state == graphics.stateMenu){
      this.actionMenu();
      
    }
    if (state == graphics.stateConfiguration){
      this.actionConfiguration();
    }
    if (state == graphics.stateTutorial){
      this.actionTutorial();
    }
    
    if (engine.Game.gameState == game.stateResult && state == graphics.stateGame){
      this.actionResult();
    }
    
  }
  
  
  
  void actionMenu(){
    if (key == 'w' && now > 0){
      now--;
    }
    if (key == 's' && now < 2){
      now++;
    }
    if (key == ENTER && state == graphics.stateMenu){
      if (now == 0){
        engine.Game = new game(engine.config[0], engine.config[1], engine.config[2]);
        state = graphics.stateGame;
      }
      if (now == 1){
        state = graphics.stateTutorial;
      }
      if (now == 2){
        state = graphics.stateConfiguration;
      }
    }
  }
  void actionConfiguration(){
    if (key == 'b'){
      state = graphics.stateMenu;
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
        textAlign(BASELINE);
        engine.texting(engine.option[now], 100, 300 + now * 50, -3, determinationMono, 50, 255, 0, 0);
        textAlign(CENTER);
        engine.texting("<   >", 400, 300 + now * 50, -3, determinationMono, 50, 255, 0, 0);
        engine.texting(engine.config[now], 400, 300 + now * 50, -3, determinationMono, 50, 255, 0, 0);
        textAlign(BASELINE);
        stroke(255, 0, 0);
        line(100, 305 + 50 * now, engine.underline[now], 305 + 50 * now);
      }
    }
    
    if (key == 'd'){
      if (engine.config[now] < this.max[now]){
        engine.config[now]++;
        textAlign(BASELINE);
        engine.texting(engine.option[now], 100, 300 + now * 50, -3, determinationMono, 50, 0, 255, 0);
        textAlign(CENTER);
        engine.texting("<   >", 400, 300 + now * 50, -3, determinationMono, 50, 0, 255, 0);
        engine.texting(engine.config[now], 400, 300 + now * 50, -3, determinationMono, 50, 0, 255, 0);
        textAlign(BASELINE);
        stroke(0, 255, 0);
        line(100, 305 + 50 * now, engine.underline[now], 305 + 50 * now);
      }
    }
  }
  void actionResult(){
    if (key == 'r'){
      engine.Game = new game(engine.config[0], engine.config[1], engine.config[2]);
      state = graphics.stateGame;
      textAlign(CENTER);
      engine.texting("[R] RESTART", 200, 530, -3, determinationMono, 50, 255, 255, 0);
      textAlign(BASELINE);
    }
    if (key == 'b'){
      state = graphics.stateMenu;
      now = 0;
      textAlign(CENTER);
      engine.texting("[B] MENU", 600, 530, -3, determinationMono, 50, 255, 255, 0);
      textAlign(BASELINE);
    }
  }
  void actionTutorial(){
    if (key == 'b'){
      state = graphics.stateMenu;
      now = 0;
    }
  }
}

class graphics{
  
  //constant
  static final int stateMenu = 0;
  static final int stateTutorial = 1;
  static final int stateConfiguration = 2;
  static final int stateGame = 3;

  game Game = new game(3, 5, 5);
  int[] config = new int[3];
  boolean await = false;
  String[] suffix = new String[3];
  String[] option = new String[3];
  String[] menu = new String[3];
  int[] underline = new int[3];
  color[] ranking = new color[3];
  int frame = 0;
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
    underline[0] = 270;
    underline[1] = 195;
    underline[2] = 220;
    ranking[0] = #FFD700;
    ranking[1] = #C0C0C0;
    ranking[2] = #CD7F32;
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
    background(0);
    this.texting("Safe Landing", 100, 200, 5, determinationMono, 100, 255);
    Mouse.render();
    
    // mouse
    for (int i = 0; i < 3; i++){
      if (i == Mouse.now){
        this.texting(this.menu[i], 100, 400 + i * 50, 3, determinationMono, 50, 255, 255, 0);
      }
      else{
        this.texting(this.menu[i], 100, 400 + i * 50, 0, determinationMono, 50, 255);
      }
    }
    
    
    //stripe effect
    stroke(0);
    strokeWeight(2);
    for (int i = 0; i < height; i += 4){
      line(0, i, width, i);
    }
    
    
  }
  void tutorial(){
    
    background(0);
    textAlign(CENTER);
    this.texting("TUTORIAL", width / 2, 150, 5, determinationMono, 100, 255);
    this.texting("[B] Menu ", width / 2, 550, 3, determinationMono, 50, 255);
    textAlign(BASELINE);
    
    fill(255);
    textFont(determinationMono, 30);
    
    text("1. Try to fall to the ground in the exact time.", 30, 200);
    text("2. Click the corresponding button whenever you", 30, 230);
    text("   want, and your character will fall.", 30, 260);
    text("3. If you land within times, you're fine.", 30, 290);
    text("4. But if you think too long, you lose.", 30, 320);
    text("5. The player whose landing time is the closest to ", 30, 350);
    text("   the given time wins.", 30, 380);
    
    //stripe effect
    stroke(0);
    strokeWeight(2);
    for (int i = 0; i < height; i += 4){
      line(0, i, width, i);
    }
  }
  
  void configuration(){
    
    
    background(0);
    textAlign(CENTER);
    
    this.texting("[B] Menu ", width / 2, 550, 3, determinationMono, 50, 255);
    this.texting("OPTIONS", width / 2, 150, 5, determinationMono, 100, 255);
    
    textFont(determinationMono, 50);
    for (int i = 0; i < 3; i++){
      if (i == Mouse.now){
        
        textAlign(BASELINE);
        this.texting(this.option[i], 100, 300 + i * 50, 3, determinationMono, 50, 255, 255, 0);
        textAlign(CENTER);
        this.texting("<   >", 400, 300 + i * 50, 3, determinationMono, 50, 255, 255, 0);
        this.texting(this.config[i], 400, 300 + i * 50, 3, determinationMono, 50, 255, 255, 0);
        textAlign(BASELINE);
        stroke(255, 255, 0);
        line(100, 305 + 50 * i, this.underline[i], 305 + 50 * i);
      }
      else{
        textAlign(BASELINE);
        this.texting(this.option[i], 100, 300 + i * 50, 0, determinationMono, 50, 255);
        textAlign(CENTER);
        this.texting(this.config[i], 400, 300 + i * 50, 0, determinationMono, 50, 255);
        textAlign(BASELINE);
      }
      
    }
    
    //stripe effect
    stroke(0);
    strokeWeight(2);
    for (int i = 0; i < height; i += 4){
      line(0, i, width, i);
    }
    
  }
  
  void standby(int count){
    this.await = false;
    engine.backgroundGame(0);
    if (count == -1){
      this.texting("Press [T] to get ready!", 140, 300, 5, determinationMono, 50, 255);
    }
    else{
      if (count > 0){
        textAlign(CENTER,CENTER);
        this.texting(int(ceil(count/60.0)) , 400, 300, 10, determinationMono, 300, 255);
        textAlign(BASELINE);
      }
      else{
        textAlign(CENTER,CENTER);
        this.texting("GO!" , 400, 300, 10, determinationMono, 300, 255, 255, 0);
        textAlign(BASELINE);
        this.Game.gameState = game.stateMain;
      }
      
      
    }
    
  }
  
  void backgroundGame(int frame){
    rectMode(CORNERS);
    background(200);
    
    //wall
    stroke(0);
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
      rect(160 + 180 * i, 510, 280 + 180 * i, 565);
      fill(255);
      textFont(determinationMono, 60);
      if (this.Game.playerList[i].finished){
        this.texting(this.Game.playerList[i].result[1] / 60, 160 + 180 * i, 555, 0, determinationMono, 60, 255, 255, 0);
        this.texting(".", 190 + 180 * i, 555, 0, determinationMono, 60, 255, 255, 0);
        this.texting((this.Game.playerList[i].result[1] % 60) * 5 / 3, 200 + 180 * i, 555, 0, determinationMono, 60, 255, 255, 0);
      }
      else{
        this.texting(frame / 60, 160 + 180 * i, 555, 0, determinationMono, 60, 255);
        this.texting(".", 190 + 180 * i, 555, 0, determinationMono, 60, 255);
        this.texting((frame % 60) * 5 / 3, 200 + 180 * i, 555, 0, determinationMono, 60, 255);
      }
    }
    
    //banner
    this.frame++;
    stroke(0);
    fill(0);
    rect(140, 20, 660, 100);
    if ((this.frame / 180) % 2 == 0){
      this.texting("SAFE", 150, 90, 0, determinationMono, 80, 255);
      this.texting("LANDING", 375, 90, 0, determinationMono, 80, 255);
    }else{
      this.texting("GOAL:", 150, 90, 0, determinationMono, 80, 255);
      this.texting( this.config[1], 420, 90, 0, determinationMono, 80, 255, 255, 0);
      this.texting("sec(s)", 520, 90, 0, determinationMono, 40, 255);
    }
    
  }
  
  void result(){
    
    int y = 200;
    int initX = 100;
    if (!this.await){
      
      player[] rank = this.ranking(this.Game.playerList);
      background(0, 100, 150);
      
      this.texting("RESULT", 250, 150, 5, determinationMono, 100, 255);
      textFont(determinationMono, 30);
      
      
      //print the result
      for (int i = 0; i < this.Game.playerCount; i++){
        
        if (this.Game.playerList[rank[i].result[0]].result[1] == 10000){
          fill(255, 0, 0);
          text(i + 1, initX, y);
          text(suffix[i], initX + 15, y);
          text("Player", initX + 70, y);
          text(rank[i].result[0] + 1, initX + 170, y);
          y += 50;
          text("Failed", initX, y); 
        }
        else{
          fill(this.ranking[i]);
          text(i + 1, initX, y);
          text(suffix[i], initX + 15, y);
          text("Player", initX + 70, y);
          text(rank[i].result[0] + 1, initX + 170, y);
          y += 50;
          text(this.Game.playerList[rank[i].result[0]].result[1] / 60, initX, y); 
          text(".", initX + 15, y);
          text((this.Game.playerList[rank[i].result[0]].result[1] % 60) * 5 / 3, initX + 20, y);
          text("sec(s)", initX + 80, y);
        }
        y += 50;
      }
      
      textAlign(CENTER);
      this.texting("[R] RESTART", 200, 530, 3, determinationMono, 50, 255);
      this.texting("[B] MENU", 600, 530, 3, determinationMono, 50, 255);
      textAlign(BASELINE);
      
       //stripe effect
      stroke(0, 100, 150);
      strokeWeight(2);
      for (int i = 0; i < height; i += 4){
        line(0, i, width, i);
      }
        
      
      this.await = true;
    }
    
  }
  
  //default sort() doesn't support custom datatype, so yeah
  player[] ranking(player[] list){
    int[] test = new int[3];
    player temp;
    for (int i = 0; i < this.Game.playerCount; i++){
      if (list[i].result[1] > this.Game.time){
        list[i].result[1] = 10000;
      }
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
  
  // custom text for simplicity
  void texting(String text, int x, int y, int shift, PFont font, int size, int R, int G, int B){
    textFont(font, size);  
    fill(150);
    text(text, x - shift, y + shift);
    fill(R, G, B);
    text(text, x, y);
  }
  void texting(String text, int x, int y, int shift, PFont font, int size, int fill){
    textFont(font, size);
    fill(150);
    text(text, x - shift, y + shift);
    fill(fill);
    text(text, x, y);
  }
  
  void texting(int text, int x, int y, int shift, PFont font, int size, int R, int G, int B){
    textFont(font, size);  
    fill(150);
    text(text, x - shift, y + shift);
    fill(R, G, B);
    text(text, x, y);
  }
  void texting(int text, int x, int y, int shift, PFont font, int size, int fill){
    textFont(font, size);
    fill(150);
    text(text, x - shift, y + shift);
    fill(fill);
    text(text, x, y);
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
  boolean update(int frame){
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
        this.result[1] = frame;
        this.finished = true;
        this.fall = false;
        return true;
      }
    }
    stroke(0);
    fill(this.colour[0], this.colour[1], this.colour[2]);
    
    ellipseMode(CENTER);
    ellipse(this.pos[0], this.pos[1], 20, 20);
    
    if (!this.fall && !this.finished){
    fill(100);
    rectMode(CORNER);
    rect(pos[0] - 60, 160, 120, 20);
    engine.texting("Press [ ]!!", this.pos[0] - 40, 175, 0, determinationMono, 15, 255);
    engine.texting(str(char(this.dic[this.result[0]] - 32)), this.pos[0] + 13, 175, 0, determinationMono, 15, 255, 255, 0);
    }
    
    return false;
  }
}

class game{
  
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
  
  // constructor
  game(int player, int time, int acceleration){
    this.gameState = stateStandby;
    this.frame = 0;
    this.playerCount = player;
    this.time = 60 * time;
    this.finishedCount = 0;
    
    
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
    
    if (keyPressed && key == 't' || this.countdown < 180){
      engine.standby(this.countdown);
      this.countdown--;
    }
    else{
      engine.standby(-1);
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
    engine.backgroundGame(this.frame);
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
