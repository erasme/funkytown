class AbstractFiducial {

  int       id;
  boolean   visible;

  int       x;
  int       y;
  int       rotation;
  
  PImage    debugImage;

  AbstractFiducial (int id) {
    this.id        = id;
    this.visible   = false;
    this.x         = 0;
    this.y         = 0;
    this.rotation  = 0;
    
   debugImage = loadImage("img.jpg");

    
  }

  void init() {
  }

  void show() {
    this.visible = true;
  }

  void hide() {
    this.visible = true;
  }
  
  void draw () {
    
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