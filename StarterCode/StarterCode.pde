// Instead of creating a window object with a book, you have a window object and you have a setter that puts in the book later
// Put all visual stuff inside a second method

import de.bezier.data.sql.*;

Library l;
Window w;
int currentPage;
public static boolean inLibrary = true;
public static boolean inWindow = false;
JSONArray values;
//MySQL db;
SQLite db;

void setup() {
  size(500, 500);
  // For now, this is only used to launch the window because it requires a book to be launched.
  // This book isn't used otherwise and is not the same as the default book
  String cover1 = "Art Example Two.png";
  String cover2 = "Art Example Three.png";
  
  db = new SQLite(this, "readingapp.db");
  
  Page[] p = {new Page("I ran.", "pixil-frame-0.png", color(255, 255, 255)), new Page("I ran2.", "img2.png", color(255, 255, 255))};
  Page[] p2 = {new Page("Text", "Art Example One.png", color(0, 0, 0))};
  Book b1 = new Book("Test", 2, p, cover1);
  //Book b2 = new Book("Test2", 1, p2, cover2);
  //Book b3 = new Book("Test3", 1, p2, cover2);
  
  w = new Window(b1);
  l = new Library(this);
  
  currentPage = l.getCurrentPage();
  
  RetrieveData r = new RetrieveData();
  try{
    println(r.retrieveData("http://localhost:8080/all"));
    String data = r.retrieveData("http://localhost:8080/all");
    values = parseJSONArray(data);
    if (values == null){
      println("JSONArray could not be parsed");
    }
    else{
      //String book = values.getString(1);
      // this should just repeat until all books are added
      
      // book 1
      /*print(values.getJSONObject(0).getString("title"));
      JSONObject book = values.getJSONObject(0);
      Book b4 = new Book(book.getString("title"), book.getInt("pageNumber"), p, ("data/"+book.getString("image")));
      l.addBook(b4);*/
      
      // local database
      
      
      //example of adding data to the database
      /*if (db.connect()){
        print("connected");
        db.query("INSERT INTO User VALUES (0, 'Max Norman', 'Rush')");
        db.close();
      }*/
      int id;
      String author;
      int copyright;
      String description;
      String image;
      int pageNumber;
      String title;
      String sql;
      
      if (db.connect()){
        println("Total number of items in the cloud: " + values.size());
        
        for (int i = 0; i < values.size(); i++){
          id = values.getJSONObject(i).getInt("id");          
          author = values.getJSONObject(i).getString("author");
          copyright = values.getJSONObject(i).getInt("copyright");
          description = values.getJSONObject(i).getString("description");
          image = values.getJSONObject(i).getString("image");
          pageNumber = values.getJSONObject(i).getInt("pageNumber");
          title = values.getJSONObject(i).getString("title");
          sql = "INSERT INTO BOOK VALUES(" + id + ", '" + author + "', " + copyright + ", '" + description + "', '" + image + "', " + pageNumber + ", '" + title + "')";
          db.query(sql);
        }
      }
     
      // book 2
      /*book = values.getJSONObject(1);
      b4 = new Book(book.getString("title"), book.getInt("pageNumber"), p, ("data/"+book.getString("image")));
      l.addBook(b4);*/
    }
    
  }catch (Exception e){ //<>//
    println(e);
  }
  
  background(0, 0, 0);
  
  l.addBook(b1);
  //l.addBook(b2);
  //l.addBook(b3);
}

void draw() {
  // 78, 99
  // 214, 100
  // 81, 241
  // 221, 239
  //draws the library
  if (inLibrary) l.drawLibrary();
  // draws the book
  //w.draw();
  if (inWindow) w.drawWindow();
}

void mousePressed() {
  w.mousePressed();
}

void mouseReleased() {
  w.mouseReleased();
}

public void controlEvent(ControlEvent e) {
    if(e.getController().getName().equals("Clear")) {
      l.clearSearch();
    }
}
