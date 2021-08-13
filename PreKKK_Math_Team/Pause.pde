
public class Pause {

  int size;
  
  final PVector sizeOfButtons = new PVector( width*.66228571429, height*.10);

  PVector cords;
  //index 0 is resume, 1 is menu, 2 is restart
  Button[] allButtons;
  PImage pauseButton;

  PImage background;


  public Pause() {

    size = width/7;
    cords = new PVector(width/7*6, height/100);

    allButtons = new Button[3];
    allButtons[0] = new Button("resume.png", new PVector(width*.1628571429, height*.315),sizeOfButtons);
    allButtons[1] = new Button("menu button.png", new PVector( width*.1628571429, height*.50),sizeOfButtons);
    allButtons[2] = new Button("restart.png", new PVector(width*.1628571429, height*.675),sizeOfButtons);

    pauseButton = loadImage("pause.png");

    //resume = loadImage("resume.png");
    //menu = loadImage("menu button.png");
    //restart = loadImage("restart.png");
    background = loadImage("menu without music.png");
  }
  public void checkCollision()
  {
    if (mousePressed && mouseX >=cords.x && mouseX <= cords.x + size && mouseY >= cords.y && mouseY < cords.y + size)
    {
       gamestate = 3;
    }
    if (gamestate == 3)
    {
      for (int i = 0; i < allButtons.length; i ++) {
        if(allButtons[i].checkCollision())
        {
         if(i==0)
         {
           gamestate = 1;
         }
         else if( i ==1)
         {
           reset();
          gamestate = 0;
          delay(100);
         }
         else
         {
           reset();
           gamestate = 1;
         }
        }
        
      }
    }
  }

  public void display()
  {
    if (gamestate == 3)
    {
      image(background, width*.1428571429, height*.15, width*.7142857143, height*.75);
      for (int i = 0; i < allButtons.length; i ++) {
        allButtons[i].display();
      }
      
    } else
    {
      image(pauseButton, cords.x, cords.y, size, size);
    }
  }
}