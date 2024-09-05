//Classe bottoni
class Button
{
  PVector size;
  PVector position;
  String title;
  color button_color;
  boolean canHovered = true;
  boolean mouseIsPressed = false;
  boolean canHover = true;
  
  Button(PVector position, PVector size, String title, color col)
  {
    this.position = position;
    this.size = size;
    this.title = title;
    button_color = col;
  }
  void Draw()
  {
    noStroke();
    if (IsHovered() && canHovered && canHover)
    {
      fill(255, 0, 0, 255);
    } else
    {
      fill(button_color);
    }

    rect(position.x, position.y, size.x, size.y);
    fill(0);
    noStroke();
    textSize(25);
    textAlign(CENTER, CENTER);
    text(title, position.x+size.x/2, position.y+size.y/2);
  }

  boolean IsHovered()
  {
    if (mouseX > position.x && mouseX < position.x + size.x && mouseY > position.y && mouseY < position.y + size.y)
    {
      return true;
    }

    return false;
  }

  boolean OnClicked()
  {
    if(mousePressed)
    {
      if(mouseButton == LEFT && !mouseIsPressed)
      {
        if (IsHovered())
        {
          mouseIsPressed = true;
          return true;
        }
      }
      
    }
    else{
      mouseIsPressed = false;
    }
    return false;
  }
}
