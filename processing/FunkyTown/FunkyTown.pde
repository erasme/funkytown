import themidibus.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import netP5.*;
import oscP5.*;
import codeanticode.syphon.*;
import java.awt.*;

public static boolean LIVE_MODE = true;

boolean             bDebugMode = true;

OscP5               oscP5;
SyphonServer        server;
MidiBus             midi; 
FiducialManager     fiducialManager;
ConnectionManager   connectionManager;
UIPanel             uipanel;

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
    properties.setDatagramSize(64000);

    oscP5 = new OscP5(this, properties);

    server = new SyphonServer(this, "FunkyTown Syphon");
    MidiBus.list();
    midi = new MidiBus(this, -1, "Bus 1");
  }

  Ani.init(this);

  fiducialManager     = new FiducialManager();
  fiducialManager.setup(midi);

  connectionManager = new ConnectionManager(fiducialManager);

  uipanel = new UIPanel();
  uipanel.setup();
}

void update() {
  fiducialManager.update();
}

void draw () {

  update();

  background(0);

  connectionManager.draw();
  fiducialManager.draw();
  //uipanel.draw();


  if (LIVE_MODE) {
    server.sendScreen();
  }


  // pour tester
  //int value = (int)((float)(mouseX) / (float)(width) * 127.0);
  //midi.sendControllerChange(1, 1, value); // Send a controllerChange
  //midi.sendControllerChange(1, 1, value);
}

void keyPressed () {

  println(key);

  if (key == '&' || key =='￿' )
    return;
  /*
  if (key == 'a')
   midi.sendControllerChange(1, 1, 0);
   if (key == 'z')
   midi.sendControllerChange(1, 2, 0);
   if (key == 'r')
   midi.sendControllerChange(1, 3, 0);
   if (key == 't')
   midi.sendControllerChange(1, 4, 0);
   if (key == 'y')
   midi.sendControllerChange(1, 5, 0);
   if (key == 'u')
   midi.sendControllerChange(1, 6, 0);
   if (key == 'i')
   midi.sendControllerChange(1, 7, 0);
   if (key == 'o')
   midi.sendControllerChange(1, 8, 0);
   
   
   if (key == 'q')
   midi.sendControllerChange(1, 9, 0);
   if (key == 's')
   midi.sendControllerChange(1, 10, 0);
   if (key == 'd')
   midi.sendControllerChange(1, 11, 0);
   if (key == 'f')
   midi.sendControllerChange(1, 12, 0);
   if (key == 'g')
   midi.sendControllerChange(1, 13, 0);
   if (key == 'h')
   midi.sendControllerChange(1, 14, 0);
   if (key == 'j')
   midi.sendControllerChange(1, 15, 0);
   if (key == 'k')
   midi.sendControllerChange(1, 16, 0);
   
   */
   //midi.sendControllerChange(1, 8, 0); // Send a controllerChange
   
   
}

void oscEvent(OscMessage msg) {
  if (msg.typetag().equals("iifff")) {
    if (msg.checkAddrPattern("/fiducial") == true) {
      fiducialManager.onOscMessageHandler(msg);
    }
  } else {
  }
}