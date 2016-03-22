class FiducialManager {

  ArrayList<AbstractFiducial> fiducials;

  boolean bHasChanged = false;

  FiducialManager() {
  }

  void setup() {
    fiducials = new ArrayList<AbstractFiducial>();
    fiducials.add(new FunFiducial(0));
    fiducials.add(new NatureFiducial(1));
    fiducials.add(new StrictFiducial(2));
    //fiducials.add(new StrictFiducial(2));
    fiducials.add(new MindFiducial(7));

    for (int i=0; i<fiducials.size(); i++) {
      fiducials.get(i).init();
    }
  }

  void draw() {

    for (int i=0; i<fiducials.size(); i++) {

      fiducials.get(i).update();

      if (fiducials.get(i).visible)
        fiducials.get(i).draw();
    }

    bHasChanged = true;
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

    if (x == -100.0 && y == -100.0 && rotation == 360.0 )
      return;

    if (added == 0) {
      onUpdateFiducialHandler(id, (int)x, (int)y, (int)rotation);
    } else if (added == 2) {
      onRemoveFiducialHandler(id);
    } else {
      onNewFiducialHandler(id);
    }
  }

  void onNewFiducialHandler(int id) {
    fiducials.get(getFiducialIndexByID(id)).show();
  }

  void onRemoveFiducialHandler(int id) {     
    fiducials.get(getFiducialIndexByID(id)).hide();
  }


  void onUpdateFiducialHandler(int id, int x, int y, int rotation) {

    AbstractFiducial fiducial = fiducials.get(getFiducialIndexByID(id));

    fiducial.x         = x;
    fiducial.y         = y;
    fiducial.rotation  = rotation;
  }

  ArrayList getConnectedFiducials() {

    ArrayList<AbstractFiducial> connecteds = new ArrayList<AbstractFiducial>();
    for (int i=0; i<fiducials.size(); i++) {
      if (fiducials.get(i).visible) 
        connecteds.add(fiducials.get(i));
    }
    return connecteds;
  }

  void onRemovedFiducialHandler(int id) {
    fiducials.get(getFiducialIndexByID(id)).hide();
  }
}