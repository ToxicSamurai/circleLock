//By ToxicSamurai
//Licensed under Creative Commons CC-BY-NC-SA

//Vars for transformation
int x = 400;
int y = 400;

//Vars for rotation
float r1 = 0;
float r2 = 0;
float r3 = 0;
float r4 = 0;

//Vars for locking line slope and line location (Unused currently)
float x2, y2;
float x4, y4;
float x6, y6;
float x8, y8;
float slope1, slope2, slope3, slope4;

//Vars for the open and close points for the red arcs
float smallArcOpen1 = 0;
float smallArcClose1 = HALF_PI;
float smallArcOpen2 = HALF_PI;
float smallArcClose2 = PI;
float smallArcOpen3 = PI;
float smallArcClose3 = PI + HALF_PI;
float smallArcOpen4  = PI + HALF_PI;
float smallArcClose4 = TWO_PI;

//Random var for random rotation
float rand = random(3);

//Floats for simplification (unused)
float angle1 = PI/4+r1;
float angle2 = PI/4+r2+smallArcOpen2;
float angle3 = PI/4+r3+smallArcOpen3;
float angle4 = PI/4+r4+smallArcOpen4;

//Float for tolerance for locking
float tolerance = 1;

//Boolean to control locking/random movement
boolean lockFlag1to2 = false;
boolean lockFlag2to3 = false;
boolean lockFlag3to4 = false;

void setup() {
  size(800, 800);
  smooth();
  //Slows the framerate
  frameRate(4);
}

void draw() {
  background(255);

  //Function list
  randR();
  setEven();
  slope();
  lock();
  circles();
  lines();
  arcOne();
  arcTwo();
  arcThree();
  arcFour();

  //Debug printing
  //println("x2 + y2:", x2, y2);
  println("s1 + s2:", slope1, slope2);
  println("r1 + r2", r1, r2);
}

//Function that sets the even variables for the locking lines
void setEven() {
  //r(cos(theta))
  //r(sin(theta))
  //x2 and y2 returns 435.35535, while it should be 435.35534

  x2 = 50*(cos(PI/4+r1)) + x;
  y2 = 50*(sin(PI/4+r1)) + y;
  x4 = 125*(cos(PI/4+r2+smallArcOpen2)) + x;
  y4 = 125*(sin(PI/4+r2+smallArcOpen2)) + y;
  x6 = 200*(cos(PI/4+r3+smallArcOpen3)) + x;
  y6 = 200*(sin(PI/4+r3+smallArcOpen3)) + y;
  x8 = 275*(cos(PI/4+r4+smallArcOpen4)) + x;
  y8 = 275*(sin(PI/4+r4+smallArcOpen4)) + y;

  //println(angle1-angle2);
}

//Function that sets the slope variables equal to the line slopes
void slope() {
  slope1 = (y2-y)/(x2-x);
  slope2 = (y4-y)/(x4-x);
  slope3 = (y6-y)/(x6-x);
  slope4 = (y8-y)/(x8-x);
}

//Function for locking the arcs (Doesn't work yet (maybe))
void lock() {
  //Unused for now
  //Takes the absolute value of the slopes and sees if the difference is less than the tolerance var
  if (Math.abs(slope1 - slope2) < tolerance) {
    if (rotationCheck(r1, r2) == true) {
      //Sets locking boolean to true
      lockFlag1to2 = true;
    }
  }
}

//Function for random rotation
void randR() {
  /*
  rand = random(0, 5);
   
   if (rand >= 0 && rand < 1) {
   r1 = r1 + 1;
   }
   if (rand >= 1 && rand < 2) {
   r1 = r1 - 1;
   }
   
   if (rand >= 1 && rand < 2) {
   r2 = r2 + 1;
   }
   if (rand >= 2 && rand < 3) {
   r2 = r2 - 1;
   }
   
   if (rand >= 2 && rand < 3) {
   r3 = r3 + 1;
   }
   if (rand >= 3 && rand < 4) {
   r3 = r3 - 1;
   }
   
   if (rand >= 3 && rand < 4) {
   r4 = r4 + 1;
   }
   if (rand >= 4 && rand < 5) {
   r4 = r4 - 1;
   }*/

  //Checks if the arcs are locked
  if (lockFlag1to2 == false) {
    //Generates a random number between 0 and 1
    float randFloat = random(0, 1);
    float randFloat2 = random(0, 1);
    float randFloat3 = random(0, 1);
    float randFloat4 = random(0, 1);

    //Transtales the number generated into radians and sets the rotation to random
    r1 = randFloat*(TWO_PI);
    r2 = randFloat2*(TWO_PI);
    r3 = randFloat3*(TWO_PI);
    r4 = randFloat4*(TWO_PI);
  }
}

//Function that draws the black stationary circles
void circles() {
  stroke(0);
  circle(width/2, height/2, 100);
  circle(width/2, height/2, 250);
  circle(width/2, height/2, 400);
  circle(width/2, height/2, 550);
}

//Function that draws the locking lines
void lines() {
  stroke(0);
  line(x, y, x2, y2);
  line(x, y, x4, y4);
  line(x, y, x6, y6);
  line(x, y, x8, y8);
}

//Function for the innermost arc circle and it's rotation
void arcOne() {
  //Settings for arc
  noFill();
  strokeWeight(10);
  stroke(255, 255, 0);

  //push
  push();

  //Translate and rotates the arc
  translate(x, y);
  rotate(r1);

  //Draws the arc
  arc(0, 0, 100, 100, smallArcOpen1, smallArcClose1);

  //pop
  pop();
}

//Function for the second innermost arc circle and it's rotation
void arcTwo() {
  stroke(255, 255, 0);

  push();

  translate(x, y);
  rotate(r2);

  arc(0, 0, 250, 250, smallArcOpen2, smallArcClose2);

  pop();
}

//Function for the second outermost arc circle and it's rotation
void arcThree() {
  stroke(255, 255, 0);

  push();

  translate(x, y);
  rotate(r3);

  arc(0, 0, 400, 400, smallArcOpen3, smallArcClose3);

  pop();
}

//Function for the outermost arc circle and it's rotation
void arcFour() {
  stroke(255, 255, 0);

  push();

  translate(x, y);
  rotate(r4);

  arc(0, 0, 550, 550, smallArcOpen4, smallArcClose4);

  pop();
}

boolean rotationCheck(float temp1, float temp2) {
  println("temp1 + 2:", temp1, temp2);
  if ((0 < temp1 && temp1 <= PI/2 && 0 < temp2 && temp2 <= PI/2) ||
    (PI/2 < temp1 && temp1 <= PI && PI/2 < temp2 && temp2 <= PI) ||
    (PI < temp1 && temp1 <= 1.5*(PI) && PI < temp2 && temp2 <= 1.5*(PI)) ||
    (1.5*(PI) < temp1 && temp1 <= TWO_PI && 1.5*(PI) < temp2 && temp2 <= TWO_PI))
  {
    return true;
  } else {
    return false;
  }
}

//9/9/21 (m/d/yy)
//Commented out old locking code
//Changed black rotating arcs to black constant circles
//Deleted vars for black rotating arcs opening and closing points
//Created vars for locking line location points and slope floats
//Created lines, but the second location vars aren't set
//Created function to set slope vars (finds slope)
//Moved circle drawing code into its own function

//9/10/21
//Simplified slope function
//Removed unused code
//Desimplified slope function
//Set second location vars to the midpoint constant location of the arcs

//9/13/21
//Simplified setEven
//Implemented lock code (may (probably) not work (kinda works (not really)))
//Increased comment volume
//Found the midpoint of the arcs (r*(cos/sin(theta))) and set second location vars to them, but they're constant and need to be multiplied by the rotation matrix
//Converted theta in r*(cos/sin(theta)) to radians and fixed a major problem with the calculation of the midpoint

//9/21/21
//Changed stroke color for visibility
//Changed locking function
//Changed midpoint formula to r(cos(pi/4+rotation+arc opening radius))
//Changed line function
//Created pop and push functions for the arcs
//Created new random movement function
//Created tolerance var, booleans for locking
//Removed redundant x1, x3, x5, x7, y1, y3, y5, y7 vars
