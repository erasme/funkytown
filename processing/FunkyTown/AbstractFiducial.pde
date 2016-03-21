class AbstractFiducial {

  int       id;
  boolean   visible;

  int       x;
  int       y;
  int       rotation;
  
  PImage    debugImage;
  
  boolean   isLineConnected;

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
    
  }
  
  float getNormalizedDistanceTo (AbstractFiducial target) {
    PVector a     = new PVector(x,y);
    PVector b     = new PVector(target.x, target.y);
    PVector diff  = PVector.sub(a, b);
    float length  = diff.mag();
    
    return length / (float)width; 
    
  }

  void debug() {
    
    pushMatrix();
    translate(x,y);
    rotate(this.rotation);
    fill(255);
    ellipse(0,0,100,100);
    fill(255);
    image(debugImage,-50,-50);
    popMatrix();
  }
}