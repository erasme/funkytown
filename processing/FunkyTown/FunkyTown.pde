import promidi.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import netP5.*;
import oscP5.*;
import codeanticode.syphon.*;

public static boolean LIVE_MODE = true;


boolean             bDebugMode = true;

OscP5               oscP5;
SyphonServer        server;
MidiIO              midiIO;
MidiOut             midiOut;
FiducialManager     fiducialManager;
ConnectionManager   connectionManager;
UIPanel  uipanel;

void settings() {
  size(640, 480, P3D);

  if (LIVE_MODE)
    PJOGL.profile=1;
}

void setup() {


  fiducialManager     = new FiducialManager();
  fiducialManager.setup();

  connectionManager = new ConnectionManager(fiducialManager);
  
  uipanel = new UIPanel();
  uipanel.setup();

  if (LIVE_MODE) {

    OscProperties properties = new OscProperties();
    properties.setRemoteAddress("127.0.0.1", 12000);
    properties.setListeningPort(12345);
    properties.setSRSP(OscProperties.ON);
    properties.setDatagramSize(64000);

    oscP5 = new OscP5(this, properties);

    server = new SyphonServer(this, "FunkyTown Syphon");

    midiIO = MidiIO.getInstance(this);
    midiIO.printDevices();
    midiOut = midiIO.getMidiOut(0, 0);
  }
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