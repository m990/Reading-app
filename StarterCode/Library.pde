class Library {
  // is it possible to search? will be determined later but keep it in mind
  ArrayList<Book> books;

  public Library() {
    books = new ArrayList<Book>();
    spot = 0;
    columns = 2;
    
    buttonColor = color(193, 193, 193);
    button2Color = color(194, 194, 194);
    buttonHighlight = color(96, 96, 96);
    button2Highlight = color(97, 97, 97);
    buttonOver = false;
    button2Over = false;
    
    buttonClicked = false;
    button2Clicked = false;
  }
  int spot;
  int columns;

  boolean buttonOver;
  boolean button2Over;
  color buttonColor;
  color button2Color;
  color buttonHighlight;
  color button2Highlight;
  
  boolean buttonClicked;
  boolean button2Clicked;
  
  public Library(ArrayList<Book> books){
    this.books = books;
    spot = 0;
    columns = 2;
    
    buttonColor = color(193, 193, 193);
    button2Color = color(194, 194, 194);
    buttonHighlight = color(96, 96, 96);
    button2Highlight = color(97, 97, 97);
    buttonOver = false;
    button2Over = false;
    
    buttonClicked = false;
    button2Clicked = false;
  }
  ArrayList<Book> getBooks(){
    return books;
  }
  void addBook(Book b){
    books.add(b);
  }
  Book getBook(int bookNumber){
    return books.get(bookNumber);
  }
  Book getBookWithName(String bookName) {
    for (Book b:books) {
      if (b.getTitle().equals(bookName)) {
        return b; 
      }
    }
    return null;
  }
  //draws the library
  void drawLibrary(){
    boolean changed = false;
    if(8*spot+8<getBooks().size()) {
      fill(254, 254, 254);
      if (mousePressed){
        color c = get(mouseX, mouseY);
        if (c == color(254, 254, 254)){
           fill(1, 1, 1);
           spot++;
           changed = true;
        }
        delay(50);
      }
      triangle(0.93*width, 0.45*height, 0.97*width, 0.5*height, 0.93*width, 0.55*height);
    }
    if(spot>0) {
      fill(253, 253, 253);
      if (mousePressed){
        if(mouseX>460&&mouseX<490&&mouseY>460&&mouseY<490){
          println("privyet");
        }
        color c = get(mouseX, mouseY);
        if (c == color(253, 253, 253)){
          fill(50, 50, 50);
          spot+=-1;
          changed = true;
        } 
      delay(50);
      }
      triangle(0.07*width, 0.45*height, 0.03*width, 0.5*height, 0.07*width, 0.55*height);
      fill(255, 255, 255);
    }
    
    // Your library sign
    // 1/30th (1/3 of 1/10 of height)
    textSize((int) ((double)1 / (double)15 * (double)height));
    text("Your Library", (int)((double)1/(double)40 * (double)width), (int)((double)3/(double)40 * (double)height));
    // Line
    fill(255, 255, 2500);
    stroke(126);
    // Line across screen at 10% down
    line(0, (int)((double)height/(double)10), width, (int)((double)height/(double)10));
    // Books
    int newHeight = height - (int)((double)height/(double)10);
    int xOffset = (int) ((double) 1/2 * (double) (width - (double) 285/columns - (((double) (2*columns-1)*428)/columns)));
    int yOffset = (int)((double)height/10) + (int) ((double) 1/2 * (double) (newHeight - (double) 285/columns - (double) (columns-1)* (double) 428/columns));
    for(int i = 0; i < 8 && 8*spot+i < books.size(); i++){
      PImage cover = books.get(8*spot+i).getCoverImg();
      cover.resize(285/columns, 285/columns);
        image(cover, xOffset+(i % (2*columns)) * 428/columns, yOffset+(i - (i % (2*columns)))/(2 * columns) * 428/columns);
    }
    if(changed == true){
      background(0,0,0);
      drawLibrary();
    }
    circle(475, 475, 30);
    
  }
}
