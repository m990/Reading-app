Window w;
DummyBook book;

void setup() {
  size(500, 500);
}

void draw() {
  DummyPage[] p = {new DummyPage("text1", "img1")};
  book = new DummyBook("Test", 1, p);
  w = new Window(book);
  
  w.display(book.getCurrentPage());
}
