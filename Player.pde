class Player {
  PImage hand;
  boolean pain;
  int mentalHealth = 50;
  boolean healthy = true;
  boolean touched = false;
  boolean manDies;
  boolean soundPlaying;
  PImage hurt;
  float alpha;
  void display() {
    hand = loadImage("hand.png");
    hurt = loadImage("hurt.png");
    imageMode(CENTER);
    tint(255, 255);
    image (hand, mouseX+10, mouseY+40, 80, 101);

    pushMatrix();
    imageMode(CORNER);
    tint(255, alpha);
    image (hurt, 0, 0);
    popMatrix();
    alpha = map(mentalHealth, 50, 0, 0, 255);
  }

  void update() {
    alpha = map(mentalHealth, 50, 0, 0, 255);
    if (touched == true && frameCount % 40 == 1) {
      touched = false;
    }
    if (soundPlaying == true) {
      soundPlaying = false;
    }
    println("mental" +mentalHealth);
    println(touched + "touched");

    if (healthy == true) {
      mentalHealth = 50;
    }
    if (mousePressed && mouseX > 213 && mouseX < 387 && mouseY > 200 && mouseY < 522 && state == 2) {
      touched = true;
      soundPlaying = true;
    }
    if (touched == true) { //replace boundary PX w/ cactus variables. 213 = object.x2
      if (frameCount % 2 == 1) {
        mentalHealth -= 1;
      }
      if (frameCount % 10 == 1) {
        cactusTall.cactusHealth ++;
        cactusSoft.cactusHealth ++;
        cactusLarge.cactusHealth ++;
      }
      //fill( 255, 0, 0, 160);
      //rect( 0, 0, width, height); 
      fill( 255, 0, 0 );
      textFont(domaine);
      textSize(random(30, 60));
      text( "ouch", random(0, 600), random(0, 600));
    } else {
      pain = false;
    }
    if (pain == false) {
      if (mentalHealth < 100) {
        healthy = false;
      }
      if (mentalHealth == 100) {
        healthy = true;
      }
    }
    if (mentalHealth == 0) {
      manDies = true;
    }
    if (manDies) {
      imageMode(CORNER);
      youDie.play();
      cactusDie.stop();
      image(youDie, 0, 0);
    }
  }
  void restart() {
    mentalHealth = 50;
    youDie.stop();
    cactusDie.stop();
  }
}