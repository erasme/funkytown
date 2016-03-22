class UIPanel {
  PImage energie;
  PImage ame; 
  PImage discipline; 
  PImage esprit;
  int resize;
  UIPanel() {
  }

  void setup() {


    energie = loadImage("energie-01.jpg");
    ame = loadImage("ame-01.jpg");
    discipline = loadImage("discipline-01.jpg");
    esprit = loadImage("esprit-01.jpg");
  }
  void draw() {
    int resize = 100;
    pushMatrix();
    //translate(325, 240);
    noFill();
    rect(width / 2 - 545 / 2 , height / 2 - 395 / 2, 545, 395);
    popMatrix();

    pushMatrix();
    translate(170, 310);
    image(energie, 100, 100);
    energie.resize(resize, resize);
    popMatrix();

    pushMatrix();
    translate(260, -30);
    image(ame, 0, 0);
    ame.resize(resize, resize);
    popMatrix();

    pushMatrix();
    translate(560, 200);
    image(discipline, 10, 10);
    discipline.resize(resize, resize);
    popMatrix();

    pushMatrix();
    translate(-20, 200);
    image(esprit, 0, 0);
    esprit.resize(resize, resize);
    popMatrix();
  }
}