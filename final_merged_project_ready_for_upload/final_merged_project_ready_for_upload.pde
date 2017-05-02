import guru.ttslib.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import qrcodeprocessing.*;
//importing all necessary libraries

TTS tts;
Kinect kinect;
Decoder decoder;
//Create all objects that are needed

String statusMsg = "Waiting for an image";
PImage depthImg;
int count = 2;
int Triggered = 1;
boolean QRCodePossible = false;
//initialising global variables that are needed

Float[] Getinfo() {
  //Getting the GPS location data from a text file and convert it to decimal direction  
  int i =0;
  Float[] coords = {0.0, 0.0};
  String[] lines = loadStrings("C:/Users/James/Desktop/toursetup.txt");

  int num = lines.length;
  int q = 0;

  while (q < num-1) { //Loop through to the bottom of the file
    q++;
    System.out.println(q);  
    System.out.println(num-1);  
    String[] list = split(lines[q], ',');



    String temp=list[0];

    if (temp.equals("$GPGLL") == true) { // select the correct fields from the txt file 
      try {
        String strlat = list[1];
        String strlng = list[3];
        System.out.println(strlat);      
        System.out.println( strlat.charAt(0));
        char a = strlat.charAt(0);
        char b = strlat.charAt(1);
        char c = strlng.charAt(1);
        char d = strlng.charAt(2);


        String lat1 = "" + a + b;
        String lat2 = strlat.substring(2);
        String lng1 = "" + c + d;
        String lng2 = strlng.substring(3);
        //splitting the feilds ready for converstion

        Float lat = ((Float.parseFloat(lat2)/60)+Float.parseFloat(lat1)); //convert the lat
        Float lng = ((Float.parseFloat(lng2)/60)+Float.parseFloat(lng1)); //convert the long

        coords[0] = lat;
        coords[1] = lng;
      }
      catch(java.lang.IndexOutOfBoundsException e) { //prvents crashing when GPS data is lost
        System.out.println("GPS location lost retrying");
      }
    }
  }
  return coords; //return converted lat and long coordinates
}  

void checkTourlocation(float lat, float lng) {
//This method check to see of you are at any of the location anlong the tour
  count+=1;
  if ((count % 2) != 0) {

    if ((52.40493 > lat) & (52.40481 < lat)) {

      if ((1.5004542 > lng)&(1.5001776 < lng)) {
        if (Triggered == 1) {
          tts.speak("You are at the start point of the tour. walk forwards. North. towards the engineering and computing building");
          QRCodePossible = true; //At this position on the tour wait for a QR code to be scanned before continuing on the tour
        }
      }
    }
    //check if position correlates to second location along the tour
    if (Triggered == 2) {
      if (52.40543 > lat) {
        tts.speak("Need to walk north");
      } else if (52.40550 < lat) {
        tts.speak("Need to walk south");
      } else if (1.5006386 > lng) {
        tts.speak("Need to walk west");
      } else if (1.5007700 < lng) {
        tts.speak("Need to walk east");
      }
      if ((52.40550 > lat) & (52.40543 < lat)) {
        if ((1.5007700 > lng) & (1.5006386 < lng)) {
          if (QRCodePossible == true) {
            tts.speak("please find and scan the Q.R. code.");
          } else {
            tts.speak("You are at the engineering building continue to walk forward. North. to continue");
            QRCodePossible = true;
          }
        }
      }
    }

    //check if position correlates to third location along the tour
    if (Triggered == 3) {
  
      if (52.40576 > lat) {
        tts.speak("Need to walk north");
      } else if (52.40581 < lat) {
        tts.speak("Need to walk south");
      } else if (1.5007271 > lng) {
        tts.speak("Need to walk west");
      } else if (1.5008397 < lng) {
        tts.speak("Need to walk east");
      }
      if ((52.40581 > lat) & (52.40578 < lat)) {
        if ((1.5008558 > lng) & (1.5007271 < lng)) {
          if (QRCodePossible == true) {
            tts.speak("please find and scan the Q.R. code.");
          } else {
            tts.speak("You are at the university library to continue the tour turn 90 degrees anticlockwise");
            QRCodePossible = true;
          }
        }
      }
    }
    //check if position correlates to fourth location along the tour
    if (Triggered == 4) {
      if (52.40557 > lat) {
        tts.speak("Need to walk north");
      } else if (52.40563 < lat) {
        tts.speak("Need to walk south");
      } else if (1.5010530 > lng) {
        tts.speak("Need to walk west");
      } else if (1.5011750 < lng) {
        tts.speak("Need to walk east");
      } else if ((52.40563 > lat) & (52.40557 < lat)) {
        if ((1.5011750 > lng) & (1.5010530 < lng)) {
          if (QRCodePossible == true) {
            tts.speak("please find and scan the Q.R. code.");
          } else {
            tts.speak("halfway there, turn 45 degrees right and continue forwards");
            QRCodePossible = true;
          }
        }
      }
    }         
    //check if position correlates to fifth location along the tour
    if (Triggered == 5) {
      if (52.40646 > lat) {
        tts.speak("Need to walk north");
      } else if (52.40660 < lat) {
        tts.speak("Need to walk south");
      } else if (1.5013282 > lng) {
        tts.speak("Need to walk west");
      } else if (1.5015294 < lng) {
        tts.speak("Need to walk east");
      } else if ((52.40660) > (lat) & (52.40646 < lat)) {         
        if ((1.5015294 > lng) & (1.5013282 < lng)) {
          if (QRCodePossible == true) {
            tts.speak("please find and scan the Q.R. code.");
          } else {
            tts.speak("You are now outside the buisness school this is the end of the tour");
            QRCodePossible = true;
          }
        }
      } 
    }
  }
}






void directionOfTravel(float lat, float lng) {
  // This method will identify the direction of travel of the user
  //and relay this information back to the user
  Float oldlat = 0.0;
  Float oldlng = 0.0;



  if (lat  > (oldlat)) {
    tts.speak("direction of travel is north");
  } else if (lat > oldlat) {
    tts.speak("direction of travel is south");
  } else if (lng > (oldlng)) {
    tts.speak("direction of travel is east");
  } else if (lng < (oldlng)) {
    tts.speak("direction of travel is west");
  }
  if ((count % 2) == 0) {
//every other time this method is called store the current position as old posistion 
//so when the new gps data is pulled it can be compared with the old to figure out what direction the user is travelling in
    oldlat = lat;
    oldlng = lng;
  }
}


void draw() {
  //main method
  Float lat;
  Float lng;
  Float[] coords;
  background(0);

  text(statusMsg, 10, height-4);
  image(kinect.getVideoImage(), kinect.width, 0);
  // If we are currently decoding
  
  //if the decoder is decoding an image to estblish if a QR code is present
  //disply the frame that is being decoded
  if (decoder.decoding()) {   
    PImage show = decoder.getImage();
    image(show, show.width, 0); 
    statusMsg = "Decoding image";
    for (int i = 0; i < (frameCount/2) % 10; i++) statusMsg += ".";
  }

  if (QRCodePossible == false) { 
    //if a QR code doesnt need scanning then check for obsticles to avoid
    boolean textOnScreen;
    int[] rawDepth = kinect.getRawDepth();
    for (int i=0; i < rawDepth.length; i++) { 
        //loop throught all the depth data
      if (rawDepth[i] >= 0 && rawDepth[i] <= 427) {   
        //if an object is within 30 centimeters of the sensor warn the user
        tts.speak("close proximity Warning");
      } else if (rawDepth[i] >= 750 && rawDepth[i] <= 800) {
        //if an object is 1 meter away from the user warn them
        tts.speak("object 1 meter away on.");        
        textOnScreen = false;
        
        // work out which side of the sensor the object is so the user can be warned
        if (i > 100000 && i< 200000) {
          if (textOnScreen == false) {
            tts.speak("Center");
            text("center", 10, 56);
            textOnScreen = true;
          }
        }            
        if (i <= 150000) {
          if (textOnScreen == false) {
            textSize(26);
            tts.speak("right");
            text("right", 10, 56);
            textOnScreen = true;
          }
        }
        if (i >= 150000) {
          if (textOnScreen == false) {
            tts.speak("left");
            text("left", 10, 56);
            textOnScreen = true;
          }
        }
      }
    }
    fill(0);
  }

//call all methods that are needed for the system to function
  coords  = Getinfo();
  lat = coords[0];
  lng = coords[1];
  checkTourlocation(lat, lng);
  directionOfTravel(lat, lng);
  if (QRCodePossible == true) {
    //only scan for QR codes if needed
    QRScanner();
  }
  //slow the system down to ensure the user is no spammed with information
  delay(2000);
}
void decoderEvent(Decoder decoder) {
  String statusMsg = decoder.getDecodedString(); 
  if (statusMsg.equals("NO QRcode image found") == false) {
    //if a QR code is found in an image read in tell the user this information 
    Triggered++;
    QRCodePossible = false;
    tts.speak(statusMsg);
  }
  println(statusMsg);
}

void QRScanner() {  
  //this method reads in the Videoimage from the Kinect and attempts to decode the 
  //the QR code if present
  PImage savedFrame = createImage(640, 480, RGB);
  savedFrame.copy(kinect.getVideoImage(), 0, 0, 640, 480, 0, 0, 640, 480);
  image(kinect.getVideoImage(), 0, 0);
  savedFrame.updatePixels();
  // Decode savedFrame
  decoder.decodeImage(savedFrame);
}


void setup() {
  tts = new TTS();

  size(1280, 480);

  kinect = new Kinect(this);
  decoder = new Decoder(this);
  kinect.initDepth();
  kinect.initVideo();
  //setup new objects and initialise the kinects depth and video sensor 
}