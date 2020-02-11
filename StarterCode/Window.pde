class Window {
  Library l;
 
  Book cBook;
  Page cPage;
  
  color buttonColor;
  color buttonHighlight;
  color button2Color;
  color button2Highlight;
  
  int firstPage;
  float buttonWidth = width/15;
  float buttonHeight = height/5;
  float buttonX = width/50;
  float button2X = width-buttonWidth-width/50;
  float buttonY = height/2-buttonHeight+width/25;
  float homeX = width/100;
  float homeY = height/100;
  float homeWidth = width/25;
  float homeHeight = height/25;
  
  boolean hasPlayedFirstSound = false;

  boolean buttonOver;
  boolean button2Over;

  boolean buttonClicked;
  boolean button2Clicked;
  boolean homeOver;
  boolean homeClicked;
  
  PImage homeIcon;
  
  boolean stay;
  
  Statistics stat;
  public Window(Book b) {
    firstPage = 1;
    stat = new Statistics();
    cBook = b;
    cPage = cBook.pages[cBook.getCurPage()-1];
    
    buttonColor = color(193, 193, 193);
    button2Color = color(194, 194, 194);
    
    buttonHighlight = color(96, 96, 96);
    button2Highlight = color(97, 97, 97);
    
    buttonOver = false;
    button2Over = false;
    homeOver = false;
    
    buttonClicked = false;
    button2Clicked = false;
    homeClicked = false;
    
    homeIcon = loadImage("homeicon.png");
    
    stay = true;
  }
  
  void drawWindow() {
    //displays p's data and cBook's title
    //p's data is the text and image
    //button2X-width/25
    background(cPage.bgColor);
    cPage.illustration.resize((int)(button2X-(width/25)-buttonX-buttonWidth-width/25), (int)height*79/100);
    image(cPage.illustration, buttonX+buttonWidth+width/25, height*3/50);

    //universal shapes for every page
    noStroke();
    fill(192, 192, 192);
    rect(0, 0, width, height*3/50);
    rect(0, height*17/20, width, height*3/20);
    
    // play first sound
    if (!hasPlayedFirstSound) {
     hasPlayedFirstSound = true;
     if (cPage.getAudio() != null) {
       cPage.getAudio().startSound();
     }
    }
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
       stat.numBooksRead++;
    }
     //<>//
    //displaying buttons //<>//
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
    //home button
    if(!homeClicked) {
      fill(#4a4444);
    } else {
      fill(#363232);
    }
    rect((float) width/100, (float) height/100, (float) width/25, (float) height/25);
    homeIcon.resize(width/25, height/25);
    image(homeIcon, homeX, homeY);
    
    update();
  }

  void mousePressed() {
    if(buttonOver) {
      buttonClicked = true; 
    } else { //<>//
      buttonClicked = false;  //<>//
    }
    if(button2Over) {
      button2Clicked = true; 
    } else {
      button2Clicked = false; 
    }
    if(homeOver) {
      homeClicked = true; 
    } else {
      homeClicked = false; 
    }
  }
  void mouseReleased() {
    buttonClicked = false;
    button2Clicked = false;
    homeClicked = false;
    if(buttonOver) {
      updatePage(0);
      stat.numPagesRead--;
    }
    if(button2Over) {
      updatePage(1);
      stat.numPagesRead++;
    }
    if(homeOver) {
      //have functionality to return to library
      //l.drawLibrary();
      stay = false;
    }
  }
  
  //id is 0 or 1 (back arrow or forward)
  void updatePage(int id) {
    if(id==0) {
      //process click 
      //back
      cBook.setCurPage(cBook.getCurPage()-1);
      cPage = cBook.pages[cBook.getCurPage()-1];
      // Play the new sound and stop the old one (-1 because array doesn't start at 1)
      cBook.pages[cBook.getCurPage()].stopSound();
      cBook.pages[cBook.getCurPage() - 1].playSound();
    } else {
      //process click
      //forward
      cBook.setCurPage(cBook.getCurPage()+1);
      cPage = cBook.pages[cBook.getCurPage()-1];
      // Play the new sound and stop the old one
      cBook.pages[cBook.getCurPage() - 2].stopSound();
      cBook.pages[cBook.getCurPage() - 1].playSound();
    }
  }
  public int ReadPages(){
    return stat.PagesRead();
  }
  public int ReadBooks(){
    return stat.BooksRead();
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
    if(homeX <= mouseX && mouseX <= homeX+homeWidth && 
       homeY <= mouseY && mouseY <= homeY+homeHeight) {
      homeOver = true;
    } else {
      homeOver = false;
    }
  }
  
  boolean getStay() {
    return stay;
  }
}
