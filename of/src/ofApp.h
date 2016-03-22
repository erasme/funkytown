#pragma once

#include "ofMain.h"
#include "ofxOpenCv.h"
#include "ofxCv.h"
#include "ofxFidMain.h"
#include "ofxKinect.h"
#include "ofxOsc.h"
#include "ofxSyphon.h"

class ofApp : public ofBaseApp{

	public:
    ofxCvGrayscaleImage grayImage;
    ofxCvGrayscaleImage grayBg;
    ofxCvGrayscaleImage	grayDiff;
    ofxCvColorImage		colorImg;
    
    ofxFiducialTracker	fidfinder;
    
    ofxOscSender        oscSender;
    
    ofxSyphonServer     syphonServer;
    
    ofPixels            pixels;

    
    int 				threshold;
    bool				bLearnBakground;
    bool				backgroundSubOn;
    
    
    void setup();
    void update();
    void draw();
    
    
    int camWidth, camHeight;
    
    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y );
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased();
    
    bool checkIfFiducialExists(ofxFiducial * fiducial);
    
    ofxKinect kinect;
    vector<int> fiducials;
    
    bool bIsFullScreen;
		
};
