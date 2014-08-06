Player swimmer;
PVector moveScreen = new PVector();
PVector movePlayer = new PVector();
int translateSpeed = 8;
int starfish = 0;
int jellyfishCount = 0;
int blowfishCount = 0;
int HDF = 0;
int goldfish = 0;
int minnow = 0; 
ArrayList<StarFish> starfishes = new ArrayList<StarFish>();
ArrayList<JellyFish> jellyfishes = new ArrayList<JellyFish>(); 
ArrayList<BlowFish> blowfishes = new ArrayList<BlowFish>(); 
ArrayList<HandsomeDragonFish> hdfishes = new ArrayList<HandsomeDragonFish>();
ArrayList<GoldFish> goldfishes = new ArrayList<GoldFish>(); 
ArrayList<Minnow> minnows = new ArrayList<Minnow>(); 
//--------------Henry's code
boolean gameEnd = true;
int HDFP = 2000;
int starfishP=500;
int minnowP=250;
int goldfishP=100;
int earned;
//state booleans
boolean begin = true;
boolean start =false;
boolean end = false;
boolean last = false;
boolean instruct = false;
//health var
int yHealth=300;
void setup() {
  // make background
  //generate a group of fish 
  size(800, 450);
  background(153, 204, 255);
  swimmer = new Player(100, 100, 6, loadImage("Swimmer.png"));
  
  for (int i = 0; i < 40; i++) {
    goldfishes.add(new GoldFish((int)(random(900, 9000)), (int)(random(20, 430)), 2, loadImage("Goldfish.png")));
    minnows.add(new Minnow((int)(random(900, 9000)), (int)(random(30, 420)), 2, loadImage("minnows.png")));
  }

  for (int i = 0; i < 25; i++) {  
    jellyfishes.add(new JellyFish((int)(random(900, 9000)), (int)(random(20, 420)), 2, loadImage("Jellyfish.png")));
  }

  for(int i = 0; i <17; i++) {
    blowfishes.add(new BlowFish((int)(random(900, 9000)), (int)(random(30, 430)), 3, loadImage("Blowfish.png")));
  }
  for (int i = 0; i < 15; i++) {
    starfishes.add(new StarFish((int)(random(900, 9000)), (int)(random(400, 430)), 2, loadImage("Starfish.png")));
  }    

  for (int i = 0; i < 3; i++) {
    hdfishes.add(new HandsomeDragonFish((int)(random(900, 9000)), (int)(random(20, 430)), 4, loadImage("HSDF.png")));
  }
}
void draw() {
  if (begin==true) {
    image(loadImage("startscreen.png"), 0, 0);
    Button next = new Button(125, 350, 150, 50, "Start", 750, 400, 10);
    next.display();
    next.mouseClicked();
    if (next.clicked == true) {
      begin = false;
      start = true;
    }
    Button instruction = new Button(50, 275, 300, 50, "Instructions", 750, 400, 10);
    instruction.display();
    instruction.mouseClicked();
    if (instruction.clicked == true) {
      begin = false;
      instruct = true;
    }
  }
  else if (instruct == true) {
    image(loadImage("Instructions.png"), 0, 0);
    Button play = new Button(20, 20, 150, 50, "Play", 750, 400, 10);
    play.display();
    play.mouseClicked();
    if (play.clicked == true) {
      instruct = false;
      start = true;
    }
  }
  else if (end == true) {
    size(800, 450);
    background(153, 204, 255);
    fill(255);
    //handsomedragonfish
    image(loadImage("HDF Legend.png"), 25, 50);

    //starfish
    image(loadImage("Starfish Legend.png"), 50, 110);

    //minnow
    image(loadImage("Minnows Legend.png"), 35, 190);

    //goldfish
    image(loadImage("Goldfish Legend.png"), 50, 230);

    displayMoney();
    Button next = new Button(600, 350, 150, 50, "Next", 750, 400, 10);
    next.display();
    next.mouseClicked();
    if (next.clicked == true) {
      end = false;
      last = true;
    }
  }
  else if (start == true) {
    displaySand();
    swimmer.display();
    displayLegend();
    displayHealth();
    //check collisions
    starFishSwimmerCollsion();
    jellyFishSwimmerCollsion();
    blowFishSwimmerCollsion(); 
    hdFishSwimmerCollsion();
    goldFishSwimmerCollsion();
    minnowSwimmerCollsion();

    displayHDF();
    displayStarFish();
    displayJellyFish();
    displayBlowFish();
    displayMinnow();
    displayGoldFish();
  }
  else if (last == true) {
    //background(0);
    if (earned >= 50000) { 
      image(loadImage("Congrats.png"), 0, 0);
      textSize(40);
      text("UC MIT", 300, 225);
    }
    else if (earned >= 25000) {
      image(loadImage("Congrats.png"), 0, 0);
      textSize(40);
      text("UC Harvard", 300, 225);
    }
    else if (earned >= 12500) {
      image(loadImage("Congrats.png"), 0, 0);
      textSize(40);
      text("UC Stanford", 300, 225);
    }
    else if (earned >= 6250) {
      image(loadImage("Congrats.png"), 0, 0);
      textSize(40);
      text("UC Ocean Ave.", 300, 225);
    }
    else {
      image(loadImage("Failure.png"), 0, 0);
      textSize(40);
      text("You've earned", 250, 225);
      text("your Masters", 250, 275);
      text("degree at", 250, 325);
      text("UC McDonald's!", 250, 375);
    }
  }
}

void displayGoldFish() {
  for (int i = goldfishes.size()-1; i>=0; i--) {
    GoldFish temp = goldfishes.get(i);
    if (temp.xPos < 50) {
      goldfishes.remove(i);
      goldfishes.add(new GoldFish((int)(random(900, 9000)), (int)(random(20, 430)), 2, loadImage("Goldfish.png")));
    } 
    else {
      temp.display();
    }
  }
}

void displayMinnow() {
  for (int i = minnows.size()-1; i>=0; i--) {
    Minnow temp = minnows.get(i);
    if (temp.xPos < 50) {
      minnows.remove(i);
      minnows.add(new Minnow((int)(random(900, 9000)), (int)(random(30, 420)), 1, loadImage("minnows.png")));
    } 
    else {
      temp.display();
    }
  }
}

void displayBlowFish() {
  for (int i = blowfishes.size()-1; i>=0; i--) {
    BlowFish temp = blowfishes.get(i);
    if (temp.xPos < 50) {
      blowfishes.remove(i);
      blowfishes.add(new BlowFish((int)(random(900, 9000)), (int)(random(30, 430)), 3, loadImage("Blowfish.png")));
    } 
    else {
      temp.display();
    }
  }
}

void displayJellyFish() {
  for (int i = jellyfishes.size()-1; i>=0; i--) {
    JellyFish temp = jellyfishes.get(i);
    if (temp.xPos < 50) {

      jellyfishes.remove(i);
      jellyfishes.add(new JellyFish((int)(random(900, 9000)), (int)(random(20, 420)), 3, loadImage("Jellyfish.png")));
    } 
    else {
      temp.display();
    }
  }
}

void displayStarFish() {
  for (int i = starfishes.size()-1; i>=0; i--) {
    StarFish temp = starfishes.get(i);
    if (temp.xPos < 50) {
      starfishes.remove(i);
      starfishes.add(new StarFish((int)(random(900, 9000)), (int)(random(400, 430)), 0, loadImage("Starfish.png")));
    } 
    else {
      temp.display();
    }
  }
}

void displayHDF() {
  for (int i = hdfishes.size()-1; i>=0; i--) {
    HandsomeDragonFish temp = hdfishes.get(i);
    if (temp.xPos < 50) {
      hdfishes.remove(i);
      hdfishes.add(new HandsomeDragonFish((int)(random(900, 9000)), (int)(random(20, 430)), 4, loadImage("HSDF.png")));
    }
    else {
      temp.display();
    }
  }
}

void displayLegend() {
  image(loadImage("Starfish.png"), 425, 0);
  fill(0);
  textSize(20);
  text(starfish, 475, 25);
  image(loadImage("Goldfish.png"), 500, 0);
  text(goldfish, 550, 25);
  image(loadImage("HSDF.png"), 573, 0);
  text(HDF, 650, 25);
  image(loadImage("minnows.png"), 675, 11);
  text(minnow, 775, 25);
}

void displaySand() {
  noStroke();
  fill(0);
  fill(184, 134, 11);
  rect(0, 425, 800, 50);
}
void displayMoney() {
  fill(0);
  textSize(20);
  text(HDF+"", 140, 87);
  text(starfish+"", 140, 147);
  text(minnow+"", 140, 207);
  text(goldfish+"", 140, 267);
  text("X", 190, 87);
  text("X", 190, 147);
  text("X", 190, 207);
  text("X", 190, 267);
  text("$"+HDFP, 240, 87);
  text("$"+starfishP, 240, 147);
  text("$"+minnowP, 240, 207);
  text("$"+goldfishP, 240, 267);
  text("=", 310, 87);
  text("=", 310, 147);
  text("=", 310, 207);
  text("=", 310, 267);
  text("$"+HDF*HDFP, 350, 87);
  text("$"+starfish*starfishP, 350, 147);
  text("$"+minnow*minnowP, 350, 207);
  text("$"+goldfish*goldfishP, 350, 267);
  text("----------------", 340, 300);
  textSize(30);
  text("+", 340, 290);
  text("TOTAL:", 230, 320);
  earned = (HDF*HDFP + starfish*starfishP + minnow*minnowP + goldfish*goldfishP);
  text("$"+ earned, 350, 320);
}
void displayHealth() {
  stroke(0);
  strokeWeight(2);
  fill(160, 160, 160);
  rect(50, 10, 300, 20, 10, 10, 10, 10);  
  if (yHealth > 0) {
    //fill(210,69,69);
    fill(0, 139, 139);
    //stroke(1);
    strokeWeight(2);
    rect(50, 10, yHealth, 20, 10, 10, 10, 10);
  }
  else {
    start = false;
    end = true;
  }
  fill(0);
  strokeWeight(1);
  text("OXYGEN", 60, 27);
}
void starFishSwimmerCollsion() {
  for (int i = starfishes.size()-1; i >= 0; i--) {
    StarFish temp = starfishes.get(i);
    if (temp.collision(swimmer.xPos, swimmer.yPos) == true) {
      starfishes.remove(i);
      starfish++;
      starfishes.add(new StarFish((int)(random(900, 9000)), (int)(random(400, 430)), 0, loadImage("Starfish.png")));
    }
  }
}
void jellyFishSwimmerCollsion() {
  for (int i = jellyfishes.size()-1; i>=0; i--) {
    JellyFish temp = jellyfishes.get(i);
    if (temp.collision(swimmer.xPos, swimmer.yPos) == true) {
      jellyfishes.remove(i);
      jellyfishCount++;
      yHealth-= 25;
      jellyfishes.add(new JellyFish((int)(random(900, 9000)), (int)(random(20, 420)), 3, loadImage("Jellyfish.png")));
    }
  }
}
void blowFishSwimmerCollsion() {
  for (int i = blowfishes.size()-1; i >=0; i--) {
    BlowFish temp = blowfishes.get(i);
    if (temp.collision(swimmer.xPos, swimmer.yPos) == true) {
      blowfishes.remove(i);
      blowfishCount++;
      yHealth-= 50;
      blowfishes.add(new BlowFish((int)(random(900, 9000)), (int)(random(30, 430)), 3, loadImage("Blowfish.png")));
    }
  }
}
void hdFishSwimmerCollsion() {
  for (int i = hdfishes.size()-1; i >=0; i--) {
    HandsomeDragonFish temp = hdfishes.get(i);
    if (temp.collision(swimmer.xPos, swimmer.yPos) == true) {
      hdfishes.remove(i);
      HDF++;
      hdfishes.add(new HandsomeDragonFish((int)(random(900, 9000)), (int)(random(20, 430)), 4, loadImage("HSDF.png")));
    }
  }
}
void goldFishSwimmerCollsion() {
  for (int i = goldfishes.size()-1; i>=0; i--) {
    GoldFish temp = goldfishes.get(i);
    if (temp.collision(swimmer.xPos, swimmer.yPos) == true) {
      goldfishes.remove(i);
      goldfish++;
      goldfishes.add(new GoldFish((int)(random(900, 9000)), (int)(random(20, 430)), 2, loadImage("Goldfish.png")));
    }
  }
}
void minnowSwimmerCollsion() {
  for (int i = minnows.size()-1; i>=0; i--) {
    Minnow temp = minnows.get(i);
    if (temp.collision(swimmer.xPos, swimmer.yPos) == true) {
      minnows.remove(i);
      minnow++;
      minnows.add(new Minnow((int)(random(900, 9000)), (int)(random(30, 420)), 1, loadImage("minnows.png")));
    }
  }
}
//-----------------PLAYER CLASS------------------
class Player {
  int xPos;
  int yPos;
  int speed;
  //temp vars
  int side = 55;
  PImage playerImage;
  int w;
  int h;

  Player(int x, int y, int fast, PImage img) {
    xPos = x;
    yPos = y;
    speed = fast;
    playerImage = img;
    w = img.width;
    h = img.height;
  }

  void move() {
    if (keyPressed == true) {
      if (keyCode == UP) {
        moveUp();
      }   

      if (keyCode == DOWN) {
        moveDown();
      }

      if (keyCode == LEFT) {
        moveLeft();
      }

      if (keyCode == RIGHT) {
        moveRight();
      }
    }
  }

  void moveRight() {
    if (xPos < width - w) {
      xPos += speed;
    } 
    else {
      xPos = width - w;
    }
  }

  void moveLeft() {
    if (xPos > 0) xPos -= speed;
  }

  void moveUp() {
    if (yPos > 40) yPos -=  speed;
  }

  void moveDown() {
    if (yPos < height - side) {
      yPos += speed;
    }
    else {
      yPos = height - side;
    }
  }

  void display() {
    background(153, 204, 255);
    noStroke();
    fill(0);
    fill(184, 134, 11);
    rect(0, 425, 800, 50);
    image(playerImage, xPos, yPos);
    move();
  }
}
//--------------------FISH CLASS-----------------------
class Fish {
  int xPos;
  int yPos;
  int speed;
  PImage img;
  int w;
  int h;

  void move() {
    xPos -= speed;
  }

  void display() {
    move();
    image(img, xPos, yPos);
  }

  boolean collision(int x, int y) {
    //if the x position of the object is between the width of this image
    //and the y position is between the height of this image, there is a collision
    return (x > xPos - w - 70 && x < xPos + w - 70 && y > yPos - h - 10 && y < yPos + h - 10 );
  }
}
//----------------STARFISH CLASS-----------------------
class StarFish extends Fish {
  StarFish(int x, int y, int move, PImage starFish) {
    xPos = x;
    yPos = y;
    speed = move;
    img = starFish;
    w = starFish.width;
    h = starFish.height;
  }
}    
//----------------JELLYFISH CLASS-----------------------
class JellyFish extends Fish {
  JellyFish(int x, int y, int move, PImage jellyFish) {
    xPos = x;
    yPos = y;
    speed = move;
    img = jellyFish;
    w = jellyFish.width;
    h = jellyFish.height;
  }
}
//----------------BLOWFISH CLASS-----------------------
class BlowFish extends Fish {
  BlowFish(int x, int y, int move, PImage blowFish) {
    xPos = x;
    yPos = y;
    speed = move;
    img = blowFish;
    w = blowFish.width;
    h = blowFish.height;
  }
}
//----------------HANDSOMEDRAGONFISH CLASS-------------
class HandsomeDragonFish extends Fish {
  HandsomeDragonFish(int x, int y, int move, PImage handsomeDragonFish) {
    xPos = x;
    yPos = y;
    speed = move;
    img = handsomeDragonFish;
    w = handsomeDragonFish.width;
    h = handsomeDragonFish.height;
  }
}
//----------------GOLDFISH CLASS-----------------------
class GoldFish extends Fish {
  GoldFish(int x, int y, int move, PImage goldFish) {
    xPos = x;
    yPos = y;
    speed = move;
    img = goldFish;
    w = goldFish.width;
    h = goldFish.height;
  }
}
//----------------MINNOWSCLASS-----------------------
class Minnow extends Fish {
  Minnow(int x, int y, int move, PImage minnow) {
    xPos = x;
    yPos = y;
    speed = move;
    img = minnow;
    w = minnow.width;
    h = minnow.height;
  }
}
//----------------------BOOTTON CLASS----------------------
class Button {

  int x;
  int y;
  int sx;
  int sy;
  String txt;
  int x2;
  int y2;
  int corner;

  boolean clicked = false;

  Button(int xPos, int yPos, int xSize, int ySize, String ln, int xPos2, int yPos2, int rounded) {
    x   = xPos;
    y   = yPos;
    sx  = xSize;
    sy  = ySize;
    txt = ln;
    x2  = xPos2;
    y2  = yPos2;
    corner = rounded;
  }

  void display() {

    if (mouseX > x && mouseX < x + sx &&
      mouseY > y && mouseY < y + sy) {
      stroke(100);
      fill(153, 204, 255);
    }
    else {
      stroke(100);
      fill(0, 204, 102);
    }
    rect(x, y, sx, sy, corner, corner, corner, corner);
    fill(255);
    textSize(30);
    text(txt, x + sx/4, y + sy - 15);
  }

  void mouseClicked() {
    if (mousePressed && mouseX > x && mouseX < x + sx && mouseY > y && mouseY < y + sy) {
      clicked = true;
    }
  }
}
//-------------------End Game------------------------------

