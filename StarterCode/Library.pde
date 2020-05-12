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
  
  Textfield librarySearch;
  Button clear;
  Button toStore;

  String searchQuery;

  ArrayList<ArrayList<Book>> libraryPages;

  Controller[] widgets;

  //constructors
  public Library(PApplet p) {

    books = new TreeMap<String, Book>();

    // Add one book, which is an instructions manual, so the program doesn't throw an error when generating the library.
    Page[] examplePages = {new Page("Access books in your library.", "click on books.png", color(255, 255, 255)), new Page("Switch pages by using the side arrows.", "use the side arrows.png", color(255, 255, 255)), new Page("Return to the library by clicking exit.", "click exit.png", color(255, 255, 255))};
    books.put("User Guide", new Book("User Guide", 3, examplePages, "Centered? User Guide Title.png"));
    
    spot = 0;
    columns = width/250;
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
    librarySearch = cp5.addTextfield("LibrarySearch");
    librarySearch.setPosition(width*330/500, height*25/500-(height*10/500));
    librarySearch.setSize(width*100/500, height*20/500);
    librarySearch.setFont(createFont("Arial", 16));
    librarySearch.setFocus(true);
    librarySearch.setAutoClear(false);
    librarySearch.setVisible(false);
    librarySearch.setColor(color(0));
    librarySearch.setColorBackground(color(255));
    librarySearch.setColorForeground(color(255));
    librarySearch.setColorCursor(color(0));
    clear = cp5.addButton("Clear");
    clear.setPosition(width*440/500, height*25/500-(height*10/500));
    clear.setSize(width*50/500, height*20/500);
    clear.setVisible(false);
    clear.setColorBackground(color(110));
    clear.setColorForeground(color(90));
    clear.setColorActive(color(70));
    clear.setFont(createFont("Arial", 11));
    toStore = cp5.addButton("Store")
    .setPosition(width*40/500, height*25/500-(height*10/500))
    .setSize(width*50/500, height*20/500)
    .setVisible(false)
    .setColorBackground(color(110))
    .setColorForeground(color(90))
    .setColorActive(color(70))
    .setFont(createFont("Arial", 11));

    searchQuery = "";

    widgets = new Controller[3];
    widgets[0] = librarySearch;
    widgets[1] = clear;
    widgets[2] = toStore;
  }

  public Library(PApplet p, TreeMap<String, Book> books) {
    this(p);
    this.books = books;
  }

  //getters, setters
  TreeMap<String, Book> getBooks() {
    return books;
  }
  void addBook(Book b) {
    books.put(b.getTitle(), b);
  }
  Book getBook(String bookName) {
    return books.get(bookName);
  }
  int getCurrentPage() {
    return currentPage;
  }

  //draws the library
  void drawLibrary() {
    clear();
    librarySearch.setVisible(true);
    clear.setVisible(true);
    toStore.setVisible(true);
    cp5.getController("LibrarySearch").getCaptionLabel().setVisible(false);

    if(librarySearch.isFocus() && keyPressed) {
      if(key==ENTER || key==RETURN) {
        searchQuery =  librarySearch.getText();
        spot = 0;
        currentPage = 0;
      }
    }
    // Divide treeMap into 2d array so it can be iterated over.
    libraryPages = convertToMat(searchQuery);

    //num of books in libraryPages

    int numBooks = libraryPages.size() == 0 ? 0 : columns*columns*(libraryPages.size()-1)+libraryPages.get(libraryPages.size()-1).size();
    
    //button click checks
    if (spot*columns*columns+columns*columns < numBooks) {
      fill(254, 254, 254);
      triangle(0.93*width, 0.45*height, 0.97*width, 0.5*height, 0.93*width, 0.55*height);
      if (mousePressed) {
        color c = get(mouseX, mouseY);
        if (c == color(254, 254, 254)) {
          fill(1, 1, 1);
          spot++;
          currentPage++;
        }
        delay(50);
      }
      triangle(0.93*width, 0.45*height, 0.97*width, 0.5*height, 0.93*width, 0.55*height);
    }

    // Draws back arrow
    if (spot>0) {
      fill(253, 253, 253);
      triangle(0.07*width, 0.45*height, 0.03*width, 0.5*height, 0.07*width, 0.55*height);
      if (mousePressed) {
        color c = get(mouseX, mouseY);
        if (c == color(253, 253, 253)) {
          fill(50, 50, 50);
          spot--;
          currentPage--;
        } 
        delay(50);
      }
    }

    // Your library sign
    // 1/30th (1/3 of 1/10 of height)
    fill(255);
    textSize((int) ((double)1 / (double)15 * (double)height));
    text("Your Library", (int)((double)10/(double)40 * (double)width), (int)((double)3/(double)40 * (double)height));
    // Line
    fill(255, 255, 2500);
    stroke(126);

    // Line across screen at 10% down
    line(0, (int)((double)height/(double)10), width, (int)((double)height/(double)10));

    if(numBooks!=0) {
      drawBooks();
      implementButtons();
    } else {
      println("Book not found");
    }
  }

  void drawBooks() {
    int coverWidth = width*285/500;
    int coverHeight = height*285/500;
    float xPos = width*428/500;
    float yPos = height*428/500;
    int newHeight = height - (int)((double)height/(double)10);
    float xOffset = (float) width/10;
    float yOffset = (float)((double)height/10) + (int) ((double) 1/columns * (double) (newHeight - (double) coverHeight/columns - (double) (columns-1)* (double) yPos/columns));

    //drawing books that belong to spot/page
    int bookIterator = 0;
    for (Book b : libraryPages.get(spot)) {
      // iterate over treemap for each book.
      PImage cover = b.getCoverImg();
      cover.resize(coverWidth/columns, coverHeight/columns);
      image(cover, xOffset+(bookIterator % (columns)) * xPos/columns, yOffset+(bookIterator - (bookIterator % (columns)))/(columns) * yPos/columns);
      bookIterator++;
    }
  }

  void implementButtons() {
    if (mousePressed) {
      int newHeight = height - (int)((double)height/(double)10);
      int coverWidth = width*285/500;
      int coverHeight = height*285/500;
      float xPos = width*428/500;
      float yPos = height*428/500;
      float xOffset = (float) width/10;
      float yOffset = (float)((double)height/10) + (int) ((double) 1/columns * (double) (newHeight - (double) coverHeight/columns - (double) (columns-1)* (double) yPos/columns));
      int booksOnPage = libraryPages.get(currentPage).size();
      int currentColumn = (int) ((mouseX-(int) xOffset)- (((mouseX-(int) xOffset))%((int) xPos/columns)))/((int) xPos/columns);
      int currentRow = (int) ((mouseY-(int) yOffset)- (((mouseY-(int) yOffset))%((int) yPos/columns)))/((int) yPos/columns);
      // top left corner button
      if ((((mouseX-(int) xOffset))%((int) xPos/columns)) >= 0 && (((mouseY-(int) yOffset))%((int) yPos/columns)) >= 0 &&(((mouseX-(int) xOffset))%((int) xPos/columns)) <= coverWidth/columns && (((mouseY-(int) yOffset))%((int) yPos/columns)) <= coverWidth/columns) {
        if (booksOnPage>columns*currentRow+currentColumn) {
          inLibrary = false;
          w.setBook(libraryPages.get(currentPage).get(columns*currentRow+currentColumn));
          inWindow=true;
          librarySearch.setVisible(false);
          clear.setVisible(false);
          toStore.setVisible(false);
        }
      }
    }
  }

  ArrayList<ArrayList<Book>> convertToMat(String filter) {
    ArrayList<ArrayList<Book>> libraryPages = new ArrayList<ArrayList<Book>>();
    ArrayList<Book> temporaryList = new ArrayList<Book>();
    int it = 0;
    for (Map.Entry<String, Book> entry : books.entrySet()) {
      if (filter.equals("")) {
        temporaryList.add(entry.getValue());
      } else if (entry.getKey().toLowerCase().contains(filter.toLowerCase())) {
        temporaryList.add(entry.getValue());
      } else {
        continue;
      }

      if (it == columns*columns-1) {
        it = 0;
        libraryPages.add(temporaryList);
        temporaryList = new ArrayList<Book>();
      } else {
        it++;
      }
    }
    if (temporaryList.size() > 0) {
      libraryPages.add(temporaryList);
    }
    return libraryPages;
  }

  public void clearSearch() {
    searchQuery = "";
    librarySearch.setText("");
    currentPage = 0;
  }
}
