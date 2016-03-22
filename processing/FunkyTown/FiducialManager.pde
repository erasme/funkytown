class FiducialManager {

  ArrayList<AbstractFiducial> fiducials;
  ArrayList<AbstractFiducial> connecteds;

  FiducialManager() {

    fiducials = new ArrayList<AbstractFiducial>();
    connecteds = new ArrayList<AbstractFiducial>();
  }

  void setup(MidiBus midi) {


    fiducials.add(new FunFiducial    (2, midi));
    fiducials.add(new FunFiducial    (0, midi));
    fiducials.add(new NatureFiducial (1, midi));
    fiducials.add(new StrictFiducial (2, midi));
    fiducials.add(new MindFiducial   (3, midi));
    fiducials.add(new MindFiducial   (7, midi));

    for (int i=0; i<fiducials.size(); i++) {
      fiducials.get(i).init();
    }
  }

  void update() {

    connecteds = getConnectedFiducials();
    updateConnectedsPct();
  }

  void draw() {

    for (int i=0; i<fiducials.size(); i++) {

      fiducials.get(i).update();

      if (fiducials.get(i).visible)
        fiducials.get(i).draw();
    }
  }

  int getFiducialIndexByID(int id) {
    for (int i=0; i<fiducials.size(); i++) {
      if ( fiducials.get(i).id == id) 
        return i;
    }
    return -1;
  }

  void onOscMessageHandler(OscMessage msg) {

    int id       =   msg.get(0).intValue();
    int added    =   msg.get(1).intValue();
    float x        =   abs(msg.get(2).floatValue());
    float y        =   abs(msg.get(3).floatValue());
    float rotation =   abs(msg.get(4).floatValue());

    // don't ask me why why
    if (x == -100.0 && y == -100.0 && rotation == 360.0 )
      return;

    if (added == 1) {
      onNewFiducialHandler(id);
    } else if (added == 0) {
      onUpdateFiducialHandler(id, (int)x, (int)y, (int)rotation);
    } else {
      onRemoveFiducialHandler(id);
    }
  }

  void onNewFiducialHandler(int id) {
    fiducials.get(getFiducialIndexByID(id)).show();
  }

  void onUpdateFiducialHandler(int id, int x, int y, int rotation) {

    AbstractFiducial fiducial = fiducials.get(getFiducialIndexByID(id));
    fiducial.x         = x;
    fiducial.y         = y;
    fiducial.rotation  = rotation;
    
  }

  void onRemoveFiducialHandler(int id) {     
    fiducials.get(getFiducialIndexByID(id)).hide();
  }

  ArrayList getConnectedFiducials() {

    ArrayList<AbstractFiducial> connecteds = new ArrayList<AbstractFiducial>();
    for (int i=0; i<fiducials.size(); i++) {
      if (fiducials.get(i).visible) {
        connecteds.add(fiducials.get(i));
      }
    }
    return connecteds;
  }

  void updateConnectedsPct() {
    for (int i=0; i<fiducials.size(); i++) {
      fiducials.get(i).setCumulativePct(getConnectedsInPctFor(fiducials.get(i).name));
    }
  }

  float getConnectedsInPctFor(String className) {

    int result = 0;
    int numConnecteds = 0;

    for (int i=0; i<fiducials.size(); i++) {
      boolean isSame = fiducials.get(i).name.equals(className);
      if (isSame) {
        result++;
        if (fiducials.get(i).visible)
          numConnecteds++;
      }
    }

    return (float)result / (float)numConnecteds;
  }

  void onRemovedFiducialHandler(int id) {
    fiducials.get(getFiducialIndexByID(id)).hide();
  }
}