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
  int       midiPitch;

  float     cumulativePct, easedCumPct;
  float     easedActivePct;

  AbstractFiducial (int id, MidiBus midi) {

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
  }

  void init() {
  }

  void show() {
    this.visible         = true;
    Ani.to(this, 1.5, "easedActivePct", 1.0, Ani.QUAD_IN);

    this.countToRemove   = -1;
    midiOut.sendNoteOn(midiChannel, 0, 0);
  }

  void hide() {
    Ani.to(this, 1.5, "easedActivePct", 0.0, Ani.QUAD_OUT);
  }

  void remove() {
    this.visible = false;
    midiOut.sendNoteOff(midiChannel, 0, 0);
  }

  void update() {

    //if (countToRemove >= 0 ) 
    //countToRemove++;

    if (easedActivePct <= 0 ) 
      remove();
  }

  void setCumulativePct(float pct) {


    if (pct != this.cumulativePct ) {
      Ani.to(this, 1.5, "easedCumPct", pct, Ani.QUAD_IN_OUT);
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