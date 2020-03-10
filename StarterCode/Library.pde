import java.util.TreeMap;
import java.util.Iterator;
import java.util.Map;

import controlP5.*;

import processing.core.PApplet;

class Library {
  //K = title
  //V = book object
  TreeMap<String, Book> books;

  int spot;
  int columns;
  int currentPage;

  boolean buttonOver;
  boolean button2Over;
  color buttonColor;
  color button2Color;
  color buttonHighlight;
  color button2Highlight;
  
  boolean buttonClicked;
  boolean button2Clicked;

  ControlP5 cp5;
  
  Textfield tf;
  Button clear;

  String searchQuery;

  //constructors
  public Library(PApplet p) {
    
    books = new TreeMap<String, Book>();

    // Add one book, which is an instructions manual, so the program doesn't throw an error when generating the library.
    Page[] examplePages = {new Page("Access books in your library.", "click on books.png", color(255, 255, 255)), new Page("Switch pages by using the side arrows.", "use the side arrows.png", color(255, 255, 255)), new Page("Return to the library by clicking exit.", "click exit.png", color(255, 255, 255))};
    books.put("User Guide", new Book("User Guide", 3, examplePages, "Centered? User Guide Title.png"));
    books.put("User Guide2", new Book("User Guide", 3, examplePages, "Centered? User Guide Title.png"));

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

    cp5 = new ControlP5(p);
    tf = cp5.addTextfield("Search");
    tf.setPosition(width*330/500, height*25/500-(height*10/500));
    tf.setSize(width*100/500, height*20/500);
    tf.setFont(createFont("Arial", 16));
    tf.setFocus(true);
    tf.setAutoClear(false);
    tf.setVisible(false);
    tf.setColor(color(0));
    tf.setColorBackground(color(255));
    tf.setColorForeground(color(255));
    tf.setColorCursor(color(0));
    clear = cp5.addButton("Clear");
    clear.setPosition(width*440/500, height*25/500-(height*10/500));
    clear.setSize(width*50/500, height*20/500);
    clear.setVisible(false);
    clear.setColorBackground(color(110));
    clear.setColorForeground(color(90));
    clear.setColorActive(color(70));
    clear.setFont(createFont("Arial", 11));

    searchQuery = "";
  }
  
  public Library(PApplet p, TreeMap<String, Book> books){
    this(p);
    this.books = books;
  }

  //getters, setters
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
    tf.setVisible(true);
    clear.setVisible(true);
    cp5.getController("Search").getCaptionLabel().setVisible(false);

    //button click checks
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

    if(tf.isFocus() && keyPressed) {
      if(key==ENTER || key==RETURN) {
        searchQuery = tf.getText();
      }
    }
    
    // Your library sign
    // 1/30th (1/3 of 1/10 of height)
    fill(255);
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
    ArrayList<ArrayList<Book>> libraryPages = convertToMat(searchQuery);
    //drawing books that belong to spot/page
    int bookIterator = 0;
    
    for(Book b:libraryPages.get(spot)) {
      // iterate over treemap for each book.
      PImage cover = b.getCoverImg();
      cover.resize(coverWidth/columns, coverHeight/columns);
      image(cover, xOffset+(bookIterator % (2)) * xPos/columns, yOffset+(bookIterator - (bookIterator % (2)))/( columns) * yPos/columns);
      bookIterator++;
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
        try {
          
          w.setBook(topLeftBooks.get(currentPage));
          //w.drawWindow();
          inWindow=true;
        }
        catch(Exception e) {
          System.err.println("grr");
          inLibrary = true;
        }
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
         try {
          
          w.setBook(topRightBooks.get(currentPage));
          //w.drawWindow();
          inWindow=true;
        }
        catch(Exception e) {
          System.err.println("grr");
          inLibrary = true;
        }
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
        try {
          
          w.setBook(topRightBooks.get(currentPage));
          //w.drawWindow();
          inWindow=true;
        }
        catch(Exception e) {
          System.err.println("grr");
          inLibrary = true;
        }
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
               try {
          
          w.setBook(topRightBooks.get(currentPage));
          //w.drawWindow();
          inWindow=true;
        }
        catch(Exception e) {
          System.err.println("grr");
          inLibrary = true;
        }
      }
     }
  }
  ArrayList<ArrayList<Book>> convertToMat(String filter) {
    ArrayList<ArrayList<Book>> libraryPages = new ArrayList<ArrayList<Book>>();
    ArrayList<Book> temporaryList = new ArrayList<Book>();
    int it = 0;
    for(Map.Entry<String,Book> entry: books.entrySet()) {
      if(filter.equals("")) {
        temporaryList.add(entry.getValue());
      } else if(entry.getKey().toLowerCase().contains(filter.toLowerCase())) {
        temporaryList.add(entry.getValue());
      }
      
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
    return libraryPages;
  }

  public void clearSearch() {
    searchQuery = "";
    tf.setText("");
  }

  

}
 
