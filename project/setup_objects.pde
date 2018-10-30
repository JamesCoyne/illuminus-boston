PImage buildingscan, buildinglines, barrierPic, bouncy, ball1, triangle1, specialglow;

void loadImages(){
  println("loading pictures and stuff");
  ball1 = loadImage("ball.png");
  triangle1 = loadImage("triangle - norm_1@2x.png");
  bouncy = loadImage("barrierMov - circle@2x.png");
  barrierPic = loadImage("barrierStill - line@2x.png");
  buildingscan = loadImage("buildingscan.png");
  buildinglines = loadImage("buildinglines.png");
  special = loadImage("special_icon@2x.png");
  specialglow = loadImage("special_glow@2x.png");
}

void setupObjects(){
  println("setting up objects");
  //hardcoded positions of window elements
  
  //top row
  barriers.add(new box_barrier(0,0,145,height*4));
  
  barriers.add(new box_barrier(168,201,65,110));
  barriers.add(new box_barrier(320,201,65,110));
  barriers.add(new box_barrier(472,201,65,110));
  
  barriers.add(new box_barrier(610,201,65,110));
  barriers.add(new box_barrier(762,201,65,110));
  barriers.add(new box_barrier(914,201,65,110));
  
  //second row w/ rounded windows
  barriers.add(new box_barrier(168,410,65,100));
    barriers.add(new circle_barrier(169,365,66));
  barriers.add(new box_barrier(320,410,65,100));
    barriers.add(new circle_barrier(321,365,66));
  barriers.add(new box_barrier(472,410,65,100));
    barriers.add(new circle_barrier(473,365,66));
  barriers.add(new box_barrier(610,410,65,100));
    barriers.add(new circle_barrier(611,365,66));
  barriers.add(new box_barrier(762,410,65,100));
    barriers.add(new circle_barrier(763,365,66));
  barriers.add(new box_barrier(914,410,65,100));
    barriers.add(new circle_barrier(915,365,66));
  
  int windowScale = 188;
  //middile section
  //barriers.add(new box_barrier(715,635,50,10));
  //barriers.add(new box_barrier(800,635,50,10));
  //barriers.add(new box_barrier(800,300,65,110));
 // barriers.add(new box_barrier(770,587,65,110));
  for(int i = 0; i < 3; i++){
    barriers.add(new box_barrier(191,587+i*windowScale,110,120));
    barriers.add(new box_barrier(320,587+i*windowScale,110,120));
    barriers.add(new box_barrier(450,587+i*windowScale,110,120));
    barriers.add(new box_barrier(683,587+i*windowScale,65,110));
    barriers.add(new box_barrier(770,587+i*windowScale,65,110));
    barriers.add(new box_barrier(855,587+i*windowScale,65,110));
  }
  
  //bottom section
  for(int i = 0; i < 3; i++){
    barriers.add(new box_barrier(191,1168+i*windowScale,110,120));
    barriers.add(new box_barrier(320,1168+i*windowScale,110,120));
    barriers.add(new box_barrier(450,1168+i*windowScale,110,120));
    barriers.add(new box_barrier(683,1168+i*windowScale,65,110));
    barriers.add(new box_barrier(770,1168+i*windowScale,65,110));
    barriers.add(new box_barrier(855,1168+i*windowScale,65,110));
  }
  barriers.add(new box_barrier(1060,0,100,height*displayDensity()*2));
  
  displayedBarriers.add(new Bumper(0,0,70,15));
  displayedBarriers.add(new Bumper(0,0,70,15));
  displayedBarriers.add(new Bumper(0,0,70,15));
  displayedBarriers.add(new Bumper(0,0,70,15));
  
  displayedBarriers.add(new bouncy_barrier(700,600,60));
  displayedBarriers.add(new bouncy_barrier(600,1400,100));
  displayedBarriers.add(new specialTrigger("V1_building_smaller.mov"));
 
}
