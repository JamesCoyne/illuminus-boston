import themidibus.*;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import processing.video.*;

Box2DProcessing box2d; 
MidiBus myBus;
PApplet app;
Movie myMovie;

Movie specialMovie;

int minNote = 35;
int maxNote = 59;

box_barrier bottom_wall;

int gravity = -120;
float friction = 1;
float restitution = 0;
Boolean showDebug = true;
Boolean bottom = false;

void setup(){
  loadImages();
  println("setting up window");
  frameRate(40);
  app = this;
  //fullScreen(P2D);
  //rotate(radians(-90));
  size(540,960,P2D);
  pixelDensity(displayDensity());
  
  println("setting up box2d");
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, gravity);
  box2d.listenForCollisions();
 
  println("creating midi output");
  myBus = new MidiBus(this, -1, "illuminus");
  myBus.sendNoteOn(0, 24, 255);
  setupControllers();
  setupObjects();
  setupBallControllers();
}

void draw(){
  
   circleController.xPos = map(pos1,0,255,0,width/2);
   squareController.xPos = map(pos2,0,255,0,width/2);
   circleController.trigger(trigger1);
   squareController.trigger(trigger2);
   background(0); 
   text(mouseX*2 +"  " + mouseY*2, mouseX, mouseY);
   scale(0.5);
   //rotate(radians(-90));
   //translate(-width/1.8,0);
  
   
  box2d.step();
  if(specialMovie != null){
    image(specialMovie, 0,0,height,width);
    if(specialMovie.duration() == specialMovie.time()){
      specialMovie.jump(0);
      specialMovie.pause();
      specialMovie = null;
    }
    
  }
  controlMovingBarriers();
  //controlSerial();
  debugShowing();
  squareController.step();
  circleController.step();
  controlBalls();
  if(keyPressed){
    balls.add(new circleBall(mouseX*2, mouseY*2,50));
  }
  for(Barrier b : displayedBarriers) b.display();
  for(Barrier b : barriers) b.display();
}

void movieEvent(Movie m) {
  m.read();
}

void stop(){
  for(int i = minNote; i <= maxNote; i++) myBus.sendNoteOff(0, i, 127);
}
