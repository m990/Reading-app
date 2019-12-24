Library l;
Window w;
Book b1;
int currentPage;
boolean inLibrary = true;
void setup() {
  size(500, 500);
  String cover1 = "Art Example Two.png";
  String cover2 = "Art Example Three.png";
  
  Page[] p = {new Page("I ran.", "pixil-frame-0.png", color(255, 255, 255)), new Page("I ran2.", "img2.png", color(255, 255, 255))};
  b1 = new Book("Test", 2, p, cover1);
  Book b2 = new Book("Test2", 2, p, cover2);
  w = new Window(b1);
  
  l = new Library();
  
  currentPage = l.getCurrentPage();
  
  background(0, 0, 0);
  /*for(int i = 0; i<34; i++){
       if( (int)Math.sqrt(i)%2 ==0 ){
            l.addBook(b1);
       }else{
            l.addBook(b2);
       }
  }*/
  l.addBook(b1);
  l.addBook(b1);
    l.addBook(b1);
  l.addBook(b1);
    l.addBook(b1);
  l.addBook(b1);
    l.addBook(b1);
  l.addBook(b1);
    l.addBook(b1);
  l.addBook(b1);
    l.addBook(b1);
  l.addBook(b1);
}

void draw() {
  // 78, 99
  // 214, 100
  // 81, 241
  // 221, 239
  //draws the library
  if (inLibrary) l.drawLibrary();
  if (mousePressed){
// top left corner button
  if (mouseX > 78 && mouseX < 214 && mouseY > 99 && mouseY < 241){
    inLibrary = false;
    println("top left is pressed");
    if (currentPage == 1){
      w.setBook(b1);
      w.drawWindow();
    }
  }
  if (mouseX > 289 && mouseX < 427 && mouseY > 99 && mouseY < 241) println("button pressed");
  if (mouseX > 78 && mouseX < 214 && mouseY > 314 && mouseY < 453) println("button pressed");
  if (mouseX > 289 && mouseX < 427 && mouseY > 314 && mouseY < 453) println("button pressed");
 }
  // draws the book
  //w.draw();
}

void mousePressed() {
  w.mousePressed();
}

void mouseReleased() {
  w.mouseReleased();
}
