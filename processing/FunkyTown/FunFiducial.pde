class FunFiducial extends AbstractFiducial {


  float cosPct;
  float xoff=0.0;

  float px1[], py1[], velx[], vely[];
  int part = 1000;
  boolean env01=true;


  FunFiducial(int id) {
    super(id);
    this.isLineConnected = true;
    this.isParticleSender = false;
  }

  void init() {
    x = 100;
    y = 100;

    px1 = new float[part];
    py1 = new float[part];
    velx = new float[part];
    vely = new float[part];
    for (int i=0; i<part; i++) {
      px1[i] = width/2;
      py1[i] = height/2;
      velx[i] = random(-1.5, 1.5);
      vely[i] = random(-1.5, 1.5);
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


    pushMatrix();
    translate(x, y);



    if (focused) {
      xoff = xoff + .01;
      float  xoff2 = xoff + xoff;
      noFill();
      stroke(255, 15);
      ellipseMode(CENTER);
      ellipse(width/2, height/2, 500*noise(xoff2), 500*noise(xoff));
    }


    //  fill(255, 0, 0);
    //rect(0, 0, 10, 10);
    // ellipse(0, 0,  50 * cosPct, 50 * cosPct);
    noStroke();
    rectMode(CORNER);
    fill(0, 1);
    rect(0, 0, width, height);

    //fill(255, 0, 0);
    //rect(0, 0, 10, 10);
    // ellipse(0, 0,  50 * cosPct, 50 * cosPct);

    popMatrix();
    stroke(255);
    strokeWeight(1.5);
    for (int i=0; i<part; i++) {
      point(px1[i], py1[i]);
      px1[i]+=velx[i];
      py1[i]+=vely[i];
      if ((py1[i]>height) | (px1[i]>width) | (py1[i]<0) | (px1[i]<0)) {
        py1[i] = mouseY;
        vely[i] = random(-0.5, 0.5)*noise(10)*10;
        px1[i] = mouseX;
        velx[i] = random(-0.5, 0.5)*noise(10)*10;
        strokeWeight(2.2);
        px1[i]+=velx[i]*2;
        py1[i]+=vely[i]*2;
      }
    }
  }
}