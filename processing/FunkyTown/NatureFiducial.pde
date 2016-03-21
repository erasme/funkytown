class NatureFiducial extends AbstractFiducial {

  int maxCount = 1000; //max count of the cirlces
  int currentCount = 1;
  float[] posX = new float[maxCount];
  float[] posY = new float[maxCount];
  float[] r = new float[maxCount]; // radius


  NatureFiducial(int id) {
    super(id);
    this.isLineConnected = true;
    x = 300;
    y = 100;
  }

  void init() {
    x=300;
    y=300;

    currentCount = 1;


    smooth();
    //frameRate(10);

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

    // create a radom set of parameters
    float newR = random(1, 7);
    float newX = random(-width, width+newR);
    float newY = random(-height, height+newR);

    float closestDist = 100;z
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
    currentCount++;

    for (int i=0; i < currentCount; i++) {
      noStroke();
      fill(11, 255, 182);
      ellipse(posX[i], posY[i], r[i]*2, r[i]*2);
    }
    if (currentCount >= maxCount) init();
    popMatrix();
  }
}