class Library {
  // is it possible to search? will be determined later but keep it in mind
  ArrayList<Book> books;
  int currentPage;

  public Library() {
    books = new ArrayList<Book>();
    spot = 0;
    columns = 2;
    currentPage = 0;
    
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
  int getCurrentPage(){
    return currentPage;
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
           currentPage++;
        }
        delay(50);
      }
      triangle(0.93*width, 0.45*height, 0.97*width, 0.5*height, 0.93*width, 0.55*height); //<>//
    }
    if(spot>0) {
      fill(253, 253, 253);
      if (mousePressed){
        color c = get(mouseX, mouseY);
        if (c == color(253, 253, 253)){
          fill(50, 50, 50);
          spot--;
          currentPage--;
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
      if (mousePressed){
    // top left corner button
      if (mouseX > 78 && mouseX < 214 && mouseY > 99 && mouseY < 241){
        inLibrary = false;
        println("top left is pressed");
        /*if (currentPage == 1){
          w.setBook(books.get(0));
          w.drawWindow();
        }*/
        ArrayList<Book> topLeftBooks = new ArrayList<Book>();
        for (int i = 0; i < books.size(); i++){
          if (i % 4 == 0){
            topLeftBooks.add(books.get(i));
          }
        }
        for (int i = 0; i < topLeftBooks.size(); i++){
          println(topLeftBooks.get(i).getTitle());
        }
        println ("Current page: " + currentPage);
        w.setBook(topLeftBooks.get(currentPage));
        println ("Book: " + topLeftBooks.get(currentPage).getTitle()); 
        w.drawWindow();
      }
      if (mouseX > 289 && mouseX < 427 && mouseY > 99 && mouseY < 241){
        inLibrary = false;
        println("top right is pressed");
        ArrayList<Book> topRightBooks = new ArrayList<Book>();
        for (int i = 0; i < books.size(); i++){
          if (i % 4 == 1){
            topRightBooks.add(books.get(i));
          }
        }
        for (int i = 0; i < topRightBooks.size(); i++){
          println(topRightBooks.get(i).getTitle());
        }
        w.setBook(topRightBooks.get(currentPage));
        w.drawWindow();
      }
      if (mouseX > 78 && mouseX < 214 && mouseY > 314 && mouseY < 453) println("button pressed");
      if (mouseX > 289 && mouseX < 427 && mouseY > 314 && mouseY < 453) println("button pressed");
     }
  }
}
