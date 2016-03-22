class AbstractFiducial {

  int       id;
  String    name;
  boolean   visible;
  
  int       x;
  int       y;
  int       rotation;

  PImage    debugImage;

  boolean   isLineConnected;
  boolean   isParticleSender;
  boolean   isParticleReceiver;

  int       removeDelay;
  int       countToRemove;

  MidiBus   midiOut;
  int       midiChannel;
  int       midiPitch;
  
  float     cumulativePct;

  AbstractFiducial (int id, MidiBus midi) {

    this.id              = id;
    this.midiOut         = midi;
    this.visible         = true;
    this.x               = 0;
    this.y               = 0;
    this.rotation        = 0;
    this.isLineConnected = false;
    this.countToRemove   = -1;
    this.removeDelay     = 20;
    this.cumulativePct   = 0.0f;

  }

  void init() {
  }

  void show() {
    this.visible         = true;
    this.countToRemove   = -1;
    midiOut.sendNoteOn(midiChannel, 0, 0);
  }

  void hide() {
    this.countToRemove   = 0;
  }

  void remove() {
    this.visible = false;
    midiOut.sendNoteOff(midiChannel, 0, 0);
  }

  void update() {

    if (countToRemove >= 0 ) 
      countToRemove++;

    if (countToRemove >= removeDelay ) 
      remove();
  }
  
  void setCumulativePct(float pct) {
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