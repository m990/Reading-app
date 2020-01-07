class Statistics {
  int numPagesRead;
  int numBooksRead;
  int timePassed;
  public Statistics(){
    numPagesRead = 0;
    numBooksRead = 0;
    timePassed = 0;
  }
  public int PagesRead(){
    return numPagesRead;
  }
  public int BooksRead(){
    return numBooksRead;
  }
  public int TimePassed(){
    return timePassed;
  }
  public void incrementPages(){
     numPagesRead++; 
  }
  public void incrementBooks(){
     numBooksRead++; 
  }
}
