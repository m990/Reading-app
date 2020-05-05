Library l;
Window w;
void setup() {
  size(500, 500);
  String cover1 = "Art Example Two.png";
  String cover2 = "Art Example Three.png";

  Page[] p = {new Page("Rush is a Canadian band that averages a score of 7.500.", "pixil-frame-0.png", color(255, 255, 255), "rush.wav"), new Page("This score falls behind Taylor Swift by a full tenth.", "img2.png", color(255, 255, 255), "taylor swift.wav")};
  Book b1 = new Book("Test", 2, p, cover1);
  Book b2 = new Book("Test2", 2, p, cover2);
  
  l = new Library();
  w = new Window(b1);
  background(0, 0, 0);
  for(int i = 0; i<34; i++){
       if( (int)Math.sqrt(i)%2 ==0 ){
            l.addBook(b1);
       }else{
            l.addBook(b2);
       }
  }
    RetrieveData r = new RetrieveData();
  try{
    println(r.retrieveData("http://localhost:8080/all"));
<<<<<<< Updated upstream
  }catch (Exception e){
=======
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
      
     
      // book 2
      /*book = values.getJSONObject(1);
      b4 = new Book(book.getString("title"), book.getInt("pageNumber"), p, ("data/"+book.getString("image"))); //<>//
      l.addBook(b4);*/
    }
    
  }catch (Exception e){ //<>//
>>>>>>> Stashed changes
    println(e);
  }
}

void draw() {
  if(w.getStay()) {
    w.drawWindow();
  } else {
    clear();
    l.drawLibrary();
  }
}

void mousePressed() {
  w.mousePressed();
}

void mouseReleased() {
  w.mouseReleased();
}
<<<<<<< Updated upstream
=======

public void controlEvent(ControlEvent e) {
    if(e.getController().getName().equals("Clear")) {
      l.clearSearch();
      s.clearSearch();
    }
    if(e.getController().getName().equals("Store")) {
      for(Controller c : l.widgets) {
        c.setVisible(false);
      }
      inLibrary = false;
      inStore = true;
    }
    if(e.getController().getName().equals("Library")) {
      for(Controller c : s.widgets) {
        c.setVisible(false);
      }
      inStore = false;
      inLibrary = true;
    }
}

public void getData(){
      int id;
      String author;
      int copyright;
      String description;
      String image;
      int pageNumber;
      String title;
      String sql;
      if (db.connect()) {
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
}

public void getBookFromStore(){
      int id;
      String author;
      int copyright;
      String description;
      String image;
      int pageNumber;
      String title;
      String sql;
      if (db.connect()) {
        
        // CREATE THE FINAL STRING OF SQL
        // sql = "INSERT INTO BOOK VALUES(" + id + ", '" + author + "', " + copyright + ", '" + description + "', '" + image + "', " + pageNumber + ", '" + title + "')";
        // RUN THE SQL
        // db.query(sql);
      }
}
>>>>>>> Stashed changes
