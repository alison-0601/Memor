import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

Capture video;
OpenCV opencv;
Rectangle[] faces;
///HD Pro
//int w = 800;
//int h = 448;///framerate 6-7
//experiment with different capture settings here (they need to be lsited in the terminal)
int w = 800;
int h = 448;///framerate 10-11
//int w = 640;
//int h = 480;///framerate 5-7
//int w = 640;
//int h = 360;///framerate 17-18

///USB Device
//int w = 640;
//int h = 480;///framerate 11-12

void setup()
{
  //this should match the resolution you set the projector to
  size(1600, 896);
  //fullScreen();

  String[] cameras = Capture.list();
  for (int i = 0; i<cameras.length; i++)
  {
    println(i, cameras[i]);
  }


  video = new Capture(this, w, h, "HD Pro Webcam C920", 30);
  //video = new Capture(this, w, h, "USB Video Device", 30);
  //video = new Capture(this, w, h,cameras[0], 30);

  opencv = new OpenCV(this, video);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  faces = opencv.detect();
  video.start();
}

void draw()
{
  background(0);
  if (video.available())
  {
    video.read();
  }
  opencv.loadImage(video);
  float sWidth =width;
  float ratio =sWidth/w;
  scale(ratio);
    image(video, 0, 0);//, width, height);

  Rectangle[] faces = opencv.detect();
  // println(faces.length);

  for (int i = 0; i<faces.length; i++)
  {
    //here samplw some crorner pixels 
    noFill();
    noStroke();
    //stroke(255);
    //strokeWeight(3);
    //println(faces[i].x + "," +faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    float w = faces[i].x+faces[i].width;
    float h = faces[i].y+faces[i].height;
    for ( int j = faces[i].x; j<w; j+=6)
    {
      for (int k = faces[i].y; k<h; k+=6)
      {
        //float x = random(width);
        //float y = random(height);
        color c = video.get(int(j), int(k));
        //do a brightness tewst here and apply a condition
        fill(c, 25);
        noStroke();
        ellipse(j, k, 40, 40);
      }
    }
  }
  pushStyle();
  fill(0);
  //rect(50,50,200,100);
  /////showing the frameRate
  //fill(255);
  //text("framerate "+str(frameRate),70,80);
  rect(0,0,90,h);
  rect(725,0,75,h);
  popStyle();
}

void captureEvent(Capture c)
{
  c.read();
}
