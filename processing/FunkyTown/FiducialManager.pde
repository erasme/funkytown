class FiducialManager {

  ArrayList<AbstractFiducial> fiducials;

  FiducialManager() {
  }

  void setup() {
    fiducials = new ArrayList<AbstractFiducial>();
    fiducials.add(new FunFiducial(0));
    fiducials.add(new NatureFiducial(1));
    fiducials.add(new StrictFiducial(2));
     fiducials.add(new MindFiducial(3));

    for (int i=0; i<fiducials.size(); i++) {
      fiducials.get(i).init();
    }
  }

  void draw() {

    for (int i=0; i<fiducials.size(); i++) {
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
    int x        =   msg.get(2).intValue();
    int y        =   msg.get(3).intValue();
    int rotation =   msg.get(4).intValue();

    if (added == 1) {
      onNewFiducialHandler(id);
    } 
    onUpdateFiducialHandler(id, x, y, rotation);
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

  ArrayList getConnectedFiducials() {

    ArrayList<AbstractFiducial> connecteds = new ArrayList<AbstractFiducial>();
    for (int i=0; i<fiducials.size(); i++) {
      if(fiducials.get(i).visible) 
        connecteds.add(fiducials.get(i));
    }
    return connecteds;
  }

  void onRemovedFiducialHandler(int id) {
    fiducials.get(getFiducialIndexByID(id)).hide();
  }
}