class FiducialManager {

  ArrayList<AbstractFiducial> fiducials;
  ArrayList<AbstractFiducial> connecteds;

  FiducialManager() {

    fiducials = new ArrayList<AbstractFiducial>();
    connecteds = new ArrayList<AbstractFiducial>();
  }

  void setup(MidiBus midi) {


    /*
    12 = nature
     14 = natrure
     18 = nature
     13 = nature
     11 = nature 
     
     7 16 0 6 9 strict
     
     Fun
     17 18 4 3 
     8 ?
     
     Mind 
     2 1 
     
     
     
     */

    fiducials.add(new NatureFiducial    (12, midi, 6, 8));
    fiducials.add(new NatureFiducial    (14, midi, 6, 8));
    fiducials.add(new NatureFiducial    (18, midi, 6, 8));
    fiducials.add(new NatureFiducial    (13, midi, 6, 8));
    fiducials.add(new NatureFiducial    (11, midi, 6, 8));

    fiducials.add(new StrictFiducial (7, midi, 6, 8));
    fiducials.add(new StrictFiducial (16, midi, 6, 8));
    fiducials.add(new StrictFiducial (0, midi, 6, 8));
    fiducials.add(new StrictFiducial (6, midi, 6, 8));
    fiducials.add(new StrictFiducial (9, midi, 6, 8));

    fiducials.add(new FunFiducial    (17, midi, 6, 8));
    fiducials.add(new FunFiducial    (18, midi, 6, 8));
    fiducials.add(new FunFiducial    (4, midi, 6, 8));
    fiducials.add(new FunFiducial    (5, midi, 6, 8));

    fiducials.add(new MindFiducial (2, midi, 6, 8));
    fiducials.add(new MindFiducial (1, midi, 6, 8));



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

    int id         =   msg.get(0).intValue();
    int added      =   msg.get(1).intValue();
    float x        =   msg.get(2).floatValue();
    float y        =   msg.get(3).floatValue();
    float rotation =   radians(msg.get(4).floatValue());



    // don't ask me why why
    if (x == -100.0 && y == -100.0 && msg.get(4).floatValue() == 360.0 && added != 1 ) {
      return;
    }


    if (added == 1) {
      onNewFiducialHandler(id);
    } else if (added == 0) {
      onUpdateFiducialHandler(id, (int)x, (int)y, rotation);
    } else {
      onRemoveFiducialHandler(id);
    }
  }

  void onNewFiducialHandler(int id) {
    fiducials.get(getFiducialIndexByID(id)).show();
  }

  void onUpdateFiducialHandler(int id, int x, int y, float rotation) {

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

    if ( numConnecteds == 0 )
      return 0;

    return (float)result / (float)numConnecteds;
  }

  void onRemovedFiducialHandler(int id) {
    fiducials.get(getFiducialIndexByID(id)).hide();
  }
}