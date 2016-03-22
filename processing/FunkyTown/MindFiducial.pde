class MindFiducial extends AbstractFiducial {
  int i;
  int counter;

  MindFiducial(int id, MidiBus midi, int midiPitchOn, int midiPitchOff) {
    super(id, midi, midiPitchOn,midiPitchOff);
  }

  void init() {
    x = 300;
    y = 200;
    i=0;
  }

  void show() {
    super.show();
  }

  void hide() {
    super.hide();
  }

  void draw () {
    pushMatrix();
    translate(x, y);
    rotate(rotation);

    //?
    pushMatrix();
    
    
    
    i++;
    //rotate(radians(i*-1));
    //fill(#12FFB2);
    fill(0.0*easedActivePct, 255.0*easedActivePct, 255.0*easedActivePct, 50.0*easedActivePct);
    // noFill();
    stroke(8*easedActivePct, 247*easedActivePct, 184*easedActivePct);
    strokeWeight(4*easedActivePct);
    rectMode(CENTER);
    ellipse(0, 0, 15, 15);

    pushMatrix();
    rotate(radians(i*2));
    rect(0, 0, 70, 70);
    popMatrix();

    pushMatrix();
    rect(0, 0, 25, 25);
    rotate(radians(i*10));
    popMatrix();

    pushMatrix();
    rect(0, 0, 70, 70);
    rotate(radians(i*10));
    popMatrix();
    
    popMatrix();

    popMatrix();

    fill(255, 255);
  }
}