Library l = new Library(new ArrayList<Book>());
PImage coverImage;
PImage coverImage2;
void setup() {
  background(0, 0, 0);
  size(1000, 500);
  coverImage = loadImage("Art Example Three.png");
  coverImage2 = loadImage("Art Example Two.png");
  for(int i = 0; i<34; i++){
       if( (int)Math.sqrt(i)%2 ==0 ){
            l.addBook(new Book("La Edad de Oro", new ArrayList<Page>(), coverImage));
       }else{
            l.addBook(new Book("El Presidio Político en Cuba", new ArrayList<Page>(), coverImage2));
       }
  }
}

void draw() {
  l.drawLibrary();
}
