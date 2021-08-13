int backgroundRed = 0;
int backgroundBlue = 208;
int backgroundGreen = 255;
int score = 0;
int desiredNum = (int)random(0, 20);

int numCorrect = 0;
int gamestate = 0;
int highscore = 0;
PImage gameoverSign;
PImage[] logo;
int laneWidth;
int speed;
int speedDown;
int backgroundCounter = 0;

boolean moveDown = false;

int maxVal =20;
String corrOperand;
String[] operands = {"+", "-", "*", "/"};
int[] lanes = {1,5,9,13};

PImage carImage;

boolean showDesiredNumber = true;

Player player;
//pause button
Pause pause;

int startTime = 10000;
//menu
Menu menu;

PImage tempCar;

void setup() {

  fullScreen();
 // size(600, 800);
  ellipseMode(CORNER);
  rectMode(CORNER);

  speed = width / 300;
  logo = new PImage[4];
  player = new Player(0, height/16);

  //setup logo
  for (int i = 0; i < logo.length; i++) {
    String filename = "startScreen" + i + ".gif";
    logo[i] = loadImage(filename);
  }
  pause = new Pause();
  menu = new Menu();

  laneWidth = height/4;

  gameoverSign = loadImage("gameover.png");
  maxVal = 20;

  carImage = loadImage("car.jpg");

  speedDown = height / 100;

  gameoverSign = loadImage("gameover.png");
}

void draw() {

  //create logo
  if (gamestate == 1000)
  {
    createLogo();


    //menu
  } else if (gamestate == 0)
  {
    // image(startScreen, 0, 0, width, height);
    menu.display();
    menu.checkCollision();
  } else if (gamestate == 1)
  {
    if (!showDesiredNumber) {

      drawBackground();
      player.display();
      player.checkCollision();
      player.displayObstacles();
      player.update();
      player.spawnObstacles();
    } else
    {
        background(0, 208, 255);

      fill(255);
      textSize(width/15);

      text("Your Desired Number is " + desiredNum, width/10, height/2);
    }
    
    if (player.isDead)
    {
      gamestate =2;
      println("player " + player.correctOperator);
      println("desire " + desiredNum);
    }
  } else if (gamestate == 2) {

    if (score > highscore)
    {
      highscore = score;
    }

  //  background(230, 50, 60);
  background(0);
    fill(255);

    image(gameoverSign, width * .14285714, height * .1, width * .7142857, .14 *width * .7142857);

    image(menu.highscoreIcon, width*.2, height*.35, width * .132, width * .132);

    fill(255);
    textAlign(CENTER);
    textSize(width * .1);
    text(highscore, width*.23 + width * .264, height*.417 ); 

    textSize(width * .22);
    text(score, width*.23 + width * .264, height *.65 );

    //player dead
  } else if (gamestate == 3)//pause 
  {
    pause.display();
  }
}

void drawBackground() {

  background(backgroundRed, backgroundBlue, backgroundGreen);

  line(0, height/4, width, height/4);
  line(0, 2*height/4, width, 2*height/4);
  line(0, 3*height/4, width, 3*height/4);

if(frameCount % 200 == 0)
{
backgroundCounter++;
println(backgroundCounter);
}
  if (backgroundCounter%2 == 0 && backgroundCounter != 0)
  {
    backgroundCounter++;
    backgroundRed++;
  }
  if (backgroundCounter%2 == 0&& backgroundCounter != 0) {
    backgroundCounter++;
    backgroundBlue --;
  }

  if (backgroundCounter %5 == 0&& backgroundCounter != 0) {  
    backgroundCounter++;
    backgroundGreen --;
  }

  if (backgroundRed > 230)
  {
    backgroundRed =230;
  }
  if (backgroundBlue < 50)
  {
    backgroundBlue =50;
  }
  if (backgroundGreen < 60)
  {
    backgroundGreen =60;
  }
}

void createLogo()
{
  if (height>width)
  {
    background(0);
    float widthL = width * .7142857;
    image(logo[0], width * .14285714, height * .001, widthL, .7 *widthL );

    if (frameCount>=121)
    {
      //    streamId =  soundPool.play(1, 1.0, 1.0, 1, 0, 1f);
    }
    if (frameCount>=122)
    {
      image(logo[1], 0, 0, width, height);
    }
    if (frameCount>=126)
    {

      image(logo[2], 0, 0, width, height);
      image(logo[0], width * .14285714, height * .001, widthL, .7 *widthL );
      image(logo[4], width*.1428571429, height*.4, width*.7142857143, width*.7142857143);
      //      soundPool.stop(streamId);
    }
    if (frameCount>=170)
    {
      gamestate = 0;
    }
  }
}

void reset() {

  background(0);
  player.x = 0;
  player.y = height / 8;
  player.allObstacles.clear();

  score = 0;
  delay(200);
}

void textt(String t, float x, float y, float w, float h, color c, float s, int align) {
  fill(c); 
  textAlign(align); 
  textSize(s); 
  text(t, x, y, w, h);
}
void mousePressed() {

  if (gamestate ==1)
  {
    if (showDesiredNumber) {

      showDesiredNumber = false;
    } else {

      moveDown  = true;
    }
  }
}