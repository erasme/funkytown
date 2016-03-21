class FunFiducial extends AbstractFiducial {

  float cosPct;

  ArrayList<Particle> particles = new ArrayList<Particle>();

  FunFiducial(int id) {
    super(id);
    this.isLineConnected = true;
  }

  void init() {

    x = 100;
    y = 100;

    for (int i=0; i<100; i++) {
      particles.add(new Particle());
      particles.get(i).pos.x = random(width);
      particles.get(i).pos.y = random(height);
    }
  }

  void show() {
    super.show();
  }

  void hide() {
    super.hide();
  }

  void draw () {

    cosPct = .5 + cos((float)millis() / 100.0f) * .5;



    for (int i=0; i<particles.size(); i++) {
      particles.get(i).resetForce();
      particles.get(i).addAttractionForce(mouseX, mouseY, 300, 10);
      // particles.get(i).addRepulsionForce(mouseX, mouseY, 295, 100);

      particles.get(i).addDampingForce();
      particles.get(i).update();

      fill(255);
      noStroke();
      ellipse(particles.get(i).pos.x, particles.get(i).pos.y, 10, 10);
    }

    pushMatrix();
    translate(x, y);

    fill(255, 0, 0);
    rect(0, 0, 10, 10);
    ellipse(0, 0, 100 + 100 * cosPct, 100 + 100*cosPct);

    popMatrix();
  }
}