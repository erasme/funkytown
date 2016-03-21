class ConnectionManager {

  ArrayList<Particle> particles = new ArrayList<Particle>();
  FiducialManager fiducialManager;

  ConnectionManager (FiducialManager fiducial) {

    this.fiducialManager = fiducial;
  }

  void draw() {

    ArrayList<AbstractFiducial> connecteds = fiducialManager.getConnectedFiducials();
    ArrayList<AbstractFiducial> receivers = new ArrayList<AbstractFiducial>();

    for (int i=0; i<connecteds.size(); i++) {

      AbstractFiducial a = connecteds.get(i);

      if (a.isParticleSender ) {
        emitParticles(a);
      }

      if (a.isParticleReceiver) {
        receivers.add(a);
      }

      for (int j=0; j<connecteds.size(); j++) {

        AbstractFiducial b = connecteds.get(j);
        if (a != b && a.isLineConnected && b.isLineConnected ) {
          drawConnectedLine(a, b);
        }
      }
    }

    drawParticles(receivers);
  }

  void drawConnectedLine(AbstractFiducial a, AbstractFiducial b) {

    float distance = a.getNormalizedDistanceTo(b);
    float cosPct = .5f + cos((float)millis() / (float)((float)distance * 500.0f)) * .5f;

    stroke(255, 0, 0);
    strokeWeight(cosPct * 5);
    line(a.x, a.y, b.x, b.y);
  }

  void emitParticles(AbstractFiducial a) {
    Particle p = new Particle();
    int range = 30;
    
    float random   = random(1.0);
    p.damping      = .05 + random*.1;
    p.size         = 1 + random * 5;
    p.pos.x        = random(a.x - range, a.x + range);
    p.pos.y        = random(a.y - range, a.y + range);
    
    particles.add(p);
  }

  void drawParticles(ArrayList<AbstractFiducial> receivers) {
    
    // delete dead particles
    int length = particles.size();
    for (int j = length-1; j >= 0; j--) {
      if (particles.get(j).life > 200.0f ) {
        particles.remove(j);
      }
    }

    for (int i=0; i<particles.size(); i++) {

      if (particles.get(i).target == null & receivers.size() > 0 ) {
        int rdm = (int)random(receivers.size());
        particles.get(i).target = receivers.get(rdm);
      }
      particles.get(i).resetForce();

      particles.get(i).updateTargets();
      particles.get(i).addDampingForce();
      particles.get(i).update();

      fill(255);
      noStroke();
      ellipse(particles.get(i).pos.x, particles.get(i).pos.y, particles.get(i).size, particles.get(i).size);
    }
  }
}