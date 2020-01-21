// Instead of creating a window object with a book, you have a window object and you have a setter that puts in the book later
// Put all visual stuff inside a second method

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
  Page[] p2 = {new Page("Text", "Art Example One.png", color(0, 0, 0))};
  b1 = new Book("Test", 2, p, cover1);
  Book b2 = new Book("Test2", 1, p2, cover2);
  
  w = new Window();
  
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
  l.addBook(b2);
    l.addBook(b1);
  l.addBook(b2);
    l.addBook(b1);
      l.addBook(b2);
    l.addBook(b1);
      l.addBook(b2);




  // For now, this is only used to launch the window because it requires a book to be launched.
  // This book isn't used otherwise and is not the same as the default book
  Page[] examplePages = {new Page("Access books in your library.", "Centered? User Guide Title.png", color(255, 255, 255)), new Page("Switch pages by using the side arrows.", "Centered? User Guide Title.png", color(255, 255, 255)), new Page("Return to the library by clicking exit.", "Centered? User Guide Title.png", color(255, 255, 255))};
  Book b1 = new Book("prueba", 3, examplePages, "Art Example Three.png");
  l = new Library();
  
  w = new Window(b1);
  background(0, 0, 0);
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
}

void mousePressed() {
  w.mousePressed();
}

void mouseReleased() {
  w.mouseReleased();
}
