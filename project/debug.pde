
Boolean showScan = false;
Boolean showLines = true;
Boolean showBoundry = false;
Boolean speedyMode = false;
Boolean showGfx = false;

void keyPressed(){
switch(key){
  case 'a':
    //balls.add(new ball(width/2*(1/sclr),0, 10, round(random(minNote,maxNote)),color(242, 76, 141),"circle"));
  break;
  case 's':
    //balls.add(new ball(width/2*(1/sclr),0,10, round(random(minNote,maxNote)),color(89, 208, 0),"square"));
  break;
  case 'd':
    //balls.add(new ball(width/2*(1/sclr),0,10,round(random(minNote,maxNote)),color(0, 180, 211),"triangle"));
  break;
  case '1':
    showScan = !showScan;
  break;
  case '2':
    showLines = !showLines;
  break;
  case '3':
    showBoundry = !showBoundry;
  break;
  case '-':
    gravity--;
    box2d.setGravity(0,gravity);
  break;
  case '=':
    gravity++;
    box2d.setGravity(0,gravity);
  break;
  case '[':
    friction -= 0.1;
  break;
  case ']':
    friction += 0.1;
  break;
  case ';':
    restitution -= 0.1;
  break;
  case '\'':
    restitution += 0.1;
  break;
  case 'z':
    speedyMode = !speedyMode;
  break;
  case 'x':
  break;
  case 'g':
    gravity *= -1;
    box2d.setGravity(0, gravity);
  break;
  case '4':
    showDebug = !showDebug;
  break;
  case '5':
   // if(currentAnimation == 0) currentAnimation = -1;
   // else currentAnimation = 0;
  break;
}
}

void debugShowing(){
  if(speedyMode){
  if(keyPressed){
    switch(key){
      case 'a':
       balls.add(new circleBall(mouseX, mouseY,50));
      break;
      case 's':
       // balls.add(new ball(width/2*(1/sclr),0,10, round(random(minNote,maxNote)),color(89, 208, 0),"square"));
      break;
      case 'd':
       // balls.add(new ball(width/2*(1/sclr),0,10,round(random(minNote,maxNote)),color(0, 180, 211),"triangle"));
      break;
    }
  }
  }
  if(showDebug){
    fill(255,0,0);
    text("gravity: " + gravity + 
    "\nfriction: " + round(friction*100) + 
    "%\nbounciness: " + round(restitution*100) + 
    "%\nbottom boundry: " + bottom +
    "\n speedyMode: " + speedyMode +
    "\n frameRate: " + round(frameRate)
    , 20,30);
  }
  if(showBoundry){
    for(Barrier b : barriers) b.display();
  }
   if(showScan) image(buildingscan, 0, 0);
  //displaySpecialAnimation();
  if(showLines)image(buildinglines, 0, 0);
}
