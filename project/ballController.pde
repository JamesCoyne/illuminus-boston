ballController squareController;
ballController circleController;

int pos1, pos2;
boolean trigger1, trigger2;

void setupBallControllers(){
  println("setting up ball controllers");
  squareController = new ballController(0);
  circleController= new ballController(1);
}

class ballController{

  public boolean triggered = false;
  public float xPos;
  private int timeDown;
  private int ballType;
  
  ballController(int ballType_){
    ballType = ballType_;
  }
  
  
  public void move(float newX){
    xPos = newX;
  }
  
  public void trigger(boolean t){
    if(t){
      addBall();
      timeDown = frameCount;
    }
    triggered = t;
    
    
  }
  
  public void addBall(){
    if(ballType == 0) balls.add(new circleBall(xPos,80, round(random(minNote, maxNote))));
    else balls.add(new triangleBall(xPos,80, round(random(minNote, maxNote))));
    //balls.add(new circleBall(xPos,80, 50));
  }
  
  public void step(){
    if(this.triggered == true && frameCount - timeDown > 20){
      addBall();
    }
    
    noFill();
    stroke(255);
    strokeWeight(2);
    rectMode(CENTER);
    pushMatrix();
    translate(xPos,80);
    rotate(radians(frameCount));
    
    if(ballType == 0) ellipse(0,0,50,50);
    else  {
      pushMatrix();
      translate(-25,-25);
      shapeMode(CENTER);
      triangle(25*2, 0, 0, 0, 12.5*2, 21.651*2);
      popMatrix();
    }
    popMatrix();
  }
  
}
