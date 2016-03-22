class AbstractFiducial {

  int       id;
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

    debugImage = loadImage("img.jpg");
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



  void draw () {

    /*
    for (int i=0; i<particles.size(); i++) {
     particles.get(i).resetForce();
     particles.get(i).addAttractionForce(x, y, width*height, .5);
     particles.get(i).addRepulsionForce(cosPct*x, cosPct*y, 100, 1);
     //particles.get(i).damping = (float)mouseX / (float)width;
     
     particles.get(i).addDampingForce();
     particles.get(i).update();
     
     fill(255);
     noStroke();
     ellipse(particles.get(i).pos.x, particles.get(i).pos.y, 10, 10);
     }
     */
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
    fill(255);
    image(debugImage, -50, -50);
    popMatrix();
  }
}