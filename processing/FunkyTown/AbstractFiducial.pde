class AbstractFiducial {

  int       id;
  String    name;
  boolean   visible;

  int       x;
  int       y;
  float     rotation;

  PImage    debugImage;

  boolean   isLineConnected;
  boolean   isParticleSender;
  boolean   isParticleReceiver;

  int       removeDelay;
  int       countToRemove;

  MidiBus   midiOut;
  int       midiChannel;
  int       midiPitchOn, midiPitchOff;

  Ani       pctAni;

  float     cumulativePct, easedCumPct;
  float     easedActivePct;

  AbstractFiducial (int id, MidiBus midi, int midiPitchOn, int midiPitchOff) {

    this.id              = id;
    this.midiOut         = midi;
    this.visible         = false;
    this.x               = 0;
    this.y               = 0;
    this.rotation        = 0;
    this.isLineConnected = false;
    this.countToRemove   = -1;
    this.removeDelay     = 20;
    this.cumulativePct   = 0.0f;
    this.easedCumPct     = 0.0f;
    this.name            = this.getClass().getSimpleName();
    this.easedActivePct  = 0.0f;
    this.midiPitchOn      = midiPitchOn;
    this.midiPitchOff      = midiPitchOff;
    this.midiChannel    = 1;
  }

  void init() {
  }

  void show() {
      Ani.to(this, 1.5, "easedActivePct", 1.0, Ani.QUAD_IN);

    if (!this.visible) {
      midiOut.sendNoteOn(midiChannel, midiPitchOn, 127);
      println("send " + midiPitchOn);
      this.countToRemove   = -1;
    }  
    this.visible         = true;
  }

  void hide() {
    countToRemove = 0;
  }

  void remove() {
    if (this.visible) {
      this.visible = false;
      midiOut.sendNoteOn(midiChannel, midiPitchOff, 127);
      //println("removed");
      println("send off ! " + midiChannel +" - " + midiPitchOff);
    }
  }

  void update() {

    if (countToRemove >= 0 && countToRemove <= removeDelay ) 
      countToRemove++;

    if (countToRemove > removeDelay && this.visible)
      pctAni = new Ani(this, 1.5, "easedActivePct", 0.0, Ani.QUAD_OUT, "onEnd:remove");

    //if(this.visible)
    //println((int)(easedActivePct * 127.0));
    int value = (int)(easedActivePct * 127.0);
    if(this.visible)
      midi.sendControllerChange(1, 1, value);
    
  }

  void setCumulativePct(float pct) {


    if (pct != this.cumulativePct ) {
      pctAni = new Ani(this, 1.5, "easedCumPct", pct, Ani.QUAD_IN_OUT);
    }
    this.cumulativePct = pct;
  }


  void draw () {
  }

  float getNormalizedDistanceTo (AbstractFiducial target) {
    PVector a     = new PVector(x, y);
    PVector b     = new PVector(target.x, target.y);
    PVector diff  = PVector.sub(a, b);
    float length  = diff.mag();

    return length / (float)width;
  }

  void debug() {

    pushMatrix();
    translate(x, y);
    rotate(this.rotation);
    fill(255);
    ellipse(0, 0, 100, 100);
    popMatrix();
  }
}