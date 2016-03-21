import netP5.*;
import oscP5.*;
import codeanticode.syphon.*;

boolean             bDebugMode = true;

OscP5                oscP5;
NetAddress           broadcastSettings; 

SyphonServer        server;
FiducialManager     fiducialManager;
ConnectionManager   connectionManager;


void settings() {
  size(640, 480, P3D);
  //PJOGL.profile=1;
}

void setup() {


  fiducialManager     = new FiducialManager();
  fiducialManager.setup();

  connectionManager = new ConnectionManager(fiducialManager);


  oscP5 = new OscP5(this, 12000);
  broadcastSettings = new NetAddress("127.0.0.1", 12345);

  server = new SyphonServer(this, "FunkyTown Syphon");
}

void draw () {

  background(0);
  lights();

  connectionManager.draw();
  fiducialManager.draw();
  server.sendScreen();
}

void keyPressed () {

  if (bDebugMode) {

    if ( key == 'a') {
    }

    if ( key == 'r') {
    }
  }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/fiducial")==true) {
    fiducialManager.onOscMessageHandler(msg);
  }
}