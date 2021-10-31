class Bubbles {
  //variable
  float size = 5;
  float ypos, xpos, xMove, yMove;
  float [] xmemory = {0, 0, 0, 0, 0, 0, 0, 0};
  float [] ymemory = {0, 0, 0, 0, 0, 0, 0, 0};

  Bubbles () {
    float r = random(0, 1);
    if (r < 0.25) {
      // then it will start on top somewhere
      ypos = 0;
      xpos = random(0, width);
      xMove = random(-speed/2, speed/2);
      yMove = random(0, speed);
    } else if ( r < 0.5) {
      // then it will start on right somewhere
      xpos = width;
      ypos = random(0, height);
      xMove = random(-speed, 0);
      yMove = random(-speed/2, speed/2);
    } else if ( r < 0.75) {
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

  void update() {
    for (int i = 6; i >=0; i--) {
      xmemory[i+1] = xmemory[i];
      ymemory[i+1] = ymemory[i];
    }
    xpos += xMove;
    ypos += yMove;
    xmemory[0] = xpos;
    ymemory[0] = ypos;
  }
  void drawBubble() {
    for (int i = 0; i < 8; i++) {
      fill(255-(i * 25));
      ellipse(xmemory[i], ymemory[i], size, size);
    }
  }
  void checkOffScreen() {
    if (xpos > width || xpos < 0 || ypos > height || ypos < 0) {
      float r = random(0, 1);
      if (r < 0.25) {
        // then it will start on top somewhere
        ypos = 0;
        xpos = random(0, width);
        xMove = random(-speed/2, speed/2);
        yMove = random(0, speed);
      } else if ( r < 0.5) {
        // then it will start on right somewhere
        xpos = width;
        ypos = random(0, height);
        xMove = random(-speed, 0);
        yMove = random(-speed/2, speed/2);
      } else if ( r < 0.75) {
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
