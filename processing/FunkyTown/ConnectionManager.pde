class ConnectionManager {

  FiducialManager fiducialManager;
  
  ConnectionManager (FiducialManager fiducial) {

    this.fiducialManager = fiducial;
  }

  void draw() {
     
    ArrayList<AbstractFiducial> connecteds = fiducialManager.getConnectedFiducials();
    for (int i=0; i<connecteds.size(); i++) {

      AbstractFiducial a = connecteds.get(i);

      for (int j=0; j<connecteds.size(); j++) {

        AbstractFiducial b = connecteds.get(j);
        if (a != b && a.isLineConnected && b.isLineConnected ) {
          drawConnectedLine(a, b);
        }
      }
    }
  }

  void drawConnectedLine(AbstractFiducial a, AbstractFiducial b) {
    
    float distance = a.getNormalizedDistanceTo(b);
    float cosPct = .5f + cos((float)millis() / (float)((float)distance * 500.0f)) * .5f;
    
    stroke(255, 0, 0);
    strokeWeight(cosPct * 50);
    line(a.x, a.y, b.x, b.y);
  }
}