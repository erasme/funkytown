class MindFiducial extends AbstractFiducial {

  MindFiducial(int id) {
    super(id);
  }

  void init() {
    
    x = 200;
    y = 200;
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
    
    fill(255, 0, 0);
    rect(0, 0, 10, 10);
    ellipse(0, 0, 100, 100);

    popMatrix();
  }
}