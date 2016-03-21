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



  AbstractFiducial (int id) {

    this.id              = id;
    this.visible         = true;
    this.x               = 0;
    this.y               = 0;
    this.rotation        = 0;
    this.isLineConnected = false;

    debugImage = loadImage("img.jpg");
  }

  void init() {
  }

  void show() {
    this.visible = true;
  }

  void hide() {
    this.visible = false;
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