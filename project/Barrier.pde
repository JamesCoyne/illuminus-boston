ArrayList<Barrier> barriers = new ArrayList();
ArrayList<Barrier> displayedBarriers = new ArrayList();

PVector bumpersPos = new PVector();
PVector bouncePos = new PVector();


void controlMovingBarriers(){
  displayedBarriers.get(0).setpos(map(bumpersPos.x,0,255,120,width/2), 490, -map(bumpersPos.y,0,255,0,(float)Math.PI * 2));
  displayedBarriers.get(1).setpos(map(bumpersPos.x,0,255,width/2,120), 680, -map(bumpersPos.y,0,255,0,(float)Math.PI * 2));
  displayedBarriers.get(2).setpos(map(bumpersPos.x,0,255,width/2,120), 865, -map(bumpersPos.y,0,255,0,(float)Math.PI * 2));
  displayedBarriers.get(3).setpos(map(bumpersPos.x,0,255,width/2,120), 1065, -map(bumpersPos.y,0,255,0,(float)Math.PI * 2));
  displayedBarriers.get(4).setpos(105, map(bouncePos.x,0,255,200,width-400),0);
  for(Barrier b : displayedBarriers) b.display();
}


public class Barrier{
  public Body b;
  public boolean touching = false;
  BodyDef bd;
  
  
  Barrier(){
  }
  
  void display(){
  }
  
  void endContact(){
    touching = false;
  }
 
   void beginContact(){
    touching = true;
  }
  
  
  public void setpos(float x, float y, float r){
    b.setTransform(box2d.coordPixelsToWorld(x,y), r);
  }
  
}


class box_barrier extends Barrier{
  
  box_barrier(float x,float y, float w, float h){

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
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    b.setUserData(this);
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }
  
 
  
  void display(){
    fill(50,234,2);
    noStroke();
    if(touching) fill(255,0,0);
    rectMode(CENTER);
   // rect(x,y,w,h);
  }
  
}

class circle_barrier extends Barrier{
  circle_barrier(float x,float y, float w){

    // Define the polygon
    CircleShape circle = new CircleShape();
    circle.m_radius = box2d.scalarPixelsToWorld(w/2);
    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    b.setUserData(this);
    // Attached the shape to the body using a Fixture
    b.createFixture(circle,1);
  }
  
  void display(){
    fill(50,234,2);
    noStroke();
    //stroke(255);
    //strokeWeight();
    if(touching) fill(255,0,0);
    ellipseMode(CENTER);
    //ellipse(x,y,w,w);
  }
}



class bouncy_barrier extends Barrier {
  
  float w;
  
   bouncy_barrier(float x,float y, float w){
    this.w = w;
    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(w/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);
    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    b.setUserData(this);
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }
  
   void display(){
    Vec2 pos = box2d.getBodyPixelCoord(b);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(frameCount));
    fill(255);
    noStroke();
    if(touching) scale(0.9);
    imageMode(CENTER);
    image(bouncy,0,0,w,w);
    imageMode(0);
    popMatrix();
  }
  
   public void setpos(float x, float y, float r){
     b.setTransform(box2d.coordPixelsToWorld(x,y), r);
   }
  
}

class Bumper extends Barrier{
  public Body b;
  float w,h;
  
  Bumper(float x,float y, float w, float h){
    this.w = w;
    this.h = h;
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
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    b.setUserData(this);
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }
  
   public void setpos(float x, float y, float r){
    b.setTransform(box2d.coordPixelsToWorld(x,y), r);
  }
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(b);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-b.getAngle());
    fill(255);
    noStroke();
    imageMode(CENTER);
    image(barrierPic,0,0,w,h);
    imageMode(0);
    popMatrix();
  }
  
}
