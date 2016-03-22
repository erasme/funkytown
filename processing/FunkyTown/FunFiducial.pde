class FunFiducial extends AbstractFiducial {


float cosPct;
float xoff=0.0;
int i;

 
 
  FunFiducial(int id, MidiBus midi) {
    super(id, midi);
  
  //  this.isLineConnected = true;
   // this.isParticleSender = false;
  }

  void init() {
    x = 300;
    y = 100;
   
  }

  void show() {
    super.show();
  }

  void hide() {
    super.hide();
  }

  void draw () {


    cosPct = .5 + cos((float)millis() / 100.0f) * .5;
  
  int radius = 25;
  //background(0);
  i++;
  pushMatrix();
  translate(x,y);
  rotate(rotation);
  rotate(radians(i*1));
  stroke(8,247,184);
  strokeWeight(3);
  line(radius, 0, 50, 0);
  rotate(radians(i*1.2));
  line(radius, 0, 50, 0);
  rotate(radians(i*-0.5));
  line(radius, 0, 50, 0);
  rotate(radians(i*-1));
  line(radius, 0, 50, 0);
  rotate(radians(i*-3));
  line(radius, 0, 50, 0);
  rotate(radians(i*-0.5));
  line(radius, 0, 50, 0);
  rotate(radians(i*-0.7));
  line(radius, 0, 50, 0);
  popMatrix();


  }
}