class NatureFiducial extends AbstractFiducial {

  int maxCount = 1000; //max count of the cirlces
  int currentCount = 1;
  float[] posX = new float[3000];
  float[] posY = new float[3000];
  float[] r = new float[3000]; // radius


  NatureFiducial(int id, MidiBus midi, int midiPitchOn, int midiPitchOff) {
    super(id, midi, midiPitchOn,midiPitchOff);
    this.isLineConnected = false;
    this.isParticleReceiver = true;

    x = 300;
    y = 500;
  }

  void init() {
    x=150;
    y=400;

    currentCount = 1;

    // first circle
    posX[0] = 0;
    posY[0] = 0;
    r[0] = 20;
  }

  void show() {
    super.show();
  }

  void hide() {
    super.hide();
  }

  void draw () {


    pushMatrix();//pour la rotation
    translate(x, y);
    rotate(rotation);

    // create a radom set of parameters
    float newR = random(1, 7);
    float newX = random(-width, width+newR);
    float newY = random(-height, height+newR);

    float closestDist = 100;
    int closestIndex = 100;
    for (int i=0; i < currentCount; i++) {
      float newDist = dist(newX, newY, posX[i], posY[i]);
      if (newDist < closestDist) {
        closestDist = newDist;
        closestIndex = i;
      }
    }
    float angle = atan2(newY-posY[closestIndex], newX-posX[closestIndex]);

    posX[currentCount] = posX[closestIndex] + cos(angle) * (r[closestIndex]+newR);
    posY[currentCount] = posY[closestIndex] + sin(angle) * (r[closestIndex]+newR);
    r[currentCount] = newR;
    
    maxCount = (int)(easedCumPct * 3000);
    
    if(currentCount < maxCount-1 ) {
      currentCount++;
    }
    
    int total = (currentCount > maxCount ) ? maxCount : currentCount;
    for (int i=0; i < total; i++) {
      stroke(8*easedActivePct, 247*easedActivePct, 184*easedActivePct, 100*easedActivePct);
      strokeWeight(4);
      fill(0.0*easedActivePct, 255.0*easedActivePct, 255.0*easedActivePct, 50.0*easedActivePct);
      ellipse(posX[i], posY[i], r[i]*2, r[i]*2);
    }
    fill(255,255);
    //if (currentCount >= maxCount) init();
    popMatrix();
  }
}