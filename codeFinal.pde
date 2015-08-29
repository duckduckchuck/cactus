import ddf.minim.*;
Minim minim;
AudioPlayer scream;
import processing.video.*;
Movie youDie;
Movie cactusDie;
PImage cactusTallPic;
PImage cactusSoftPic;
PImage cactusLargePic;
PImage cactusTallPicS;
PImage cactusSoftPicS;
PImage cactusLargePicS;
PImage cactusTallBloomPic;
PImage cactusSoftBloomPic;
PImage cactusLargeBloomPic;
PImage paper;
PImage pail;
PImage pailBlock;
PImage hurt;
PImage intro;
Player player;
Cactus cactusTall;
Cactus cactusSoft;
Cactus cactusLarge;
Cactus cactusTallS;
Cactus cactusSoftS;
Cactus cactusLargeS;
int state = 3;
float yPos;
float xPos;
float hurtOpacity;
boolean restart = false;
PFont domaine;

void setup() {

  size (600, 600);
  domaine = loadFont("domaine-100.vlw");
  youDie = new Movie(this, "youDie.mov");
  cactusDie = new Movie(this, "cactusDie.mov");
  minim = new Minim(this);
  scream = minim.loadFile("scream.mp3");
  pail = loadImage("pail.png");
  pailBlock = loadImage("pailBlock.png");
  paper = loadImage("paper.jpg");
  intro = loadImage("intro.jpg");
  hurt = loadImage("hurt.png");
  cactusTallPic = loadImage("cactusTall.png");
  cactusTallPicS = loadImage("cactusTallS.png");
  cactusTallBloomPic = loadImage("cactusTallBloom.png");
  cactusSoftPic = loadImage("cactusSoft.png");
  cactusSoftPicS = loadImage("cactusSoftS.png");
  cactusSoftBloomPic = loadImage("cactusSoftBloom.png");
  cactusLargePic = loadImage("cactusLarge.png");
  cactusLargePicS = loadImage("cactusLargeS.png");
  cactusLargeBloomPic = loadImage("cactusLargeBloom.png");
  cactusSoft = new Cactus(cactusSoftPic, cactusSoftBloomPic, 440, 365, cactusSoftPicS);
  cactusLarge = new Cactus(cactusLargePic, cactusLargeBloomPic, 300, 200, cactusLargePicS);
  cactusTall = new Cactus(cactusTallPic, cactusTallBloomPic, 165, 380, cactusTallPicS);
  player = new Player();
}

void draw() { 


  pushMatrix();
  imageMode(CENTER);
  tint(255, 255);
  image(paper, width/2, height/2, 600, 600);
  popMatrix();
  if (state == 3) {
    image(intro, width/2, height/2, 600, 600);
  }
  if (state == 0) {

    cactusTall.startPos();
    cactusSoft.startPos();
    cactusLarge.startPos();
    player.display();
    if (mousePressed && mouseX > 117  && mouseX < 218 && mouseY > 320 && mouseY < 500 && state == 0) {
      cactusTall.chosen = true;
      cactusSoft.chosen = false;
      cactusLarge.chosen = false;
      state = 1;
    };
    if (mousePressed && mouseX > 216  && mouseX < 425 && mouseY > 121 && mouseY < 288 && state == 0) {
      cactusTall.chosen = false;
      cactusSoft.chosen = false;
      cactusLarge.chosen = true;
      state = 1;
    };
    if (mousePressed && mouseX > 333  && mouseX < 555 && mouseY > 373 && mouseY < 476 && state == 0) {
      cactusTall.chosen = false;
      cactusSoft.chosen = true;
      cactusLarge.chosen = false;
      state = 1;
    };
  };
  //if (state == 1) {
  //  player.touched = false;
  //  state = 2;
  if (state == 2) {
    if (player.soundPlaying == true) {
      scream.play();
      scream.rewind();
    }


    if (cactusTall.chosen) {
      cactusTall.display();
      cactusTall.update();
      player.display();
      player.update();
    }
    if (cactusSoft.chosen) {
      cactusSoft.display();
      cactusSoft.update();
      player.display();
      player.update();
    }
    if (cactusLarge.chosen) {
      cactusLarge.display();
      cactusLarge.update();
      player.display();
      player.update();
    }
  }
  println("state" + state);
}

void movieEvent(Movie m) {
  if (state == 2) {
    tint(255,255);
    if (m == cactusDie) {
      cactusDie.read();
    } else if (m == youDie) {
      youDie.read(); //if movie is "not availabel" rerun everything - you can make a function for reset. also reset values.
    }
  }
}
void keyPressed() {
  if (key == 'r') {
    cactusTall.restart();
    cactusSoft.restart();
    cactusLarge.restart();
    player.restart();
    state = 0;
  }
}

void mouseClicked() {
  if (state == 3) {
    state = 0;
  }
  if (state == 1) {
    state = 2;
  }
}