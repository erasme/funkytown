class FunFiducial extends AbstractFiducial {

  float cosPct;


  FunFiducial(int id) {
    super(id);
    this.isLineConnected = true;
    this.isParticleSender = false;
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

    fill(255, 0, 0);
    rect(0, 0, 10, 10);
    ellipse(0, 0,  50 * cosPct, 50 * cosPct);

    popMatrix();
  }
}