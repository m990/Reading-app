import java.util.TreeMap;
import java.util.Iterator;
import java.util.Map;

class Library {
  // is it possible to search? will be determined later but keep it in mind
  //ArrayList<Book> books;
  //key is title
  TreeMap<String, Book> books;

  public Library() {
    books = new TreeMap<String, Book>();

    // Add one book, which is an instructions manual, so the program doesn't throw an error when generating the library.
    Page[] examplePages = {new Page("Access books in your library.", "click on books.png", color(255, 255, 255)), new Page("Switch pages by using the side arrows.", "use the side arrows.png", color(255, 255, 255)), new Page("Return to the library by clicking exit.", "click exit.png", color(255, 255, 255))};
    books.put("User Guide", new Book("User Guide", 3, examplePages, "Centered? User Guide Title.png"));
    books.put("User Guide2", new Book("User Guide", 3, examplePages, "Centered? User Guide Title.png"));
    books.put("User Guide3", new Book("User Guide", 3, examplePages, "Centered? User Guide Title.png"));
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
  
  public Library(TreeMap<String, Book> books){
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
  TreeMap<String, Book> getBooks(){
    return books;
  }
  void addBook(Book b){
    books.put(b.getTitle(), b);
  }
  Book getBook(String bookName) {
    return books.get(bookName);
  }
  int getCurrentPage(){
    return currentPage;
  }
  //draws the library
  void drawLibrary(){
    clear();
    boolean changed = false;
    if(spot*4+4 < books.size()) {
      fill(254, 254, 254);
      triangle(0.93*width, 0.45*height, 0.97*width, 0.5*height, 0.93*width, 0.55*height);
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
      triangle(0.93*width, 0.45*height, 0.97*width, 0.5*height, 0.93*width, 0.55*height); 
    }
    if(spot>0) {
      fill(253, 253, 253);
      triangle(0.07*width, 0.45*height, 0.03*width, 0.5*height, 0.07*width, 0.55*height);
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
    int coverWidth = width*285/500;
    int coverHeight = height*285/500;
    float xPos = width*428/500;
    float yPos = height*428/500;
    
    int newHeight = height - (int)((double)height/(double)10);
    float xOffset = (float) width/10;
    float yOffset = (float)((double)height/10) + (int) ((double) 1/2 * (double) (newHeight - (double) coverHeight/columns - (double) (columns-1)* (double) yPos/columns));
    
    // Divide treeMap into 2d array so it can be iterated over.
    ArrayList<ArrayList<Book>> libraryPages = new ArrayList<ArrayList<Book>>();
    ArrayList<Book> temporaryList = new ArrayList<Book>();
    int it = 0;
    for(Map.Entry<String,Book> entry: books.entrySet()) {
      temporaryList.add(entry.getValue());
      if (it == 3) {
       it = 0;
       libraryPages.add(temporaryList);
       temporaryList = new ArrayList<Book>();
      }
      else {
       it++; 
      }

    }
    if(temporaryList.size() > 0) {
      libraryPages.add(temporaryList); 
    }
    //drawing books that belong to spot/page
    int bookIterator = 0;
    
    for(Book b:libraryPages.get(spot)) {
      // iterate over treemap for each book.
      PImage cover = b.getCoverImg();
      cover.resize(coverWidth/columns, coverHeight/columns);
      image(cover, xOffset+(bookIterator % (2)) * xPos/columns, yOffset+(bookIterator - (bookIterator % (2)))/( columns) * yPos/columns);
      bookIterator++;
    }
    
    if(changed){
      background(0,0,0);
      drawLibrary();
    }
      if (mousePressed){
    // top left corner button
            ArrayList<Book> bookList = new ArrayList<Book>(books.values());
      if (mouseX > 78 && mouseX < 214 && mouseY > 99 && mouseY < 241){
        inLibrary = false;
        println("top left is pressed");
        /*if (currentPage == 1){
          w.setBook(books.get(0));
          w.drawWindow();
        }*/
        ArrayList<Book> topLeftBooks = new ArrayList<Book>();
        for (int i = 0; i < bookList.size(); i++){
          if (i % 4 == 0){
            topLeftBooks.add(bookList.get(i));
          }
        }
        for (int i = 0; i < topLeftBooks.size(); i++){
          println(topLeftBooks.get(i).getTitle());
        }
        println ("Current page: " + currentPage);
        w.setBook(topLeftBooks.get(currentPage));
        println ("Book: " + topLeftBooks.get(currentPage).getTitle()); 
        //w.drawWindow();
        inWindow=true;
      }
      if (mouseX > 289 && mouseX < 427 && mouseY > 99 && mouseY < 241){
        inLibrary = false;
        println("top right is pressed");
        ArrayList<Book> topRightBooks = new ArrayList<Book>();
        for (int i = 0; i < bookList.size(); i++){
          if (i % 4 == 1){
            topRightBooks.add(bookList.get(i));
          }
        }
        for (int i = 0; i < topRightBooks.size(); i++){
          println(topRightBooks.get(i).getTitle());
        }
        w.setBook(topRightBooks.get(currentPage));
        //w.drawWindow();
        inWindow=true;
      }
      if (mouseX > 78 && mouseX < 214 && mouseY > 314 && mouseY < 453){
        inLibrary = false;
        println("bottom left is pressed");
        ArrayList<Book> topRightBooks = new ArrayList<Book>();
        for (int i = 0; i < bookList.size(); i++){
          if (i % 4 == 2){
            topRightBooks.add(bookList.get(i));
          }
        }
        for (int i = 0; i < topRightBooks.size(); i++){
          println(topRightBooks.get(i).getTitle());
        }
        w.setBook(topRightBooks.get(currentPage));
        //w.drawWindow();
        inWindow=true;
      }
      if (mouseX > 289 && mouseX < 427 && mouseY > 314 && mouseY < 453){
                inLibrary = false;
        println("bottom right is pressed");
        ArrayList<Book> topRightBooks = new ArrayList<Book>();
        for (int i = 0; i < bookList.size(); i++){
          if (i % 4 == 3){
            topRightBooks.add(bookList.get(i));
          }
        }
        for (int i = 0; i < topRightBooks.size(); i++){
          println(topRightBooks.get(i).getTitle());
        }
        w.setBook(topRightBooks.get(currentPage));
        //w.drawWindow();
        inWindow=true;
      }
     }
  }
}
