#include "ofApp.h"


//--------------------------------------------------------------
void ofApp::setup(){
    
    bIsFullScreen = false;
    
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
    
    threshold = 80;
    bLearnBakground = true;
    backgroundSubOn = false;
    
    fidfinder.detectFinger		= false;
    fidfinder.maxFingerSize		= 25;
    fidfinder.minFingerSize		= 5;
    fidfinder.fingerSensitivity	= 0.05f; //from 0 to 2.0f
    
    
    oscSender.setup("localhost", 12000);
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
        }
        grayDiff.blur();
        grayDiff.threshold(threshold);
        fidfinder.findFiducials( grayDiff );
    }
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    
    if(bIsFullScreen ) {
        grayImage.draw(0,0, camWidth, camHeight);

    } else {
    
    colorImg.draw(20,20);
    grayImage.draw(camWidth + 40,20);
    grayBg.draw(20,camHeight + 40);
    grayDiff.draw(camWidth + 40,camHeight + 40);
        
        
    syphonServer.publishTexture(&grayImage.getTexture());
     
    for (list<ofxFiducial>::iterator fiducial = fidfinder.fiducialsList.begin(); fiducial != fidfinder.fiducialsList.end(); fiducial++) {
        
        fiducial->draw( 20, 20 );
        fiducial->drawCorners( 20, 20 );

        ofSetColor(255,255,255);
        //like this one below
        cout << "fiducial " << fiducial->getId() << " found at ( " << fiducial->getX() << "," << fiducial->getY() << " )" << endl;
        
        checkIfFiducialExists(&*fiducial);
        
        message.setAddress("/fiducial");
        message.addIntArg(fiducial->getId());
        message.addIntArg(0);
        message.addIntArg(fiducial->getX());
        message.addIntArg(fiducial->getY());
        message.addIntArg(fiducial->getAngleDeg());
        oscSender.sendMessage(message, false);
        message.clear();
        
    }
    
    for (list<ofxFinger>::iterator finger = fidfinder.fingersList.begin(); finger != fidfinder.fingersList.end(); finger++) {
        finger->draw(20, 20);
    }
    
    ofDrawBitmapString( "[space] to learn background\n[+]/[-] to adjust threshold\n[b] to remove background subtraction",
                       20, 550 );
        
    }
    
}

void ofApp::checkIfFiducialExists(ofxFiducial * fiducial) {
    
    bool bExists = false;
    for(int i=0; i<fiducials.size(); i++) {
        
        if(fiducials[i] == fiducial->getId()) {
            bExists = true;
            break;
        }
        
    }
    
    if(!bExists) {
        message.setAddress("/fiducial");
        message.addIntArg(fiducial->getId());
        message.addIntArg(1);
        message.addIntArg(fiducial->getX());
        message.addIntArg(fiducial->getY());
        message.addIntArg(fiducial->getAngleDeg());
        oscSender.sendMessage(message, false);
        message.clear();
    }
        
    
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
        bIsFullScreen = !bIsFullScreen;
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
