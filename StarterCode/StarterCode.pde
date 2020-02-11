Library l;
Window w;

void setup() {
  size(500, 500);
  // For now, this is only used to launch the window because it requires a book to be launched.
  // This book isn't used otherwise and is not the same as the default book
  Page[] examplePages = {new Page("Access books in your library.", "Centered? User Guide Title.png", color(255, 255, 255)), new Page("Switch pages by using the side arrows.", "Centered? User Guide Title.png", color(255, 255, 255)), new Page("Return to the library by clicking exit.", "Centered? User Guide Title.png", color(255, 255, 255))};
  Book b1 = new Book("prueba", 3, examplePages, "Art Example Three.png");
  l = new Library(this);
  for(int i = 0; i < 4; i++) {
    l.addBook(new Book(i+"", 3, examplePages, "Art Example Three.png"));
  }
  
  w = new Window(b1);
  background(0, 0, 0);
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
