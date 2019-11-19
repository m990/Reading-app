class Library {
  // is it possible to search? will be determined later but keep it in mind
  ArrayList<Book> books;
  
  Library(ArrayList<Book> books){
    this.books = books;
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
    int counterX = 0;
    int counterY = 0;
    for (Book b: books){
      PImage image = b.getImage();
      // See discord for width/height specs
      double w = (double)width*(.2);
      double h = (double)height*(.25);
      image.resize((int)w, (int)h);
      // First image's x location:
      double firstImgX = (double)width / (double)40;
      double firstImgY = (double)100 + (double)height / (double)40;
      image(image, (int)((double)firstImgX + (double) counterX * (double) width * (double) 1/4 ), (int)firstImgY);
      counterX++;
      if (counterX % 4 == 0){
        counterX = 0;
        counterY++;
      }
    }
    if (counterY %2 == 0){
      counterY = 0;
    }
  }
}
