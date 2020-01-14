import java.util.TreeMap;
import java.util.Iterator;
import java.util.Map;

class Library {
  // is it possible to search? will be determined later but keep it in mind
  //ArrayList<Book> books;
  //key is title
  TreeMap<String, Book> books;

  public Library() {
    //books = new ArrayList<Book>();
    books = new TreeMap<String, Book>();
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
  //draws the library
  void drawLibrary(){
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
        }
        delay(50);
      }
    }
    if(spot>0) {
      fill(253, 253, 253);
      triangle(0.07*width, 0.45*height, 0.03*width, 0.5*height, 0.07*width, 0.55*height);
      if (mousePressed){
        color c = get(mouseX, mouseY);
        if (c == color(253, 253, 253)){
          fill(50, 50, 50);
          spot--;
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
  }
}
