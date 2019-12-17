class Window {
  Book cBook;
  Page cPage;
  
  boolean buttonOver;
  color buttonColor;
  color buttonHighlight;
  
  boolean button2Over;
  color button2Color;
  color button2Highlight;
  
  int buttonWidth = width/15;
  int buttonHeight = height/5;
  int buttonX = width/50;
  int button2X = width-buttonWidth-width/50;
  int buttonY = height/2-buttonHeight+width/25;
  
  boolean buttonClicked;
  boolean button2Clicked;
  
  public Window(Book b) {
    cBook = b;
    cPage = cBook.pages[cBook.getCurPage()-1];
    
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
    
    
    //displays p's data and cBook's title
    //p's data is the text and image
    //button2X-width/25
    background(cPage.bgColor);
    cPage.illustration.resize(button2X-(width/25)-buttonX-buttonWidth-width/25, height*79/100);
    image(cPage.illustration, buttonX+buttonWidth+width/25, height*3/50);

    //universal shapes for every page
    noStroke();
    fill(192, 192, 192);
    rect(0, 0, width, height*3/50);
    rect(0, height*17/20, width, height*3/20);
    
    //title text
    surface.setTitle("Book: "+cBook.getTitle());
    textSize(60/sqrt(cBook.getTitle().length()));
    fill(50, 50, 50);
    text(cBook.getTitle(), width/2-(width/20), height/20);
   
    //page text
    textSize(125/sqrt(cPage.text.length()));
    fill(0, 102, 153);
    text(cPage.text, (width*3/20)-cPage.text.length(), (height*490/500)-cPage.text.length());
   
    //back and forth arrows (visible dependent on page)
    //i.e. on page 1, no back arrow, on last page, no forward arrow
    boolean forward = true;
    boolean back = true;
    if(cBook.getCurPage() == 1) { //maybe implement title page to remove 0-based indexing
       back = false;
    }
    if(cBook.getCurPage() == cBook.getTotalPages()) {
       forward = false;
    }
    
    //displaying buttons
    stroke(0, 0, 0);
    fill(192, 192, 192);
    if(back) {
      if(!buttonClicked) {
        fill(buttonColor);
        triangle(buttonX, buttonY+(buttonHeight/2), buttonX+buttonWidth, buttonY+buttonHeight, buttonX+buttonWidth, buttonY);
      } else {
        fill(buttonHighlight);
        triangle(buttonX, buttonY+(buttonHeight/2), buttonX+buttonWidth, buttonY+buttonHeight, buttonX+buttonWidth, buttonY);
      }
    }
    if(forward) {
      if(!button2Clicked) {
        fill(button2Color);
        triangle(button2X, buttonY, button2X, buttonY+buttonHeight, button2X+buttonWidth, buttonY+(buttonHeight/2)); 
      } else {
        fill(button2Highlight);
        triangle(button2X, buttonY, button2X, buttonY+buttonHeight, button2X+buttonWidth, buttonY+(buttonHeight/2));
      }
    }
    update();
    //add home button
  }
  
  void mousePressed() {
    if(buttonOver) {
      buttonClicked = true; 
    } else if (button2Over) { //<>//
      button2Clicked = true; 
    }
  }
  void mouseReleased() {
    if(buttonOver) {
      buttonClicked = false; 
      updatePage(0);
    }
    if(button2Over) {
      button2Clicked = false;
      updatePage(1);
    }
  }
  
  //id is 0 or 1 (back arrow or forward)
  void updatePage(int id) {
    if(id==0) {
      //process click 
      //back
      cBook.setCurPage(cBook.getCurPage()-1);
      cPage = cBook.pages[cBook.getCurPage()-1];
    } else {
      //process click
      //forward
      cBook.setCurPage(cBook.getCurPage()+1);
      cPage = cBook.pages[cBook.getCurPage()-1];
    }
  }
  
  void update() {
    if(get(mouseX, mouseY) == buttonColor || get(mouseX, mouseY) == buttonHighlight) {
      buttonOver = true;
      button2Over = false;
    } else if(get(mouseX, mouseY) == button2Color || get(mouseX, mouseY) == button2Highlight) {
      button2Over = true;
      buttonOver = false;
    } else {
      buttonOver = false;
      button2Over = false;
    }
  }
}
