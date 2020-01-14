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
  l.addBook(new Book("1", 2, p, cover1));
  l.addBook(new Book("2", 2, p, cover2));
  l.addBook(new Book("3", 2, p, cover1));
  l.addBook(new Book("4", 2, p, cover2));
  l.addBook(new Book("5", 2, p, cover2));
  
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
