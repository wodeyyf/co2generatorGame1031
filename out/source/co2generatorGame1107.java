import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class co2generatorGame1107 extends PApplet {

int max = 30;
int carbonVal = 3;
float speed = 5;
boolean start = false;
boolean dead = false;
boolean survive = false;
boolean play = false;
boolean select = false;
Table table;
int value = 1;
int rowNum;
int colNum;
int year;
int year_pos = 0;
int FPS = 30;
public static int countryID;
int bubbleNum;
Bubbles [] b = new Bubbles[max];
ArrayList countrylist = new ArrayList();
ArrayList CO2 = new ArrayList();
ArrayList years = new ArrayList();
int currentFPS = 0;


Gamer g = new Gamer();

public void setup() {
  

  frameRate(FPS);

  table = loadTable("CO2P.csv", "header");
  //country
  rowNum = table.getRowCount();
  //year
  colNum = table.getColumnCount();
  TableRow onerow = table.getRow(0);
  for (int j = 1; j < colNum; j++) {
      //println(row.getColumnTitle(j));
      years.add(onerow.getColumnTitle(j));
    }
  // println(years);
  for (int i = 0; i < rowNum; i++) {
    TableRow row = table.getRow(i);
    String Country = row.getString("Country");
    countrylist.add(Country); 

    for (int j = 1; j < colNum; j++) {
      //println(row.getColumnTitle(j));
      float CO = row.getFloat(row.getColumnTitle(j)); 
      CO2.add(CO);

    }
  }
    // println(years);
      //println(countrylist);
      //println(CO2);
  
  for (int i = 0; i < max; i++) {
    //print out the size and the numbers of the balls
    b[i] = new Bubbles();
  }
  noStroke();
}


public void draw() {
  background(0);
    text("FPS:"+round(frameRate),width-40,0);

  if (!start) {
    GameStart();
  } 
  else if (select) {
    countryID = GameSelect();
    
  } 
  else if (play) {
    GameMain();
    if (dead) {
    GameFail();
  } else if (survive) {
    GameSucceed();
  }
  }
}



  //    change=CO;
  //    for (int k = 0; k < max; k++) {
  //  //print out the size and the numbers of the balls
  //  b[k] = new Bubbles(change);
  //}
  //noStroke();
  //  }

public void GameStart() {
  fill(11, 100);
  rect(0, height/2-130, width, 127);
  rect(100, height/2+20, width-200, 55);
  fill(0xffFFFFFF);
  textAlign(LEFT, TOP);
  textSize(80);
  text("CO2Bubbles", width/2-230, height/2-140);
  textSize(20);
  text("Change in CO2 emissions per capita in countries", width/2-230, height/2-30);
  textAlign(CENTER, TOP);
  fill(0xffFFFFFF);
  if (mousePressed) {
    if (mouseX>100 && mouseX<width-200) {
      if (mouseY>height/2+20 && mouseY<height/2+75) {
        start = true;
        select = true;
      }
    }
  }
  if (mouseX>100 && mouseX<width-200 && mouseY>height/2+20 && mouseY<height/2+75) {
    textSize(45);
    text("START", width/2-10, height/2+20);
  } else {
    textSize(40);
    text("START", width/2-10, height/2+20);
  }
  textAlign(LEFT, TOP);
  textSize(12);
  text("FPS:"+round(frameRate), width-40, 0);
}


public int GameSelect() {
  fill(11, 100);
  rect(0, height/3-50,width/5-50, 127);
  fill(0xffFFFFFF);
  textAlign(LEFT, TOP);
  textSize(40);
  text("Countries", width/5-50, height/3-50);
  textSize(20);
  for (int i = 0; i < rowNum; i++) {
    String s = countrylist.get(i).toString();
    int h = 30*i+height/3;
    text(s, width/5-50, h);
  }

       int countryID = ((mouseY-height/3)/30); 
  if (mousePressed && mouseX> width/5-50 && mouseX< width/5) {

   println (countrylist.get(countryID));
      select = false;
   play = true;;
  };
  return countryID;
}



public void GameMain() {
  fill(204, 102, 0);
    textAlign(CENTER, CENTER);
  textSize(30);
  String s = countrylist.get(countryID).toString();
  text(s, width/2, height/3-50);

//for(int i=1971;i<2019;i++){
//  TableRow row= table.getRow(countryID);
//  TableRow Num = table.findRow("countryID","i");
//  int a=Num;
//  bubbleNum=a*100;
//}
//println(countrylist);
  // int year = int(years.get(0).toString());
  // println(year); 
  println(currentFPS,FPS);
  if (currentFPS % (FPS * 3) == 0){
    year_pos = min(PApplet.parseInt(currentFPS / (FPS * 3)),colNum-1);
    carbonVal=PApplet.parseInt(PApplet.parseFloat(CO2.get(countryID*(colNum-1) + year_pos).toString())*10);
    println("========",CO2.get(countryID*(colNum-1) + year_pos).toString());
  } 
  String currentyear = years.get(year_pos).toString();
  text(currentyear, width-200, height/3-50);
  text(carbonVal, width-100, height/3-50);
  g.updatePos();

  for (int i = 0; i < max; i++) {
    b[i].update();
    b[i].checkOffScreen();
  }

  for (int i = 0; i < carbonVal; i++) {
    b[i].drawBubble();
    g.checkProx(b[i]);
  }
for(int i=1;i<colNum;i++){
  
}
  g.drawGamer();
  currentFPS += 1;
}



public void GameSucceed() {
  fill(11, 100);
  rect(0, height/2-130, width, 127);
  rect(100, height/2+20, width-200, 55);
  fill(0xffFFFFFF);
  textAlign(CENTER, CENTER);
  textSize(100);
  text("Success", width/2-260, height/2-120);
  textSize(40);
  text("Try Again", width/2-70, height/2+20);
    if (mousePressed) {
    if (mouseX>100 && mouseX<width-200) {
      if (mouseY>height/2+20 && mouseY<height/2+75) {
        start = false;
      }
    }
  }
  if (mouseX>100 && mouseX<width-200 && mouseY>height/2+20 && mouseY<height/2+75) {
    textSize(45);
    text("Try Again", width/2-10, height/2+20);
  } else {
    textSize(40);
    text("Try Again", width/2-10, height/2+20);
  }
  textAlign(LEFT, TOP);
  textSize(12);
  text("FPS:"+round(frameRate), width-40, 0);
}


public void GameFail() {
  fill(11, 100);
  rect(0, height/2-130, width, 127);
  rect(100, height/2+20, width-200, 55);
  fill(0xffFFFFFF);
  textAlign(CENTER, CENTER);
  textSize(100);
  text("Game Over", width/2, height/2-120);
  textSize(40);
    if (mousePressed) {
    if (mouseX>100 && mouseX<width-200) {
      if (mouseY>height/2+20 && mouseY<height/2+75) {
        select = true;
        dead = false;
      }
    }
  }
  if (mouseX>100 && mouseX<width-200 && mouseY>height/2+20 && mouseY<height/2+75) {
    textSize(45);
    text("Try Again", width/2, height/2+20);
  } else {
    textSize(40);
    text("Try Again", width/2, height/2+20);
  }
  textSize(12);
  text("FPS:"+round(frameRate), width-40, 0);
}


class Gamer {
  float xpos, ypos;
  float size = 30;
  boolean alive = true;

  Gamer () {
    xpos = mouseX;
    ypos = mouseY;
  
  }

  public void updatePos() {
    xpos = mouseX;
    ypos = mouseY;
  }

  public void checkProx(Bubbles b) {
    float d = dist(xpos, ypos, b.xpos, b.ypos);
    if (d < size/2) {
      //println("HIT");
      alive = false;
      dead = true;
    }
  }


  public void drawGamer() {
    if (alive) {
      fill(0, 255, 0);
      ellipse(xpos, ypos, size, size);
    } else {
      fill(255, 0, 0);
      ellipse(xpos, ypos, 5, 5);
    }
  }
}




public void mouseReleased() {
  g.alive = true;
  // carbonVal = mouseY/20;
}
class Bubbles {
  //variable
  float size = 5;
  float ypos, xpos, xMove, yMove;
  float [] xmemory = {0, 0, 0, 0, 0, 0, 0, 0};
  float [] ymemory = {0, 0, 0, 0, 0, 0, 0, 0};

  Bubbles () {
    float r = random(0, 1);
    if (r < 0.25f) {
      // then it will start on top somewhere
      ypos = 0;
      xpos = random(0, width);
      xMove = random(-speed/2, speed/2);
      yMove = random(0, speed);
    } else if ( r < 0.5f) {
      // then it will start on right somewhere
      xpos = width;
      ypos = random(0, height);
      xMove = random(-speed, 0);
      yMove = random(-speed/2, speed/2);
    } else if ( r < 0.75f) {
      // then it will start on bottom somewhere
      ypos = height;
      xpos = random(0, width);
      xMove = random(-speed/2, speed/2);
      yMove = random(-speed, 0);
    } else {
      // then it will start on left somewhere
      xpos = 0;
      ypos = random(0, height);
      xMove = random(0, speed);
      yMove = random(-speed/2, speed);
    }
  }

  public void update() {
    for (int i = 6; i >=0; i--) {
      xmemory[i+1] = xmemory[i];
      ymemory[i+1] = ymemory[i];
    }
    xpos += xMove;
    ypos += yMove;
    xmemory[0] = xpos;
    ymemory[0] = ypos;
  }
  public void drawBubble() {
    for (int i = 0; i < 8; i++) {
      fill(255-(i * 25));
      ellipse(xmemory[i], ymemory[i], size, size);
    }
  }
  public void checkOffScreen() {
    if (xpos > width || xpos < 0 || ypos > height || ypos < 0) {
      float r = random(0, 1);
      if (r < 0.25f) {
        // then it will start on top somewhere
        ypos = 0;
        xpos = random(0, width);
        xMove = random(-speed/2, speed/2);
        yMove = random(0, speed);
      } else if ( r < 0.5f) {
        // then it will start on right somewhere
        xpos = width;
        ypos = random(0, height);
        xMove = random(-speed, 0);
        yMove = random(-speed/2, speed/2);
      } else if ( r < 0.75f) {
        // then it will start on bottom somewhere
        ypos = height;
        xpos = random(0, width);
        xMove = random(-speed/2, speed/2);
        yMove = random(-speed, 0);
      } else {
        // then it will start on left somewhere
        xpos = 0;
        ypos = random(0, height);
        xMove = random(0, speed);
        yMove = random(-speed/2, speed);
      }
    }
  }
}
  public void settings() {  size(1080, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "co2generatorGame1107" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
