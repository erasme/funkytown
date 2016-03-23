class FiducialManager {

  ArrayList<AbstractFiducial> fiducials;
  ArrayList<AbstractFiducial> connecteds;

  ArrayList<Ani> aniChannels;
  ArrayList<Float> cumulativeChannels;

  MidiBus midi;

  float ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7 = 0;

  FiducialManager() {

    fiducials           = new ArrayList<AbstractFiducial>();
    connecteds          = new ArrayList<AbstractFiducial>();
    cumulativeChannels  = new ArrayList<Float>();
    aniChannels         = new ArrayList<Ani>();
  }

  void setup(MidiBus midi) {

    this.midi = midi;

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

    fiducials.add(new NatureFiducial    (12, midi, 1, 8));
    fiducials.add(new NatureFiducial    (14, midi, 1, 8));
    fiducials.add(new NatureFiducial    (18, midi, 1, 8));
    fiducials.add(new NatureFiducial    (13, midi, 1, 8));
    fiducials.add(new NatureFiducial    (11, midi, 1, 8));

    fiducials.add(new StrictFiducial (7, midi, 2, 8));
    fiducials.add(new StrictFiducial (16, midi, 2, 8));
    fiducials.add(new StrictFiducial (0, midi, 2, 8));
    fiducials.add(new StrictFiducial (6, midi, 2, 8));
    fiducials.add(new StrictFiducial (9, midi, 2, 8));

    fiducials.add(new FunFiducial    (17, midi, 3, 8));
    fiducials.add(new FunFiducial    (18, midi, 3, 8));
    fiducials.add(new FunFiducial    (4, midi, 3, 8));
    fiducials.add(new FunFiducial    (5, midi, 3, 8));

    fiducials.add(new MindFiducial (2, midi, 4, 8));
    fiducials.add(new MindFiducial (1, midi, 4, 8));



    for (int i=0; i<fiducials.size(); i++) {
      fiducials.get(i).init();
    }

    for (int i=0; i<8; i++) {
      cumulativeChannels.add(new Float(0));
      aniChannels.add(new Ani(this, 1.5, "ch"+i, 0.0, Ani.QUAD_OUT));
    }
  }

  void update() {

    connecteds = getConnectedFiducials();
    updateConnectedsPct();
    updateCumulativeChannels();

    //midi.sendControllerChange(1, 1, (int)(ch0 * 127));

   midi.sendControllerChange(1, 2, getMidiValue(ch1));
    midi.sendControllerChange(1, 3, getMidiValue(ch2));
    midi.sendControllerChange(1, 4, getMidiValue(ch3));
    midi.sendControllerChange(1, 5, getMidiValue(ch4));
    midi.sendControllerChange(1, 6, getMidiValue(ch5));
    midi.sendControllerChange(1, 7, getMidiValue(ch6));
    midi.sendControllerChange(1, 8, getMidiValue(ch7));



    println(ch0 + " " + ch1 + " " + ch2 + " " + ch3 + " " + ch4 + " " + ch0 + " " + ch0 + " " + ch0 + " ");
  }
  
  int getMidiValue(float pct) {
    if(pct == 0) 
    return 0;
    
    
    return 50 + (int)(pct * 77.0);
    
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

  void updateCumulativeChannels() {

    //println("--");
    for (int i=0; i<8; i++) {
      float pct = getConnectedsChannelsPctFor(i);
      //println(pct);
      // if pct of i is !=, launch tween`
      // println("test " + pct + " - " +   Float.valueOf(cumulativeChannels.get(i)));
      if (pct != cumulativeChannels.get(i)) {
        //println("SEND :" + pct + " - " +   Float.valueOf(cumulativeChannels.get(i)));
        aniChannels.add(i, new Ani(this, 0.5, "ch"+i, pct, Ani.QUAD_OUT));
        //Ani.to(this, 1.0, "ch"+i, pct, Ani.ELASTIC_OUT);
        cumulativeChannels.add(i, new Float(pct));
      }
    }
  }

  float getConnectedsChannelsPctFor(int channel) {

    int result = 0;
    int numConnecteds = 0;

    for (int i=0; i<fiducials.size(); i++) {
      boolean isSame = fiducials.get(i).midiPitchOn == channel;

      if (isSame) {
        result++;
        if (fiducials.get(i).visible)
          numConnecteds++;
      }
    }

    if ( numConnecteds == 0 )
      return 0;

    return (float)numConnecteds / (float)result ;
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