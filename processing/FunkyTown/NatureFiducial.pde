class NatureFiducial extends AbstractFiducial {


  int a;
  PImage nature;

  NatureFiducial(int id, MidiBus midi, int midiPitchOn, int midiPitchOff, Color mainColor) {
    super(id, midi, midiPitchOn, midiPitchOff, mainColor);
    this.isLineConnected = false;
    this.isParticleReceiver = true;

    nature = loadImage("nature.png");
    nature.resize(75, 75);
  }

  void init() {
  }

  void show() {
    super.show();
  }

  void hide() {
    super.hide();
  }

  void draw () {

    fill(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct, mainColor.getBlue()*easedActivePct);
    stroke(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct, mainColor.getBlue()*easedActivePct);

    pushMatrix();//pour la rotation
    translate(x, y);
    rotate(rotation);

    pushMatrix();
    translate(-nature.width / 2, -nature.height/2);
    tint(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct, mainColor.getBlue()*easedActivePct, 255 * easedActivePct);
    image(nature, 0, 0);
    popMatrix();


    pushMatrix();
    rotate(0.01*a++);

    strokeWeight(0);

    int total = (int)(cumulativePct * 10 );
   // println("---------------------" +cumulativePct);
    for (int i= 0; i<total; i++) {
      rotate(TWO_PI/total);
      ellipse(50 *easedActivePct, 0, 5, 5);
    }

    popMatrix();

    pushMatrix();
    //translate(width/2, height/2);
    rotate(0.001*a++);
    total = (int)(cumulativePct * 20 );

    for (int i= 0; i<total; i++) {
      rotate(TWO_PI/total);
      ellipse(70 *easedActivePct, 0, 5, 5);
    }

    popMatrix();

    popMatrix();
  }
}