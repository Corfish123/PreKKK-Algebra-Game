public class Player {

  int x;
  int y;
  int pWidth;
  int pHeight;

  int oldY;
  int tempY;


  int leftNum;
  int rightNum;

  int addObstacles;
  ArrayList<Obstacle> allObstacles;

  boolean isDead;
  boolean shouldUpdate;

  String correctOperator;

  Player(int inX, int inY) {

    x = inX;
    y = inY;

    oldY = y;
    pWidth = 2 * height/8;
    pHeight = height/8;

    tempY = -pWidth;

    getNumbers();
    isDead = false;
    shouldUpdate = false;

    allObstacles = new  ArrayList<Obstacle>();
     for(int i = 0; i < 4; i++){
      allObstacles.add(new Obstacle(width, lanes[i] * height/16, operands[i]));
      }

    addObstacles = 0;

    getCorrectOperator();
  }
  void getCorrectOperator() {

    if (leftNum + rightNum == desiredNum) 
    {
      correctOperator = "+";
      
    }
    else if (leftNum - rightNum == desiredNum) {
      correctOperator = "-";
    }
    else if (leftNum * rightNum == desiredNum) {
      correctOperator = "*";
    }
    else
    //(leftNum / rightNum == desiredNum)
    {
      correctOperator = "/";
    }
   // println(leftNum + " " + rightNum);
   // println(correctOperator);
  }
  void checkCollision() {

    for (int i = 0; i < allObstacles.size(); i++)
    {
      Obstacle current = allObstacles.get(i);

      if (current.y == y && current.x < x + pWidth && current.x + current.diam > x) 
      {
        //addition
        if (current.operator.equals(correctOperator))
        {
          allObstacles.remove(i);
          numCorrect++;
          shouldUpdate = true;
        } else {
 //         print("im dying");
  //         println("obstcal " + allObstacles.get(i).operator);
   //       println(leftNum + " " + rightNum);
          
          
          isDead = true;
        }


        ////subtraction
        //if (current.operator == "-")
        //{
        //  if (leftNum - rightNum == desiredNum) {
        //    allObstacles.remove(i);
        //    numCorrect++;
        //    shouldUpdate = true;
        //  } else {
        //    isDead = true;
        //  }
        //}
        ////multiplication
        //if (current.operator == "*")
        //{
        //  if (leftNum * rightNum == desiredNum) {
        //    allObstacles.remove(i);
        //    numCorrect++;
        //    shouldUpdate = true;
        //  } else {
        //    isDead = true;
        //  }
        //}

        ////division
        //if (current.operator == "/")
        //{
        //  if (leftNum / rightNum == desiredNum) {
        //    allObstacles.remove(i);
        //    numCorrect++;
        //    shouldUpdate = true;
        //  } else {
        //    isDead = true;
        //  }
        //}
      }
    }
  }

  void display() {


    displayRect(y);
    if (moveDown) {

      y += speedDown;
      if (y > oldY + height/4) {

        y = oldY + height/4;
        oldY = y;
        moveDown = false;
      }
    }

    if (y + pHeight > height) {

      displayRect(tempY);

      y += speedDown;
      tempY += speedDown;

      if (tempY >height/16) {
        tempY = -pWidth;

        y = height/16;

        oldY = y;
        moveDown = false;
      }
    }
  }

  void displayRect(int y) {

    fill(255);
    rect(x, y, pWidth, pHeight);
    fill(0);
    line(x + pWidth/2, y, x + pWidth/2, y + pHeight);

    textSize(width/24);
    text("" + leftNum, x + pWidth/4, y + pHeight * .55); 
    text("" + rightNum, x + 3 *pWidth/4, y + pHeight * .55);
  }
  void displayObstacles() {

    for (int i =0; i < allObstacles.size(); i++)
    {
      allObstacles.get(i).display();
    }
  }

  void spawnObstacles() {


    addObstacles+= speed;

    //spawn row
    if (addObstacles % (width * 3) < speed) {

      for(int i = 0; i < 4; i++){
      allObstacles.add(new Obstacle(width, lanes[i] * height/16, operands[i]));
      }
    }
    else if(addObstacles % (width/2) < speed){
      
       int operationType = (int)(Math.random()*4);
       
       allObstacles.add(new Obstacle(width, lanes[operationType] * height/16, operands[operationType]));
    }
    
    
  }
  void update() {

    if (shouldUpdate) {

      //check to see if any obstacles are behind the car so do not check them later when they hit the end 
      for (int i =0; i < allObstacles.size(); i++)
      {
        if ( allObstacles.get(i).x <= x + pWidth)
        {
          allObstacles.get(i).checkMissed = false;
        }
      }

      score++;
      numCorrect++;
      
      getNumbers();
       getCorrectOperator();
    }

    //update obstacles
    for (int i =0; i < allObstacles.size(); i++)
    {
      allObstacles.get(i).updateX();

      if (allObstacles.get(i).checkMissed && allObstacles.get(i).x + allObstacles.get(i).diam<0) {
        if (correctOperator.equals(allObstacles.get(i).operator)) {
          
    //      print("wtf");
          
    //      println(allObstacles.get(i).operator);
     //     println(leftNum + " " + rightNum);
          
          isDead = true;
        } else {

          allObstacles.remove(i);
        }
      }
    }
  }
  boolean isDead() {
    return isDead;
  }

  void getNumbers() {

    if (numCorrect %10 == 0 && numCorrect != 0) {
      maxVal+=20;
      desiredNum = (int)random(0, maxVal);
      numCorrect++;
      speed++;
    }
    int random = (int)random(0, 4);
    corrOperand = operands[random];

    if (random == 0) {

      leftNum = (int)random(-100, 100); 
      rightNum = desiredNum-leftNum;
    }
    if (random == 1) {

      rightNum = (int)random(-100, 100);
      leftNum = desiredNum+rightNum;
    }
    if (random == 2) {

      rightNum = (int)random(-100, 100);
      leftNum = desiredNum * rightNum;
    }
    if (random == 3) {

      rightNum =  (int)random(-100, 100);
      if (rightNum == 0) {
        rightNum = 1;
      }
      leftNum = desiredNum / rightNum;

      do {
        rightNum =  (int)random(-desiredNum, desiredNum);
        if (rightNum == 0) {
          rightNum = 1;
        }
        leftNum = desiredNum / rightNum;
      } while (leftNum* rightNum != desiredNum);
    }

    shouldUpdate = false;
  }


  public class Obstacle {
    int x;
    int y;
    int diam;
    String operator;
    boolean checkMissed;



    public Obstacle(int xLoc, int yLoc, String op) {

      x = xLoc;
      y = yLoc;
      diam = width/8;
      operator = op;
      checkMissed = true;
    }

    void updateX() {

      x -=speed;
    }
    void display() {
      fill(255);
      ellipse(x, y, diam, diam);
      textt(operator, x, y+(diam/3), diam, diam, color(0), diam/3, CENTER);
      fill(255);
    }
  }
}