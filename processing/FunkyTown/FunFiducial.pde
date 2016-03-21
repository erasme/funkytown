class FunFiducial extends AbstractFiducial {

  float cosPct;
float xoff=0.0;

  FunFiducial(int id) {
    super(id);
    this.isLineConnected = true;
    this.isParticleSender = true;
  }

  void init() {

    x = 100;
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


    pushMatrix();
    translate(x, y);



  if(focused){
  xoff = xoff + .01;
  float  xoff2 = xoff + xoff;
  noFill();
  stroke(255, 15);
  ellipseMode(CENTER);
  ellipse(width/2, height/2, 500*noise(xoff2), 500*noise(xoff));
  if (keyPressed) {
    saveFrame("wallpaper-####.tif");
  }
  }


  //  fill(255, 0, 0);
  //rect(0, 0, 10, 10);
   // ellipse(0, 0,  50 * cosPct, 50 * cosPct);

    popMatrix();
  }
}