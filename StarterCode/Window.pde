class Window {
  DummyBook cBook;
  DummyPage p;
  
  boolean buttonOver;
  boolean button2Over;
  color buttonColor;
  color button2Color;
  color buttonHighlight;
  color button2Highlight;
  
  int buttonWidth = width/15;
  int buttonHeight = height/5;
  int buttonX = width/50;
  int button2X = width-buttonWidth-width/50;
  int buttonY = height/2-buttonHeight+width/25;
  
  boolean buttonClicked;
  boolean button2Clicked;
  
  public Window(DummyBook b) {
    cBook = b;
    p = cBook.pages[cBook.getCurPage()-1];
    
    buttonColor = color(193, 193, 193);
    button2Color = color(194, 194, 194);
    buttonHighlight = color(96, 96, 96);
    button2Highlight = color(97, 97, 97);
    buttonOver = false;
    button2Over = false;
    
    buttonClicked = false;
    button2Clicked = false;
  }
  
  void draw() {
    update();
    mousePressed();
    
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
    if(cBook.getCurPage() == 1) {
       back = false;
    }
    if(cBook.getCurPage() == cBook.getTotalPages()) {
       forward = false;
    }
    //currently won't display arrows because there is only 1 page
    //add interaction when clicking arrow
    //^ should set currentpage of book to cur+1
    //call display again
    if(back) {
      if(!buttonClicked) {
        fill(buttonColor);
        triangle(buttonX, buttonY+(buttonHeight/2), buttonX+buttonWidth, buttonY+buttonHeight, buttonX+buttonWidth, buttonY);
      } else if(buttonOver && buttonClicked) {
        fill(buttonHighlight);
        triangle(buttonX, buttonY+(buttonHeight/2), buttonX+buttonWidth, buttonY+buttonHeight, buttonX+buttonWidth, buttonY);
        updatePage(0);
      }
    }
    if(forward) {
      if(!button2Clicked) {
        fill(button2Color);
        triangle(button2X, buttonY, button2X, buttonY+buttonHeight, button2X+buttonWidth, buttonY+(buttonHeight/2)); 
      } else if(button2Over && button2Clicked) {
        
        fill(button2Highlight);
        triangle(button2X, buttonY, button2X, buttonY+buttonHeight, button2X+buttonWidth, buttonY+(buttonHeight/2));
        updatePage(1);
      }
       
    }
    
    //add home button
  }
  
  void mousePressed() {
    System.out.println("hi");
    if(buttonOver) {
      buttonClicked = true; 
    } else if (button2Over) {
      System.out.println("forward click");
      button2Clicked = true; 
    }
  }
  
  //id is 0 or 1 (back arrow or forward)
  void updatePage(int id) {
    if(id==0) {
      //process click 
      //back
      cBook.setCurPage(cBook.getCurPage()-1);
      p = cBook.pages[cBook.getCurPage()-1];
    } else {
      //process click
      //forward
      cBook.setCurPage(cBook.getCurPage()+1);
      p = cBook.pages[cBook.getCurPage()-1];
    }
  }
  
  void update() {
    if(get(mouseX, mouseY) == buttonColor || get(mouseX, mouseY) == buttonHighlight) {
      //System.out.println("--");
      buttonOver = true;
      button2Over = false;
    } else if(get(mouseX, mouseY) == button2Color || get(mouseX, mouseY) == button2Highlight) {
      System.out.println("--");
      button2Over = true;
      buttonOver = false;
    } 
    else {
      buttonOver = false;
      button2Over = false;
    }
  }
  //add actionlistener to advance to next page
}
