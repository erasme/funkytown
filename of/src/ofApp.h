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
    
    ofxKinect           kinect;
    ofxFiducialTracker	fidfinder;
    ofxOscMessage       message;
    ofxOscSender        oscSender;
    ofxSyphonServer     syphonServer;
    ofPixels            pixels;

    int                 camWidth, camHeight;
    int 				threshold;
    bool				bLearnBakground;
    bool				backgroundSubOn;
    vector<int>         fiducials;

    
    
    void setup();
    void update();
    void draw();
        
    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y );
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased();
    bool checkIfFiducialExists(ofxFiducial * fiducial);
    
		
};
