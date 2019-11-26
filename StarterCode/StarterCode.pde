Window w;
DummyBook book;


void setup() {
  size(500, 500);
}

void draw() {

  DummyPage[] p = {new DummyPage("Min aka Stal-min", "img1.png", color(255, 255, 255))};
  book = new DummyBook("Test", 1, p);
  w = new Window(book);
  
  w.display(book.getCurrentPage());
}
