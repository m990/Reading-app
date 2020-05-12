import controlP5.*;
import de.bezier.data.sql.*;

class Store {
  ControlP5 cp5;
  Textfield storeSearch;
  Button clear;
  Button toLibrary;
  String bookTitle;
  

  String searchQuery;

  Controller[] widgets;

  SQLite db;
  RetrieveData rd = new RetrieveData();

  ArrayList<Book> books;
  ArrayList<ArrayList<Book>> storeMat;

  int cPage;
  int columns;

  boolean prompt;

  float pWidth = width/3;
  float pHeight = height/3;
  float pX = width/2-(pWidth/2);
  float pY = height/2-(pHeight/2);
  
  public Store(PApplet p) {
    cp5 = new ControlP5(p);
    storeSearch = cp5.addTextfield("StoreSearch")
    .setPosition(width*330/500, height*25/500-(height*10/500))
    .setSize(width*100/500, height*20/500)
    .setFont(createFont("Arial", 16))
    .setFocus(true)
    .setAutoClear(false)
    .setVisible(false)
    .setColor(color(0))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorCursor(color(0));
    clear = cp5.addButton("Clear")
    .setPosition(width*440/500, height*25/500-(height*10/500))
    .setSize(width*50/500, height*20/500)
    .setVisible(false)
    .setColorBackground(color(110))
    .setColorForeground(color(90))
    .setColorActive(color(70))
    .setFont(createFont("Arial", 11));
    toLibrary = cp5.addButton("Library")
    .setPosition(width*40/500, height*25/500-(height*10/500))
    .setSize(width*50/500, height*20/500)
    .setVisible(false)
    .setColorBackground(color(110))
    .setColorForeground(color(90))
    .setColorActive(color(70))
    .setFont(createFont("Arial", 11));

    searchQuery = "";
    
    widgets = new Controller[3];
    widgets[0] = storeSearch;
    widgets[1] = clear;
    widgets[2] = toLibrary;

    cPage = 0;
    columns = width/250;

    books = new ArrayList<Book>();
    storeMat = new ArrayList<ArrayList<Book>>();

    db = new SQLite(p, "readingapp.db");

    prompt = false;

    try{
      println(rd.retrieveData("http://localhost:8080/all"));
      String data = rd.retrieveData("http://localhost:8080/all");
      values = parseJSONArray(data);
      if (values == null){
        println("JSONArray could not be parsed");
      } else{
        for(int i = 0; i < values.size(); i++) {
          String title = values.getJSONObject(i).getString("title");
          String img = values.getJSONObject(i).getString("image");
          books.add(new Book(title, 0, new Page[] {}, img));
        }
      } 
    }catch (Exception e){
      println(e);
    }
  }

  public void drawStore() {
    storeMat = convertToMat(searchQuery);
    clear();
    background(229, 191, 167);
    storeSearch.setVisible(true);
    clear.setVisible(true);
    toLibrary.setVisible(true);
    cp5.getController("StoreSearch").getCaptionLabel().setVisible(false);

    int numBooks = storeMat.size() == 0 ? 0 : columns*columns*(storeMat.size()-1)+storeMat.get(storeMat.size()-1).size();

    if(storeSearch.isFocus() && keyPressed) {
      if(key==ENTER || key==RETURN) {
        searchQuery =  storeSearch.getText();
        cPage = 0;
      }
    }

    //button click checks
    if (cPage*columns*columns+columns*columns < numBooks) {
      fill(254, 254, 254);
      triangle(0.93*width, 0.45*height, 0.97*width, 0.5*height, 0.93*width, 0.55*height);
      if (mousePressed) {
        color c = get(mouseX, mouseY);
        if (c == color(254, 254, 254)) {
          fill(1, 1, 1);
          cPage++;
        }
        delay(50);
      }
      triangle(0.93*width, 0.45*height, 0.97*width, 0.5*height, 0.93*width, 0.55*height);
    }

    // Draws back arrow
    if (cPage>0) {
      fill(253, 253, 253);
      triangle(0.07*width, 0.45*height, 0.03*width, 0.5*height, 0.07*width, 0.55*height);
      if (mousePressed) {
        color c = get(mouseX, mouseY);
        if (c == color(253, 253, 253)) {
          fill(50, 50, 50);
          cPage--;
        } 
        delay(50);
      }
    }

    fill(0);
    textSize((int) ((double)1 / (double)15 * (double)height));
    text("Store", (int)((double)17/(double)40 * (double)width), (int)((double)3/(double)40 * (double)height));
    // Line
    fill(255, 255, 250);
    stroke(126);
    // Line across screen at 10% down
    line(0, (int)((double)height/(double)10), width, (int)((double)height/(double)10));

    if(numBooks!=0) {
      drawBooks();
      implementButtons();
    } else {
      //either no books to show or book not found
    }

    if(prompt) promptUser(bookTitle);
  }

  void clearSearch() {
    searchQuery = "";
    storeSearch.setText("");
    cPage = 0;
  }

  ArrayList<ArrayList<Book>> convertToMat(String filter) {
    ArrayList<ArrayList<Book>> storeMat = new ArrayList<ArrayList<Book>>();
    ArrayList<Book> temporaryList = new ArrayList<Book>();
    int it = 0;
    for (Book b : books) {
      if (filter.equals("")) {
        temporaryList.add(b);
      } else if (b.title.toLowerCase().contains(filter.toLowerCase())) {
        temporaryList.add(b);
      } else continue;

      if (it == columns*columns-1) {
        it = 0;
        storeMat.add(temporaryList);
        temporaryList = new ArrayList<Book>();
      } else {
        it++;
      }
    }
    if (temporaryList.size() > 0) {
      storeMat.add(temporaryList);
    }
    return storeMat;
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
    for (Book b : storeMat.get(cPage)) {
      // iterate over treemap for each book.
      PImage cover = b.coverImg;
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
      int booksOnPage = storeMat.get(cPage).size();
      int currentColumn = (int) ((mouseX-(int) xOffset)- (((mouseX-(int) xOffset))%((int) xPos/columns)))/((int) xPos/columns);
      int currentRow = (int) ((mouseY-(int) yOffset)- (((mouseY-(int) yOffset))%((int) yPos/columns)))/((int) yPos/columns);
      // top left corner button
      if ((((mouseX-(int) xOffset))%((int) xPos/columns)) >= 0 && (((mouseY-(int) yOffset))%((int) yPos/columns)) >= 0 &&(((mouseX-(int) xOffset))%((int) xPos/columns)) <= coverWidth/columns && (((mouseY-(int) yOffset))%((int) yPos/columns)) <= coverWidth/columns) {
        if (booksOnPage>columns*currentRow+currentColumn) {
          println("Book: "+storeMat.get(cPage).get(columns*currentRow+currentColumn).getTitle());
          bookTitle = storeMat.get(cPage).get(columns*currentRow+currentColumn).getTitle();
          prompt = true;
        }
      }
    }
  }

  void promptUser(String title) {
    fill(255);
    rect(pX, pY, pWidth, pHeight);
    fill(0);
    textSize(18);
    String s = "Download this book?";
    float offset = textWidth(s);
    text(s, width/2-(offset/2), pY+(pHeight*3/10));

    //buttons
    fill(255);
    textSize(12);
    rect(pX+(pWidth/4)-(pWidth/6), pY+(pHeight*5/8), pWidth/3, pHeight/6);
    rect(pX+(3*pWidth/4)-(pWidth/6), pY+(pHeight*5/8), pWidth/3, pHeight/6);

    fill(0);
    float base = pY+(pHeight*17/24);
    float scalar = 0.8;
    float ascent = textAscent() * scalar;
    float descent = textDescent() * scalar;

    s = "Yes";
    offset = textWidth(s);
    //float hOffset = textHeight(s);
    text(s, pX+(pWidth/4)-(offset/2), base+((ascent+descent)/2));
    if (mousePressed){
      if(inBorder(pX+(pWidth/4)-(pWidth/6), pX+(pWidth/4)-(pWidth/6)+(pWidth/3),
           pY+(pHeight*5/8), pY+(pHeight*5/8)+(pHeight/6))) {
      //download book
      println("yes");
      addBook(title);
      
      
    } else if(inBorder(pX+(3*pWidth/4)-(pWidth/6), pX+(3*pWidth/4)-(pWidth/6)+(pWidth/3),
              pY+(pHeight*5/8), pY+(pHeight*5/8)+(pHeight/6))) {
      println("no");
      prompt = false;
    }
   }

    s = "No";
    offset = textWidth(s);
    //hOffset = textHeight(s);
    text(s, pX+(pWidth*3/4)-(offset/2), base+((ascent+descent)/2));
  }

  boolean inBorder(float x1, float x2, float y1, float y2) {
    if(mouseX < x1 || mouseX > x2 || mouseY < y1 || mouseY > y2) {
      return false;
    }
    return true;
  }

  //void mouseClicked() {
  //  //yes check
  //  if(inBorder(pX+(pWidth/4)-(pWidth/6), pX+(pWidth/4)-(pWidth/6)+(pWidth/3),
  //              pY+(pHeight*5/8), pY+(pHeight*5/8)+(pHeight/6))) {
  //    //download book
  //    println("yes");
      
      
      
  //  } else if(inBorder(pX+(3*pWidth/4)-(pWidth/6), pX+(3*pWidth/4)-(pWidth/6)+(pWidth/3),
  //                     pY+(pHeight*5/8), pY+(pHeight*5/8)+(pHeight/6))) {
  //    println("no");
  //    prompt = false;
  //  }
  //}
  void addBook(String bookTitle){
    JSONArray values;
    RetrieveData r = new RetrieveData();
    try{
      String data = r.retrieveData("http://localhost:8080/all");
      values = parseJSONArray(data);
      if (values == null){
        println("JSONArray could not be parsed");
      }
      else{
      int id;
      String author;
      int copyright;
      String description;
      String image;
      int pageNumber;
      String title;
      String sql;
      //values.get
      if (db.connect()){
      for (int i = 0; i < values.size(); i++){
        if (values.getJSONObject(i).getString("title").equals(bookTitle)){
          id = values.getJSONObject(i).getInt("id");          
          author = values.getJSONObject(i).getString("author");
          copyright = values.getJSONObject(i).getInt("copyright");
          description = values.getJSONObject(i).getString("description");
          image = values.getJSONObject(i).getString("image");
          pageNumber = values.getJSONObject(i).getInt("pageNumber");
          title = values.getJSONObject(i).getString("title");
          sql = "INSERT INTO Book VALUES(" + id + ", '" + author + "', " + copyright + ", '" + description + "', '" + image + "', " + pageNumber + ", '" + title + "')";
          //sql = ".tables";
          db.query(sql);
        }
      }
      }

    }
  }
  catch (Exception e){
    println(e);
  }
  }
}
