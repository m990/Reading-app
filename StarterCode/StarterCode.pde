// Instead of creating a window object with a book, you have a window object and you have a setter that puts in the book later //<>//
// Put all visual stuff inside a second method

import de.bezier.data.sql.*;

Library l;
Window w;
Store s;
int currentPage;
public static boolean inLibrary = true;
public static boolean inWindow = false;
public static boolean inStore = false;
ArrayList<Page> prePageArray;
ArrayList<Page> pageArray;

JSONArray values;
//MySQL db;
SQLite db;

void setup() {
  size(750, 750);
  // For now, this is only used to launch the window because it requires a book to be launched.
  // This book isn't used otherwise and is not the same as the default book
  String cover1 = "Art Example Two.png";
  String cover2 = "Art Example Three.png";

  db = new SQLite(this, "readingapp.db");

  //Page[] p = {new Page("I ran.", "pixil-frame-0.png", color(255, 255, 255)), new Page("I ran2.", "img2.png", color(255, 255, 255))};
  Page[] p2 = {new Page("Text", "Art Example One.png", color(0, 0, 0), 1)};
  Book b1 = new Book("Test", 2, p2, cover1);
  //Book b2 = new Book("Test2", 1, p2, cover2);
  //Book b3 = new Book("Test3", 1, p2, cover2);
  pageArray = new ArrayList<Page>();
  prePageArray = new ArrayList<Page>();

  w = new Window(b1);
  l = new Library(this);
  s = new Store(this);

  currentPage = l.getCurrentPage();

  // RetrieveData r = new RetrieveData();
  try {
    //String data = r.retrieveData("http://localhost:8080/all");
    //values = parseJSONArray(data);
    //if (values == null) {
    //  println("JSONArray could not be parsed");
    //} else {}
    if (db.connect()) {
      db.query("SELECT * FROM Page");
      while (db.next()) {
        prePageArray.add(new Page(db.getString("text"), db.getString("image"), color(0, 0, 0), db.getInt("bookid")));
      }
      for (int i = 0; i < prePageArray.size(); i++){
        if (!containsPage(prePageArray.get(i), pageArray)){
          pageArray.add(prePageArray.get(i));
          println(prePageArray.get(i).getText());
        }
      }
      db.query("SELECT * FROM Book");
      while (db.next()) {
        ArrayList<Page> thisBook = new ArrayList<Page>();
        for (int i = 0; i < pageArray.size(); i++) {
          if (db.getInt("id") == (pageArray.get(i).getBookID())) {
                thisBook.add(pageArray.get(i));
          }
        }
        Page[] pages = new Page[thisBook.size()];
        for (int i = 0; i < pages.length; i++) {
          pages[i] = thisBook.get(i);
        }
        l.addBook(new Book(db.getString("title"), 0, pages, db.getString("image")));
      }
    }
  }
  catch (Exception e) {
    println(e);
  }

  background(0, 0, 0);

  //l.addBook(b1);
  //l.addBook(b2);
  //l.addBook(b3);
  println(l.books.size());
}

void draw() {
  // 78, 99
  // 214, 100
  // 81, 241
  // 221, 239
  //draws the library
  if (inLibrary) {
    l.drawLibrary();
    s.toLibrary.setVisible(false);
  }
  // draws the book
  //w.draw();
  if (inWindow) w.drawWindow();

  if (inStore) {
    s.drawStore();
    l.clear.setVisible(false);
    l.librarySearch.setVisible(false);
    l.toStore.setVisible(false);
  }
}

void mousePressed() {
  if (inWindow) {
    w.mousePressed();
  }
}

void mouseReleased() {
  if (inWindow) {
    w.mouseReleased();
  }
}

void mouseClicked() {
  if (inStore) {
    //s.mouseClicked();
  }
}

public void controlEvent(ControlEvent e) {
  if (e.getController().getName().equals("Clear")) {
    l.clearSearch();
    s.clearSearch();
  }
  if (e.getController().getName().equals("Store")) {
    for (Controller c : l.widgets) {
      c.setVisible(false);
    }
    inLibrary = false;
    inStore = true;
  }
  if (e.getController().getName().equals("Library")) {
    for (Controller c : s.widgets) {
      c.setVisible(false);
    }
    inStore = false;
    inLibrary = true;
  }
}
boolean containsPage(Page p, ArrayList<Page> ps){
  for (int i = 0; i < ps.size(); i++){
    if (ps.get(i).getText().equals(p.getText())){
      return true;
    }
  }
  return false;
}
