// Instead of creating a window object with a book, you have a window object and you have a setter that puts in the book later
// Put all visual stuff inside a second method

Library l;
Window w;
int currentPage;
public static boolean inLibrary = true;
public static boolean inWindow = false;

void setup() {
  size(750, 750);
  // For now, this is only used to launch the window because it requires a book to be launched.
  // This book isn't used otherwise and is not the same as the default book
  String cover1 = "Art Example Two.png";
  String cover2 = "Art Example Three.png";
  
  Page[] p = {new Page("I ran.", "pixil-frame-0.png", color(255, 255, 255)), new Page("I ran2.", "img2.png", color(255, 255, 255))};
  Page[] p2 = {new Page("Text", "Art Example One.png", color(0, 0, 0))};
  Book b1 = new Book("Test", 2, p, cover1);
  Book b2 = new Book("Test2", 1, p2, cover2);
  Book b3 = new Book("Test3", 1, p2, cover2);
  
  w = new Window(b1);
  l = new Library(this);
  
  currentPage = l.getCurrentPage();
  
  background(0, 0, 0);
  
  l.addBook(b1);
  l.addBook(b2);
  l.addBook(b3);
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
