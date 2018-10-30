
void beginContact(Contact cp) {
  //println("boink!");
  Object o1 = cp.getFixtureA().getBody().getUserData();
  Object o2 = cp.getFixtureB().getBody().getUserData();
  
  if(o1 != null && o2 != null){
    
    if(o2.getClass().getSuperclass() == Ball.class && o1.getClass().getSuperclass() == Barrier.class){
      Ball o = (Ball) o2;
      o.beginContact();
      Barrier b = (Barrier) o1;
      b.beginContact();
    }
    
    if(o1.getClass() == specialTrigger.class && o2.getClass().getSuperclass() == Ball.class){
      Ball o = (Ball) o2;
      o.body.applyForce(new Vec2(0, -100000),new Vec2(0, -100000));
      o.beginContact();
    }
    
    
    if(o1.getClass() == bouncy_barrier.class && o2.getClass().getSuperclass() == Ball.class){
      Ball o = (Ball) o2;
      o.body.setLinearVelocity(new Vec2(o.body.getLinearVelocity().x * -1000, o.body.getLinearVelocity().y * -1000));
    }
    
    if(o1.getClass().getSuperclass() == Barrier.class){
      Barrier b = (Barrier) o1;
      b.beginContact();
    }
    
    if(o2.getClass().getSuperclass() == Barrier.class){
      Barrier b = (Barrier) o2;
      b.beginContact();
    }
    
  }
}

void endContact(Contact cp) {
  Object o1 = cp.getFixtureA().getBody().getUserData();
  Object o2 = cp.getFixtureB().getBody().getUserData();

  if(o1.getClass().getSuperclass() == Ball.class){
    Ball o = (Ball) o1;
    o.endContact();
  }
  
  if(o2.getClass().getSuperclass() == Ball.class){
    Ball o = (Ball) o2;
    o.endContact();
  }
  
  if(o1.getClass().getSuperclass() == Barrier.class){
      Barrier b = (Barrier) o1;
      b.endContact();
    }
  if(o2.getClass().getSuperclass() == Barrier.class){
      Barrier b = (Barrier) o2;
      b.endContact();
  }
  
}
