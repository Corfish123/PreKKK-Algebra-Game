public class Button {
  
  PImage button;
  
  PVector cords;
  PVector size;
  
  Button(String image, PVector cor,PVector siz)
  {
    button = loadImage(image);
    cords = cor;
    size = siz;
  }
  public void display(){
    image(button, cords.x, cords.y, size.x, size.y);
  }
  public boolean checkCollision(){
    
        if(mousePressed && mouseX >=cords.x && mouseX <= cords.x + size.x && mouseY >= cords.y && mouseY < cords.y + size.y)
      {
        return true;
      }
      return false;
      
  }
}