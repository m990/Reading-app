Library l;
Window w;
void setup() {
  size(500, 500);
  String cover1 = "Art Example Two.png";
  String cover2 = "Art Example Three.png";
  
  Page[] p = {new Page("I ran.", "pixil-frame-0.png", color(255, 255, 255)), new Page("I ran2.", "img2.png", color(255, 255, 255))};
  Book b1 = new Book("Test", 2, p, cover1);
  Book b2 = new Book("Test2", 2, p, cover2);
  
  l = new Library();
  w = new Window(b1);
  background(0, 0, 0);
  for(int i = 0; i<34; i++){
       if( (int)Math.sqrt(i)%2 ==0 ){
            l.addBook(new Book("La Edad de Oro", 2, p, cover1));
       }else{
            l.addBook(new Book("El Presidio Político en Cuba", 2, p, cover2));
       }
  }
}

void draw() {
  clear();
  if(keyPressed) {
   l.drawLibrary();
  } else {
    w.draw();
  }
}

void mousePressed() {
  w.mousePressed();
}

void mouseReleased() {
  w.mouseReleased();
}
