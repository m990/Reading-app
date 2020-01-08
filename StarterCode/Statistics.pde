class Statistics {
  int numPagesRead;
  int numBooksRead;
  public Statistics(){
    numPagesRead = 0;
    numBooksRead = 0;
  }
  public int PagesRead(){
    return numPagesRead;
  }
  public int BooksRead(){
    return numBooksRead;
  }
  public void incrementPages(){
     numPagesRead++; 
  }
  public void incrementBooks(){
     numBooksRead++; 
  }
}
