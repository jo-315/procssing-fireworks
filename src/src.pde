Firework[] fireworks = new Firework[10];
boolean once;

void setup(){
  size(800, 800);
  fill(0, 18, 13);
  rect(0, 0, width, height);
  frameRate(60);
  smooth();
  for (int i = 0; i < fireworks.length; i++){
    fireworks[i] = new Firework();
  }
}

void draw(){
  noStroke();
  fill(0, 18, 13, 10);
  rect(0, 0, width, height);

  // crate new firework
  int random_int = int(random(0, 1) * 100);
  if (random_int < 5) {
  once = false;
    for (int i = 0; i < fireworks.length; i++){
      if((fireworks[i].hidden)&&(!once)){
        fireworks[i].launch();
        once = true;
      }
    }
  }

  for (int i = 0; i < fireworks.length; i++){
    fireworks[i].draw();
  }
}

class Firework{
  float x, y, oldX, oldY, ySpeed, targetX, targetY, explodeTimer, flareWeight, flareAngle, circleRadius;
  int flareAmount, duration;
  boolean launched,exploded,hidden;
  color flareColor;

  float initGravity = -50;
  float gravity = initGravity;

  Firework(){
    launched = false;
    exploded = false;
    hidden = true;
  }

  void draw(){
    // during raising
    if((launched)&&(!exploded)&&(!hidden)){
      launchMaths();
      strokeWeight(1);
      stroke(255);
      line(x,y,oldX,oldY);
    }

    // after explod
    if((!launched)&&(exploded)&&(!hidden)){
      checkIsFinshed();
      calcFlareSize();
      calcGravity();

      noStroke();
      strokeWeight(flareWeight);
      stroke(flareColor);
      fill(flareColor);
      for(int index = 0; index <= flareAmount; index++){
          pushMatrix();
          translate(x, y);
          ellipse(
            cos(radians(index*flareAngle))*explodeTimer,
            sin(radians(index*flareAngle))*explodeTimer + gravity - ySpeed,
            circleRadius,
            circleRadius
          );
          popMatrix();
       }
    }

    if((!launched)&&(!exploded)&&(hidden)){
      gravity = initGravity;
    }
  }

  void launch(){
    // set x point randomly
    x = oldX = targetX = noise(random(10)) * width;

    // set to 0
    y = oldY = height;

    // expload point
    targetY = 600 - noise(random(10)) * height * 3/4;

    ySpeed = random(4) + 1.5;
    flareColor = color(random(3)*50 + 105, random(3)*50 + 105, random(3)*50 + 105);
    flareAmount = ceil(random(30)) + 20;
    flareWeight = ceil(random(3));
    duration = ceil(random(4))*30 + 40;
    flareAngle = 360/flareAmount;
    launched = true;
    exploded = false;
    hidden = false;
  }

  void launchMaths(){
    oldX = x;
    oldY = y;
    if(dist(x,y,targetX,targetY) > 6) {
      x += (targetX - x)/2;
      y += -ySpeed;
    } else {
      explode();
    }
  }

  void explode(){
    circleRadius = 0;
    explodeTimer = 0;
    launched = false;
    exploded = true;
    hidden = false;
  }

  void checkIsFinshed(){
    if(explodeTimer < duration){
      explodeTimer += 0.4;
    }else{
      hide();
    }
  }

  void calcFlareSize() {
    if(explodeTimer < duration/2){
      circleRadius = explodeTimer / 80;
    } else {
      circleRadius = (duration - explodeTimer) / 100;
    }
  }

  void hide(){
    launched = false;
    exploded = false;
    hidden = true;
  }

  void calcGravity() {
    gravity += 0.3;
  }
}
