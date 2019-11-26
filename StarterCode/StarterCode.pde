void setup() {
  size(500, 500);
}

void draw() {
  DummyPage[] p = {new DummyPage("I ran.", "img1.png", color(255, 255, 255)), new DummyPage("I ran2.", "img2.png", color(255, 255, 255))};
  DummyBook book = new DummyBook("Test", 2, p);
  Window w = new Window(book);
  
  w.draw();

}
