class Cactus {
  PImage cactusImage;
  PImage cactusChange;
  PImage cactusSmall;
  PImage pail;
  PImage pailBlock;
  int cactusHealth = 10;
  boolean watered = false;
  boolean isDead = false;
  boolean chosen = false;
  int startX;
  int startY;
  float yPos;

  Cactus(PImage cactusImage, PImage cactusChange, int startX, int startY, PImage cactusSmall) {
    this.cactusImage = cactusImage;
    this.cactusChange = cactusChange;
    this.startX = startX;
    this.startY = startY;
    this.cactusSmall = cactusSmall;
    pail = loadImage("pail.png");
    pailBlock = loadImage("pailBlock.png");
  }

  void startPos() {
    imageMode(CENTER);
    image(cactusSmall, startX, startY);
  }


  void display() {
    yPos = map(cactusHealth, 0, 20, height-80, height-160 );
    image(cactusImage, width/2, height/2);
    image(pail, width-60, height-80, 80, 115);
    image(pailBlock, width-60, yPos, 115, 115);
  }


  void update() {
    if (watered == true) { //still needs to adjust rate
      if (frameCount % 2 == 1) {
        cactusHealth ++;
      }
    } else if (cactusHealth > 0 && player.manDies == false) {
      if (frameCount % 20 == 1) {
        cactusHealth --;
      }
    }

    println("cactus health" + cactusHealth);
    if (mousePressed && (dist(mouseX, mouseY, width-60, height-80) < 40)) {
      watered = true;
    } else {
      watered = false;
    }
    if (cactusHealth >= 20) {
      image(cactusChange, width/2, height/2);
    }
    if (cactusHealth == 0) {
      isDead = true;
    }
    if (isDead) {
      imageMode(CORNER);
      cactusDie.play();
      youDie.stop();
      image(cactusDie, 0, 0);
    }
    println("Dead?" + isDead);
  }
  void restart() {
    cactusHealth = 10;
    cactusDie.stop();
    youDie.stop();
  }
}