class Library {
  // is it possible to search? will be determined later but keep it in mind
  ArrayList<Book> books;
  
  Library(ArrayList<Book> books){
    this.books = books;
  }
  ArrayList<Book> getBooks(){
    return books;
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
    
  }
}
