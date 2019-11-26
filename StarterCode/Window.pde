class Window {
  DummyBook cBook;
  
  boolean buttonOver;
  color buttonColor;
  color buttonHighlight;
  public Window(DummyBook b) {
    cBook = b;
    
    buttonColor = color(193, 193, 193);
    buttonHighlight = color(96, 96, 96);
    buttonOver = true;
  }
  
  void display(DummyPage p) {
    int buttonWidth = width/15;
    int buttonHeight = height/5;
    int buttonX = width/50;
    int button2X = width-buttonWidth-width/50;
    int buttonY = height/2-buttonHeight+width/25;
    
    update();
    
    //displays p's data and cBook's title
    //p's data is the text and image
    background(p.c);
    p.pic.resize(100, 100);
    image(p.pic, 225, 50);
   

    //universal shapes for every page
    noStroke();
    fill(192, 192, 192);
    rect(0, 0, 500, 30);
    rect(0, 425, 500, 75);
    
    //title text
    surface.setTitle("Book: "+cBook.getTitle());
    textSize(32);
    fill(50, 50, 50);
    text(cBook.getTitle(), 225, 25);
   
    //page text
    textSize(125/sqrt(p.text.length()));
    fill(0, 102, 153);
    text(p.text, 75-p.text.length(), 490-p.text.length());
   
    //back and forth arrows (visible dependent on page)
    //i.e. on page 1, no back arrow, on last page, no forward arrow
    stroke(0, 0, 0);
    fill(192, 192, 192);
    boolean forward = true;
    boolean back = true;
    if(cBook.getCurPage() == 0) {
       back = false;
    }
    if(cBook.getCurPage() == cBook.getTotalPages()) {
       forward = true;
    }
    //currently won't display arrows because there is only 1 page
    //add interaction when clicking arrow
    //^ should set currentpage of book to cur+1
    //call display again
    if(back) {
       if(buttonOver) {
        fill(buttonHighlight);
        triangle(buttonX, buttonY+(buttonHeight/2), buttonX+buttonWidth, buttonY+buttonHeight, buttonX+buttonWidth, buttonY);
      } else {
        fill(buttonColor);
        triangle(buttonX, buttonY+(buttonHeight/2), buttonX+buttonWidth, buttonY+buttonHeight, buttonX+buttonWidth, buttonY);  
     }
    }
    if(forward) {
      if(buttonOver) {
        fill(buttonHighlight);
        triangle(button2X, buttonY, button2X, buttonY+buttonHeight, button2X+buttonWidth, buttonY+(buttonHeight/2));
      } else {
        fill(buttonColor);
        triangle(button2X, buttonY, button2X, buttonY+buttonHeight, button2X+buttonWidth, buttonY+(buttonHeight/2));  
     }
    }
    
    //add home button
  }
  
  void mousePressed() {
    if(buttonOver) {
      //process click 
    }
  }
  
  void update() {
    if(get(mouseX, mouseY) == buttonColor || get(mouseX, mouseY) == buttonHighlight) {
      buttonOver = true;
    } else {
      buttonOver = false;
    }
  }
  //add actionlistener to advance to next page
}
