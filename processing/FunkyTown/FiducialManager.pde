class FiducialManager {

  ArrayList<AbstractFiducial> fiducials;
  ArrayList<AbstractFiducial> connecteds;

  ArrayList<Ani>   aniChannels, aniFxs;
  ArrayList<Ani>   aniFx;

  ArrayList<Float> cumulativeChannels;
  ArrayList<Float> cumulativeFxs;


  MidiBus midi;

  float ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7 = 0;
  float fx0, fx1, fx2, fx3, fx4, fx5, fx6, fx7 = 0;


  FiducialManager() {

    fiducials           = new ArrayList<AbstractFiducial>();
    connecteds          = new ArrayList<AbstractFiducial>();
    cumulativeChannels  = new ArrayList<Float>();
    cumulativeFxs       = new ArrayList<Float>();
    aniChannels         = new ArrayList<Ani>();
    aniFxs             = new ArrayList<Ani>();
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

    fiducials.add(new NatureFiducial    (12, midi, 1, 9, new Color(0,255,127)));
    fiducials.add(new NatureFiducial    (14, midi, 1, 9, new Color(0,255,127)));
    fiducials.add(new NatureFiducial    (18, midi, 2, 10, new Color(138,255,191)));
    fiducials.add(new NatureFiducial    (13, midi, 2, 10, new Color(138,255,191)));
   // fiducials.add(new NatureFiducial    (11, midi, 2, 8));

    fiducials.add(new StrictFiducial (7, midi, 3, 11, new Color(234,78,78)));
    fiducials.add(new StrictFiducial (16, midi, 3, 11, new Color(234,78,78)));
    //fiducials.add(new StrictFiducial (0, midi, 3, 8));
    fiducials.add(new StrictFiducial (6, midi, 4, 12,new Color(244,140, 140)));
    fiducials.add(new StrictFiducial (9, midi, 4, 12,new Color(244,140, 140)));

    fiducials.add(new FunFiducial    (17, midi, 5, 13,new Color(255,188, 0)));
    fiducials.add(new FunFiducial    (4, midi, 5, 13,new Color(255,188, 0)));
    fiducials.add(new FunFiducial    (8, midi, 6, 14,new Color(255,242, 0)));
    fiducials.add(new FunFiducial    (5, midi, 6, 14,new Color(255,242, 0)));

    fiducials.add(new MindFiducial (2, midi, 7, 15,new Color(0,255, 255)));
    fiducials.add(new MindFiducial (1, midi, 7, 15,new Color(0,255, 255)));
     fiducials.add(new MindFiducial (20, midi, 0, 16,new Color(0,255, 255)));
    fiducials.add(new MindFiducial (15, midi, 0, 16,new Color(0,255, 255)));



    for (int i=0; i<fiducials.size(); i++) {
      fiducials.get(i).init();
    }

    for (int i=0; i<8; i++) {
      cumulativeChannels.add(new Float(0));
      cumulativeFxs.add(new Float(0));

      aniChannels.add(new Ani(this, 1.5, "ch"+i, 0.0, Ani.QUAD_OUT));
      aniFxs.add(new Ani(this, 1.5, "fx"+i, 0.0, Ani.QUAD_OUT));
    }
  }

  void update() {

    connecteds = getConnectedFiducials();
    updateConnectedsPct();
    updateCumulativeChannels();

  
    midi.sendControllerChange(1, 1, getMidiValue(ch1, 50, 127));
    midi.sendControllerChange(1, 2, getMidiValue(ch2, 50, 127));
    midi.sendControllerChange(1, 3, getMidiValue(ch3, 50, 127));
    midi.sendControllerChange(1, 4, getMidiValue(ch4, 50, 127));
    midi.sendControllerChange(1, 5, getMidiValue(ch5, 50, 127));
    midi.sendControllerChange(1, 6, getMidiValue(ch6, 50, 127));
    midi.sendControllerChange(1, 7, getMidiValue(ch7, 50, 127));
    midi.sendControllerChange(1, 8, getMidiValue(ch0, 50, 127));


    midi.sendControllerChange(1, 9, getMidiValue(fx0, 50, 127));
    midi.sendControllerChange(1, 10, getMidiValue(fx1, 50, 127));
    midi.sendControllerChange(1, 11, getMidiValue(fx2, 50, 127));
    midi.sendControllerChange(1, 12, getMidiValue(fx3, 50, 127));
    midi.sendControllerChange(1, 13, getMidiValue(fx4, 50, 127));
    midi.sendControllerChange(1, 14, getMidiValue(fx5, 50, 127));
    midi.sendControllerChange(1, 15, getMidiValue(fx6, 50, 127));
    
    

   // println(ch0 + " " + ch1 + " " + ch2 + " " + ch3 + " " + ch4 + " " + ch5 + " " + ch6 + " " + ch7 + " ");
  }

  int getMidiValue(float pct, float minStep, float max) {
    
    if (pct == 0) 
      return 0;

    return (int)minStep + (int)(pct * (max - minStep));
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

    for (int i=0; i<8; i++) {
      PVector midiStuff = getConnectedsChannelsPctFor(i);
      float pct     = midiStuff.x;
      float distPct = midiStuff.y;

      // println("test " + pct + " - " +   Float.valueOf(cumulativeChannels.get(i)));
      if (pct != cumulativeChannels.get(i)) {
        aniChannels.add(i, new Ani(this, 0.5, "ch"+i, pct, Ani.QUAD_OUT));
        cumulativeChannels.add(i, new Float(pct));
      }

      if (distPct != cumulativeFxs.get(i)) {
        aniFxs.add(i, new Ani(this, 0.5, "fx"+i, pct, Ani.QUAD_OUT));
        cumulativeFxs.add(i, new Float(distPct));
      }
    }
  }

  /*
  float getConnectedsDistPctFor(int channel) {
   
   int result = 0;
   int numConnecteds = 0;
   
   for (int i=0; i<fiducials.size(); i++) {
   boolean isSame = fiducials.get(i).midiPitchOff == channel;
   
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
   
   */

  PVector getConnectedsChannelsPctFor(int channel) {

    int result = 0;
    int numConnecteds = 0;
    float distance = 0.0;

    for (int i=0; i<fiducials.size(); i++) {

      AbstractFiducial a = fiducials.get(i);
      boolean isSame = (a.midiPitchOn == channel);




      if (isSame) {
        result++;
        if (fiducials.get(i).visible) {
          numConnecteds++;

          for (int j=0; j<fiducials.size(); j++) {

            AbstractFiducial b = fiducials.get(j);
            if (a != b && a.midiPitchOff == b.midiPitchOff  && b.visible) {
              distance = a.getNormalizedDistanceTo(b);
            }
          }
        }
      }

     // println(distance);

      // also find distance
    }

    if ( numConnecteds == 0 )
      return new PVector(0, distance);

    return new PVector((float)numConnecteds / (float)result, distance) ;
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