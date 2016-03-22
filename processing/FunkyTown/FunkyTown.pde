import themidibus.*;

import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import netP5.*;
import oscP5.*;
import codeanticode.syphon.*;

public static boolean LIVE_MODE = true;


boolean             bDebugMode = true;

OscP5               oscP5;
SyphonServer        server;
MidiBus             midi; 
FiducialManager     fiducialManager;
ConnectionManager   connectionManager;
UIPanel              uipanel;

void settings() {
  size(640, 480, P3D);

  if (LIVE_MODE)
    PJOGL.profile=1;
}

void setup() {

if (LIVE_MODE) {

    OscProperties properties = new OscProperties();
    properties.setRemoteAddress("127.0.0.1", 12000);
    properties.setListeningPort(12345);
    properties.setSRSP(OscProperties.ON);
    properties.setDatagramSize(64000);

    oscP5 = new OscP5(this, properties);

    server = new SyphonServer(this, "FunkyTown Syphon");
    midi = new MidiBus(this, -1, "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  }
  
  fiducialManager     = new FiducialManager();
  fiducialManager.setup(midi);

  connectionManager = new ConnectionManager(fiducialManager);
  
  uipanel = new UIPanel();
  uipanel.setup();
  
}

void draw () {

  background(0);

  connectionManager.draw();
  fiducialManager.draw();
  uipanel.draw();


  if (LIVE_MODE) {
    server.sendScreen();
  }
}

void keyPressed () {
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage msg) {
  //println(msg.checkAddrPattern("/fiducial"));
  if (msg.checkAddrPattern("/fiducial") == true) {
    fiducialManager.onOscMessageHandler(msg);
  }
}