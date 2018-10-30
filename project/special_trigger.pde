int[] triggerPositionsX = {300,680,870,1070,1264,1450};
int[] triggerPositionsY = {170,770};

PImage special;

class specialTrigger extends Barrier{
  
 // specialMovie m;
  Movie movie;
  float w,h;
  
  specialTrigger(String filename){
    this.w = 65;
    this.h = 65;
    movie = new Movie(app, filename);
    movie.pause();
    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);
    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(
      box2d.coordPixelsToWorld(triggerPositionsY[round(random(0,triggerPositionsY.length-1))],triggerPositionsX[round(random(0,triggerPositionsX.length-1))]));
    b = box2d.createBody(bd);
    b.setUserData(this);
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }
  
  void beginContact(){
   movie.play();
   imageMode(0);
   specialMovie = movie;
   animCounter = 1;
  }
  
  void nextPos(){
    this.setpos(triggerPositionsY[round(random(0,triggerPositionsY.length-1))],triggerPositionsX[round(random(0,triggerPositionsX.length-1))],0);
  }
  int waitTime = round(random(0,1000));
  int nextMove = round(random(0,1000));
  boolean waiting = true;
  void controlMovement(){
    if(frameCount > nextMove){
      if(waiting){
        this.setpos(-100,-100,0);
      }
      else{
        nextPos();
      }
      waiting = !waiting;
      nextMove = frameCount + round(random(0,1000));
    }
  }
  int animCounter = -1;
  int animLength = 100;
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(b);
    pushMatrix();
    translate(pos.x, pos.y);
    imageMode(CENTER);
    if(animCounter > 0){
      if(animCounter >= animLength){
        animCounter = -5;
        nextPos();
      }
      else{
        rotate(radians(frameCount/1));
        scale(map(animCounter*2,0,animLength, 1, 3));
        //tint(255, 127);
        image(special,0,0,w,h);
        tint(255, 255);
        animCounter++; 
      }
    }
    else{
      rotate(radians(frameCount/1));
      //println(map(float(frameCount)-(float(nextMove))/100,0,10,0,1) );
      scale(map(sin(float(frameCount)/1),-1,1,0.7,0.9));
      image(special,0,0,w,h);
    }
    imageMode(0);
    popMatrix();
    controlMovement();
  }
  
}
