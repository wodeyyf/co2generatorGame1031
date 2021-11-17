int max = 300;
int FPS = 30;
int currentFPS = 0;
int carbonVal = 3;
float speed = 5;
int yearspeed = 1;
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
public static int countryID;
int bubbleNum;
Bubbles [] b = new Bubbles[max];
ArrayList countrylist = new ArrayList();
ArrayList CO2 = new ArrayList();
ArrayList years = new ArrayList();


Gamer g = new Gamer();

void setup() {
  size(1080, 720);

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


void draw() {
  background(carbonVal*3);

  if (!start) {
    GameStart();
  } 
  else if (select) {
    countryID = GameSelect();
    
  } 
  else if (play) {
    GameMain();}
   else if (dead) {
    GameFail();
  } else if (survive) {
    GameSucceed();
  }
  }



  //    change=CO;
  //    for (int k = 0; k < max; k++) {
  //  //print out the size and the numbers of the balls
  //  b[k] = new Bubbles(change);
  //}
  //noStroke();
  //  }

void GameStart() {
  fill(11, 100);
  rect(0, height/2-130, width, 127);
  rect(100, height/2+20, width-200, 55);
  fill(#FFFFFF);
  textAlign(LEFT, TOP);
  textSize(80);
  text("CO2Bubbles", width/2-230, height/2-140);
  textSize(20);
  text("Change in CO2 emissions per capita in countries", width/2-230, height/2-30);
  textAlign(CENTER, TOP);
  fill(#FFFFFF);
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


int GameSelect() {
  fill(11, 100);
  rect(0, height/3-50,width/5-50, 127);
  fill(#FFFFFF);
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
  if (mousePressed && mouseX> width/5-50 && mouseX< width/5+200) {

   println (countrylist.get(countryID));
      select = false;
   play = true;;
  };
  return countryID;
}



void GameMain() {

  String CurrentC = countrylist.get(countryID).toString();
  String currentyear = years.get(year_pos).toString();

  textAlign(LEFT, TOP);
  fill(204, 102, 0);  
  textSize(30);
  text(CurrentC, width/2, 10);
  
  fill(255, 255, 255);  
  textSize(15);
  text("FPS:"+round(frameRate), width-80, 20);
  text("year:" + currentyear, width-250, 20);
  text("CO2:" + carbonVal, width-150, 20);

//for(int i=1971;i<2019;i++){
//  TableRow row= table.getRow(countryID);
//  TableRow Num = table.findRow("countryID","i");
//  int a=Num;
//  bubbleNum=a*100;
//}
//println(countrylist);
  // int year = int(years.get(0).toString());
  // println(year); 
  //println(currentFPS,FPS);
  
    year_pos = min(int(currentFPS / (FPS * yearspeed)),colNum-1);

    if (year_pos==colNum-2){
          play = false;
    survive = true;
    }
  
  if (currentFPS % (FPS * yearspeed) == 0){
          println (year_pos);
    carbonVal=int(float(CO2.get(countryID*(colNum-1) + year_pos).toString())*10);
    //println("========",CO2.get(countryID*(colNum-1) + year_pos).toString());
  } 
  

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
  //println(currentFPS);
  

}



void GameSucceed() {
  fill(11, 100);
  rect(0, height/2-130, width, 127);
  rect(100, height/2+20, width-200, 55);
  fill(#FFFFFF);
  textAlign(CENTER, CENTER);
  textSize(100);
  text("Success", width/2, height/2-120);
  textSize(40);
  
    currentFPS = 0;
  if (mousePressed) {
    if (mouseX>100 && mouseX<width-200) {
      if (mouseY>height/2+20 && mouseY<height/2+75) {
        survive = false;
        start = true;
        select = true;
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


void GameFail() {
  fill(11, 100);
  rect(0, height/2-130, width, 127);
  rect(100, height/2+20, width-200, 55);
  fill(#FFFFFF);
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

  void updatePos() {
    xpos = mouseX;
    ypos = mouseY;
  }

  void checkProx(Bubbles b) {
    float d = dist(xpos, ypos, b.xpos, b.ypos);
    if (d < size/2) {
      //println("HIT");
      alive = false;
      play = false;
      dead = true;
    }
  }


  void drawGamer() {
    if (alive) {
      fill(0, 255, 0);
      ellipse(xpos, ypos, size, size);
    } else {
      fill(255, 0, 0);
      ellipse(xpos, ypos, 5, 5);
    }
  }
}




void mouseReleased() {
  g.alive = true;
  // carbonVal = mouseY/20;
}
