class StrictFiducial extends AbstractFiducial {

  int i;


  StrictFiducial(int id, MidiBus midi, int midiPitchOn, int midiPitchOff, Color mainColor) {
    super(id, midi, midiPitchOn, midiPitchOff, mainColor);
    this.isLineConnected = true;
    this.isParticleSender = true;
  }

  void init() {
    i = 0;
  }

  void show() {
    super.show();
  }

  void hide() {
    super.hide();
  }







  void draw () {

    i++;
    
    
     pushMatrix();//pour la rotation
    translate(x, y);
    rotate(rotation);
    
    pushMatrix();

   // translate(width/2, height/2);
    stroke(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct,  mainColor.getBlue()*easedActivePct);
    strokeWeight(2);
    noFill();
    rotate(PI);
    triangle(-25, 50, 0, 0, 25, 50);

    popMatrix();


    pushMatrix();
    //translate(width/2, height/2);
    stroke(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct,  mainColor.getBlue()*easedActivePct);
    strokeWeight(2);
    noFill();
    triangle(-25, 50, 0, 0, 25, 50);

    rotate(radians(1*i));

    pushMatrix();
    rotate(0 );
    translate(0, -75);
    triangle(-10, 10, 0, -10, 10, 10);
    popMatrix();

    pushMatrix();
    rotate(-2*PI/3);
translate(0, -75);
    triangle(-10, 10, 0, -10, 10, 10);
    popMatrix();

    rotate(radians(-2*i));
    pushMatrix();
    rotate(2*PI/3);
    translate(0, -75);
    triangle(-10, 10, 0, -10, 10, 10);
    popMatrix();

    pushMatrix();
    rotate(-2*PI/3);
    translate(0, -75);
    triangle(-10, 10, 0, -10, 10, 10);
    popMatrix();

    pushMatrix();
    rotate(2*PI/3);
    translate(0, -75);
    triangle(-10, 10, 0, -10, 10, 10);
    popMatrix();

    popMatrix();
    
    popMatrix();

    /*
    pushMatrix();//pour la rotation
     translate(x, y);
     rotate(rotation);
     stroke(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct, mainColor.getBlue()*easedActivePct, 255 * easedActivePct);
     for (int i=0; i<nbPts-1; i++) {
     for (int j=i+1; j<nbPts; j++) {
     if (dist(xPos[i], yPos[i], xPos[j], yPos[j])<RADIUS+1) {
     line(xPos[i], yPos[i], xPos[j], yPos[j]);
     nbConnex[i]++;
     nbConnex[j]++;
     }
     }
     }
     
     noStroke();
     for (int i=0; i<nbPts; i++) {
     angle[i] += speed[i];
     xPos[i] = ease(xPos[i], cos(angle[i]) * rad[i], 0.1);
     yPos[i] = ease(yPos[i], sin(angle[i]) * rad[i], 0.1);
     diam[i] = ease(diam[i], min(nbConnex[i], 7)*(rad[i]/RADIUS), 0.1);
     fill(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct, mainColor.getBlue()*easedActivePct, 150 *easedActivePct );
     ellipse(xPos[i], yPos[i], diam[i] + 10, diam[i] + 10);
     fill(mainColor.getRed() *easedActivePct, mainColor.getGreen()*easedActivePct, mainColor.getBlue()*easedActivePct, 50 * easedActivePct);
     ellipse(xPos[i], yPos[i], diam[i] + 1, diam[i] + 1);
     
     nbConnex[i] = 0;
     }
     popMatrix();
     
     */
  }


  float ease(float variable, float target, float easingVal) {
    float d = target - variable;
    if (abs(d)>1) variable+= d*easingVal;
    return variable;
  }
}