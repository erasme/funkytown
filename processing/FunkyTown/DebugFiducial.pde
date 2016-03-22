class DebugFiducial extends AbstractFiducial {

  DebugFiducial(int id, MidiBus midi) {
    super(id, midi);
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
    debug();
  }
}