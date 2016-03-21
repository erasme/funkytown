class MindFiducial extends AbstractFiducial {
int counter;

  MindFiducial(int id) {
    super(id);
  }

  void init() {
    x= 300;
    y= 100;
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
    fill(0);
    stroke(255);
    rect(20, 20, 20, 20);
    

    //stroke(0,100);
    //ellipse(0, 0, 100 + 100 * cosPct, 100 + 100*cosPct);
    

    popMatrix();
  }
}