#include "ofApp.h"


//--------------------------------------------------------------
void ofApp::setup(){
    
    
    ofSetVerticalSync(true);
    
    kinect.setRegistration(true);
    kinect.init(true);
    kinect.open();
    
    camWidth = kinect.width;
    camHeight = kinect.height;
    
    colorImg.allocate(camWidth,camHeight);
    grayImage.allocate(camWidth,camHeight);
    grayBg.allocate(camWidth,camHeight);
    grayDiff.allocate(camWidth,camHeight);
    grayDiff2.allocate(camWidth,camHeight);
    
    threshold = 30;
    bLearnBakground = true;
    backgroundSubOn = false;
    
    fidfinder.detectFinger		= false;
    fidfinder.maxFingerSize		= 25;
    fidfinder.minFingerSize		= 5;
    fidfinder.fingerSensitivity	= 0.05f; //from 0 to 2.0f
    
    bPublishSyphon      = false;
    
    oscSender.setup("localhost", 12345);
    syphonServer.setName("Funky Town Calibration Syphon");;
    
}

//--------------------------------------------------------------
void ofApp::update(){
    
    ofBackground(100,100,100);
    
    kinect.update();
    
    if (kinect.isFrameNew()){
        
        kinect.getTexture().readToPixels(pixels);
        grayImage.setFromPixels(pixels);

        if (bLearnBakground == true){
            grayBg = grayImage;
            bLearnBakground = false;
            backgroundSubOn = true;
        }
        
        if (backgroundSubOn) {
            grayDiff.absDiff( grayBg, grayImage );
        } else {
            grayDiff = grayImage;
            //grayDiff2 = grayImage;
        }
       
        // grayDiff.blur(4);
        //grayDiff.threshold(threshold);
        grayDiff.adaptiveThreshold(threshold, 3);
        //grayDiff2.adaptiveThreshold(threshold);

        
        fidfinder.findFiducials( grayDiff );
    }
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    
    grayImage.draw(camWidth + 40,20);
    grayBg.draw(20,camHeight + 40);
    grayDiff.draw(20,20);
    
    
    //if(bPublishSyphon) {
  //  syphonServer.publishTexture(&grayDiff.getTexture());
    //return;
        
    //}
    
    // check for removed
    for(int i=0; i<fiducials.size(); i++) {
        bool bExists = false;
        for (list<ofxFiducial>::iterator fiducial = fidfinder.fiducialsList.begin(); fiducial != fidfinder.fiducialsList.end(); fiducial++) {
            if(fiducial->getId() == fiducials[i]) {
                bExists = true;
                continue;
            }
        }
        
        if(!bExists) {
            
            ofxOscMessage       message;

            int id = fiducials[i];
            message.setAddress("/fiducial");
            message.addIntArg(id);
            message.addIntArg(2);
            message.addFloatArg(0.0);
            message.addFloatArg(0.0);
            message.addFloatArg(0.0);
            oscSender.sendMessage(message);
           // return;
        }
    }
    
    ofSetColor(255,255,255);

    for (list<ofxFiducial>::iterator fiducial = fidfinder.fiducialsList.begin(); fiducial != fidfinder.fiducialsList.end(); fiducial++) {
        
        fiducial->draw( 20, 20 );
        fiducial->drawCorners( 20, 20 );

        
        bool exists = checkIfFiducialExists(&*fiducial);
        
        int fiducialID  = fiducial->getId();
        float xPos      = fiducial->getX();
        float yPos      = fiducial->getY();
        float angle     = fiducial->getAngleDeg();
        int state       = (exists) ? 0 : 1;
        ofxOscMessage       message;

        message.setAddress("/fiducial");
        message.addIntArg(fiducialID);
        message.addIntArg(state);
        message.addFloatArg(xPos);
        message.addFloatArg(yPos);
        message.addFloatArg(angle);
        oscSender.sendMessage(message);
        //message.clear();
        
    }
    
    fiducials.clear();
    for (list<ofxFiducial>::iterator fiducial = fidfinder.fiducialsList.begin(); fiducial != fidfinder.fiducialsList.end(); fiducial++) {
        fiducials.push_back(fiducial->getId());
    }
        

    ofDrawBitmapString( "[space] to learn background\n[+]/[-] to adjust threshold ["+ofToString(threshold)+"]\n[b]to remove background subtraction",
                       20, 550 );
    
    
}

bool ofApp::checkIfFiducialExists(ofxFiducial * fiducial) {
    
    bool bExists = false;
    for(int i=0; i<fiducials.size(); i++) {
        
        if(fiducials[i] == fiducial->getId()) {
            bExists = true;
            break;
        }
        
    }
    
   
    return bExists;
}


//--------------------------------------------------------------
void ofApp::keyPressed  (int key){
    if( key == ' ' ) {
        bLearnBakground = true;
    } else if( key == '-' ) {
        threshold = max( 0, threshold-1 );
    } else if( key == '+' || key == '=' ) {
        threshold = min( 255, threshold+1 );
    } else if( key == 'b' ) {
        backgroundSubOn = false;
    } else if (key =='f') {
        ofToggleFullscreen();
    } else if (key == 's') {
        bPublishSyphon = !bPublishSyphon;
    }
    
   
}

//--------------------------------------------------------------
void ofApp::keyReleased  (int key){
    
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
}

//--------------------------------------------------------------
void ofApp::mouseReleased(){
    
}
