class Particle {

  float damping;
  PVector pos = new PVector();
  PVector frc = new PVector();
  PVector vel = new PVector();


  Particle() {

    damping = 0.99f;



    frc.set(0, 0);
    vel.set(0, 0);
  }

  void resetForce() {
    frc.set(0, 0);
  }

  void update() {
    vel.x = vel.x + frc.x;
    vel.y = vel.y + frc.y;

    pos.x = pos.x + vel.x;
    pos.y = pos.y + vel.y;
  }

  void addForce(float x, float y) {

    frc.x += x;
    frc.y += y;
  }

  void addDampingForce () {

    frc.x = frc.x - vel.x * damping;
    frc.y = frc.y - vel.y * damping;
  }

  void addRepulsionForce(float x, float y, float radius, float scale) {

    PVector posOfForce = new PVector();
    posOfForce.set(x, y);

    PVector diff  = PVector.sub(pos, posOfForce);
    float length  = diff.mag();

      boolean bAmCloseEnough = true;
    if (radius > 0) {
      if (length > radius) {
        bAmCloseEnough = false;
      }
    }

    if (bAmCloseEnough == true) {
      float pct = 1 - (length / radius);  // stronger on the inside
      diff.normalize();
      frc.x = frc.x + diff.x * scale * pct;
      frc.y = frc.y + diff.y * scale * pct;
    }
  }


  void addAttractionForce(float x, float y, float radius, float scale) {

    PVector posOfForce = new PVector();
    posOfForce.set(x, y);

    PVector diff  = PVector.sub(pos, posOfForce);
    float length  = diff.mag();

    boolean bAmCloseEnough = true;
    if (radius > 0) {
      if (length > radius) {
        bAmCloseEnough = false;
      }
    }

    if (bAmCloseEnough == true) {
      float pct = 1 - (length / radius);  // stronger on the inside
      diff.normalize();
      frc.x = frc.x - diff.x * scale * pct;
      frc.y = frc.y - diff.y * scale * pct;
    }
  }
}