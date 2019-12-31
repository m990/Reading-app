Library l;
Window w;
void setup() {
  size(500, 500);
  String cover1 = "Art Example Two.png";
  String cover2 = "Art Example Three.png";

  Page[] examplePages = {new Page("Access books in your library.", "Centered? User Guide Title.png", color(255, 255, 255)), new Page("Switch pages by using the side arrows.", "Centered? User Guide Title.png", color(255, 255, 255)), new Page("Return to the library by clicking exit.", "Centered? User Guide Title.png", color(255, 255, 255))};
  Book b1 = new Book("Test", 3, examplePages, cover1);
  Book b2 = new Book("Test2", 3, examplePages, cover2);
  
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
