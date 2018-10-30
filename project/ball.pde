ArrayList<Ball> balls = new ArrayList();
ArrayList<Ball> trashBalls = new ArrayList();



void controlBalls(){
  for(Ball b : balls) {
    b.done();
  }
  if(balls.size() > 100){
    for(int i = 0; i < balls.size() - 100; i++){
      trashBalls.add(balls.get(i));
    }
  }
  balls.removeAll(trashBalls);
  
  for(Ball b : trashBalls){
    box2d.destroyBody(b.body);
  }
  trashBalls.clear();
  
  for(Ball b : balls) {
    b.display();
  }
  //println(balls.size());
}

class Ball{
  int noteMIDI;
  int velMIDI = 127;
  
  public Body body;
  public FixtureDef fd = new FixtureDef();
  
  Ball(){
  }
  
  public void display(){
  }
  
  void beginContact(){
    //myBus.sendNoteOff(0, noteMIDI, velMIDI);
    myBus.sendNoteOn(0, noteMIDI, velMIDI);
  }
  
  void endContact(){
     myBus.sendNoteOff(0, noteMIDI, velMIDI);
  }
  
  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height*displayDensity()) {
       destroy();
      return true;
    }
    return false;
  }
  
  public void destroy(){
    trashBalls.add(this);
    myBus.sendNoteOff(0, noteMIDI, velMIDI);
    //box2d.destroyBody(body);
  }
  
}

class triangleBall extends Ball{
 
  triangleBall(float x, float y, int nm){
    PolygonShape triangle = new PolygonShape();
        Vec2[] vertices = new Vec2[3];
        vertices[0] = new Vec2(-box2d.scalarPixelsToWorld(10),  0);
        vertices[1] = new Vec2(box2d.scalarPixelsToWorld(10),  0);
        vertices[2] = new Vec2( 0, -box2d.scalarPixelsToWorld((10*2) * 1.73));
    triangle.set(vertices, 3);
    fd.shape = triangle;
    fd.friction = friction;
    fd.restitution = restitution;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-1, 1)); 
    body.setUserData(this);
    
    noteMIDI = nm;
  }
  
  void display(){
   // point(box2d.getBodyPixelCoord(body).x,box2d.getBodyPixelCoord(body).y);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-body.getAngle());
    //rectMode(CENTER);
    //rect(0,0,10,10);
    //rectMode(0);
    imageMode(CENTER);
    image(triangle1,0,0,10*2,10*2);
    imageMode(0);
    popMatrix();
  }
}

class circleBall extends Ball{
  
  
  circleBall(float x, float y, int nm){
    CircleShape circle = new CircleShape();
    circle.m_radius = box2d.scalarPixelsToWorld(10);
    fd.shape = circle;
    fd.friction = friction;
    fd.restitution = restitution;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-1, 1));
    body.setUserData(this);
    
    noteMIDI = nm;
  }
  
  void display(){
    //point(box2d.getBodyPixelCoord(body).x,box2d.getBodyPixelCoord(body).y);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-body.getAngle());
    imageMode(CENTER);
    image(ball1,0,0,20,20);
    imageMode(0);
    popMatrix();
  }
  
   void beginContact(){
    //myBus.sendNoteOff(0, noteMIDI, velMIDI);
    myBus.sendNoteOn(1, noteMIDI, velMIDI);
  }
  
  void endContact(){
     myBus.sendNoteOff(1, noteMIDI, velMIDI);
  }
  
   public void destroy(){
    trashBalls.add(this);
    myBus.sendNoteOff(1, noteMIDI, velMIDI);
    //box2d.destroyBody(body);
  }
  
}
