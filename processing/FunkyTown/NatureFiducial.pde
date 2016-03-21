class NatureFiducial extends AbstractFiducial {

  NatureFiducial(int id) {
    super(id);
    this.isLineConnected = true;
    x = 300;
    y = 100;
    
  }

  void init() {
  }

  void show() {
    super.show();
  }

  void hide() {
    super.hide();
  }

  void draw () {
    
    rect(x,y,30,30);
  }
}