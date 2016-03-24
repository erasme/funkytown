class FunFiducial extends AbstractFiducial {

  float cosPct;
  float xoff=0.0;
  int i;

  FunFiducial(int id, MidiBus midi, int midiPitchOn, int midiPitchOff, Color mainColor) {
    super(id, midi, midiPitchOn,midiPitchOff, mainColor);
        this.isParticleReceiver = true;

    //this.name = "FunFiducial";
  }

  void init() {
    x = 300;
    y = 100;
  }

  void show() {
    super.show();
  }

  void hide() {
    super.hide();
  }

  void draw () {


    cosPct = .5 + cos((float)millis() / 100.0f) * .5;

    int radius       = 25;
    float lineLength = (20 + easedCumPct * 50);

    i++;
    pushMatrix();
    translate(x, y);
    stroke(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct,  mainColor.getBlue()*easedActivePct);

    fill(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct,  mainColor.getBlue()*easedActivePct);
    ellipse(0,0,lineLength/2*easedActivePct,lineLength/2*easedActivePct);
    rotate(rotation);
    pushMatrix();
    rotate(radians(i*1));
    stroke(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct,  mainColor.getBlue()*easedActivePct, 225 * easedActivePct);
    strokeWeight(3*easedActivePct);
    line(radius, 0, lineLength, 0);
    rotate(radians(i*1.2));
    line(radius, 0, lineLength, 0);
    rotate(radians(i*-0.5));
    line(radius, 0, lineLength, 0);
    rotate(radians(i*-1));
    line(radius, 0, lineLength, 0);
    rotate(radians(i*-3));
    line(radius, 0, lineLength, 0);
    rotate(radians(i*-0.5));
    line(radius, 0, lineLength, 0);
    rotate(radians(i*-0.7));
    line(radius, 0, lineLength, 0);
    popMatrix();

    popMatrix();
  }
}