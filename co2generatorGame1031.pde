int max = 30;
Bubbles [] b = new Bubbles[max];
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
int selectedCountryNum;

ArrayList countrylist = new ArrayList();

ArrayList CO2 = new ArrayList();



Gamer g = new Gamer();

void setup() {
  size(1080, 720);

  table = loadTable("CO2P.csv", "header");
  //country
  rowNum = table.getRowCount();
  //year
  colNum = table.getColumnCount();

  for (int i = 0; i < rowNum; i++) {
    TableRow row = table.getRow(i);
    String Country = row.getString("Country");
    countrylist.add(Country); 

    for (int j = 1; j < colNum; j++) {
      //println(row.getColumnTitle(j));}
      float CO = row.getFloat(row.getColumnTitle(j)); 
      CO2.add(CO);
    }
  }

  printArray(countrylist);







  for (int i = 0; i < max; i++) {
    b[i] = new Bubbles();
  }
  noStroke();
}

void draw() {
  background(0);

  if (!start) {
    GameStart();
  } else if (play) {
    GameMain();}
    else if (select) {
    GameSelect();
  } else if (dead) {
    GameFail();
  } else if (survive) {
    GameSucceed();}
}



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
  rect(0, height/2-130, width, 127);
  rect(100, height/2+20, width-200, 55);
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

  int selectedCountryNum = ((mouseY-height/3)/30);


  if (mousePressed) {
    if (mouseX> width/5-50 && mouseX< width/5) {
      print (countrylist.get(selectedCountryNum));
            play = true;
            select = false;
    }
  }
return(selectedCountryNum);

}





void GameMain() {
  fill(#FFFFFF);

  String s = countrylist.get(selectedCountryNum).toString();
  text(s, width/2-50, height/3-50);


  g.updatePos();

  for (int i = 0; i < max; i++) {
    b[i].update();
    b[i].checkOffScreen();
  }

  for (int i = 0; i < carbonVal; i++) {
    b[i].drawBubble();
    g.checkProx(b[i]);
  }

  g.drawGamer();
}



void GameSucceed() {
  fill(11, 100);
  rect(0, height/2-130, width, 127);
  rect(100, height/2+20, width-200, 55);
  fill(#FFFFFF);
  textAlign(LEFT, TOP);
  textSize(100);
  text("Success", width/2-260, height/2-120);
  textSize(40);
  text("Thanks", width/2-70, height/2+20);
}


void GameFail() {
  fill(11, 100);
  rect(0, height/2-130, width, 127);
  rect(100, height/2+20, width-200, 55);
  fill(#FFFFFF);
  textAlign(LEFT, TOP);
  textSize(100);
  text("Game Over", width/2-260, height/2-120);
  textSize(40);
  text("Thanks", width/2-70, height/2+20);
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
  carbonVal = mouseY/20;
}




