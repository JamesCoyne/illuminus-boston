import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.ConcurrentModificationException;

import processing.serial.*;

BlockingQueue<int[]> queue = new LinkedBlockingQueue<int[]>();
Serial[] myPorts = new Serial[4];

void setupControllers()  {
  println("setting up controllers");
  printArray(Serial.list());
  int index = 0;
  
  for(String x : Serial.list()){
    if(x.contains("cu.usbmodem")){
      myPorts[index] = new Serial(this, x, 9600);
      index++;
    }
  }
}

void serialEvent(Serial thisPort) {
  String inString = thisPort.readStringUntil(10);
  if(inString != null) {
    String[] arrOfStr = inString.split(" "); 
    int index = 0;
    int[] arrOfInt = new int[3];
    for (String a : arrOfStr) {
      try {
        int w = Integer.valueOf(a);
          arrOfInt[index] = w;
        }
        catch(Exception e){
          //println(e);
        }
        index++;
      }
      
      try{
        //queue.put(arrOfInt);
          int controllerKey = arrOfInt[0];
          int controllerValue = arrOfInt[1];
          switch(controllerKey){
    //controller 1 button 
    case 0:
     // println("controller 1 button" + controllerValue);
      //if(controllerValue == 1) squareController.trigger(false);
      //else squareController.trigger(true);
      if(controllerValue == 1) trigger1 = false;
      else trigger1 = true;
    break;
    
    //controller 1 slider
    case 1:
     // println("controller 1 slider" + controllerValue);
     pos1 = controllerValue;
      //squareController.xPos = map(controllerValue,0,255,0,width/2);
    break;
    
    //controller 2 button
    case 2:
    //  println("controller 2 button" + controllerValue);
      //if(controllerValue == 1) circleController.trigger(false);
      //else circleController.trigger(true);
      if(controllerValue == 1) trigger2 = false;
      else trigger2 = true;
    break;
    
    //controller 2 slider
    case 3:
      //println("controller 2 slider" + controllerValue);
      pos2 = controllerValue;
      //circleController.xPos = map(controllerValue,0,255,0,width/2);
    break;
    
    //slider 4
    case 4:
      bumpersPos.x = controllerValue;
     // println("bumper slider moved");
      //bumperRot = controllerValue;
    break;
    
    //slider 5
    case 5:
      bumpersPos.y = controllerValue;
     // println("bumper slider moved");
      //bumperRot = controllerValue;
    break;
    
    //slider 6
    case 6:
      bouncePos.x = controllerValue;
    break;
    
    //slider 7
    case 7:
     // println("bumper slider moved");
      bouncePos.y = controllerValue;
    break;
    
    default:
      println("unidentified control id :/");
    break;
  }
      }
      catch(ConcurrentModificationException e){
        println(e);
      }
      
   }
}

void controlSerial(){
  //println("trying!");
  while(!queue.isEmpty()){
    
  try{
  int[] gottenInts = queue.take();
  int controllerKey = gottenInts[0];
  int controllerValue = gottenInts[1];
  switch(controllerKey){
    //controller 1 button 
    case 0:
     // println("controller 1 button" + controllerValue);
      if(controllerValue == 1) squareController.trigger(false);
      else squareController.trigger(true);
    break;
    
    //controller 1 slider
    case 1:
     // println("controller 1 slider" + controllerValue);
      squareController.xPos = map(controllerValue,0,255,0,width/2);
    break;
    
    //controller 2 button
    case 2:
    //  println("controller 2 button" + controllerValue);
      if(controllerValue == 1) circleController.trigger(false);
      else circleController.trigger(true);
      
    break;
    
    //controller 2 slider
    case 3:
      //println("controller 2 slider" + controllerValue);
      circleController.xPos = map(controllerValue,0,255,0,width/2);
    break;
    
    //slider 4
    case 4:
      bumpersPos.x = controllerValue;
     // println("bumper slider moved");
      //bumperRot = controllerValue;
    break;
    
    //slider 5
    case 5:
      bumpersPos.y = controllerValue;
     // println("bumper slider moved");
      //bumperRot = controllerValue;
    break;
    
    //slider 6
    case 6:
      bouncePos.x = controllerValue;
    break;
    
    //slider 7
    case 7:
     // println("bumper slider moved");
      bouncePos.y = controllerValue;
    break;
    
    default:
      println("unidentified control id :/");
    break;
  }
  }
  catch(Exception e){
    println(e);
  }
  }
}
