class StrictFiducial extends AbstractFiducial {

  float[] angle, rad, speed, xPos, yPos, diam;
  int[] nbConnex;
  int nbPts;
  final static int RADIUS = 20;
  int counter;

  StrictFiducial(int id) {
    super(id);
    this.isLineConnected = true;
        this.isParticleSender = true;

  }

  void init() {
    initialize();
    counter =  50;
    initialize();


    x= 130;
    y= 100;
    
  }

  void show() {
    super.show();
    background(0);
    counter = counter + 6;
    println (counter);
  }

  void hide() {
    super.hide();
    background(0);
    counter = counter - 6;
    println (counter);
  }





  void initialize() {
    nbPts = int(counter);
    angle = new float[nbPts];

    rad = new float[nbPts];
    speed = new float[nbPts];
    xPos = new float[nbPts];
    yPos = new float[nbPts];
    diam = new float[nbPts];
    nbConnex = new int[nbPts];
    for (int i = 0; i<nbPts; i++) {
      angle[i] = random(TWO_PI);
      rad[i] = int(random(1, 4)) * RADIUS;
      speed[i] = random(-.01, .01);
      xPos[i] = 0;
      yPos[i] = 0;
      nbConnex[i] = 0;
      diam[i] = 0;
    }
  }

  void draw () {

    pushMatrix();//pour la rotation
    translate(x, y);

    stroke(255, 150);
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
      xPos[i] = ease(xPos[i],  cos(angle[i]) * rad[i], 0.1);
      yPos[i] = ease(yPos[i],  sin(angle[i]) * rad[i], 0.1);
      diam[i] = ease(diam[i], min(nbConnex[i], 7)*(rad[i]/RADIUS), 0.1);
      fill(255, 50);
      ellipse(xPos[i], yPos[i], diam[i] + 10, diam[i] + 10);
      fill(255);
      ellipse(xPos[i], yPos[i], diam[i] + 1, diam[i] + 1);

      nbConnex[i] = 0;
    }


    popMatrix();
  }


  float ease(float variable, float target, float easingVal) {
    float d = target - variable;
    if (abs(d)>1) variable+= d*easingVal;
    return variable;
<<<<<<< HEAD
  }
}

//cc rosalie
=======
  }
>>>>>>> 9a180e050735ad0f77fc8a26ae250bb6f3fe0c8b
