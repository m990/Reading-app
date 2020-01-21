import javax.swing.JOptionPane;


String s;
Library libra;
Window win;
boolean b = true;
class ExploreWindow{



  void setup(){

  }
  void drawExploreWindow(){
    if(b){
    s = JOptionPane.showInputDialog("What book do you want to search for?");
    }
    b = false;
    textSize((int) ((double)1 / (double)(sqrt(s.length())*8) * (double)height));
    text("Showing Results For: " + s, (int)((double)1/(double)40 * (double)width), (int)((double)3/(double)40 * (double)height));
    l.getBooks();
     int newHeight = height - (int)((double)height/(double)10);
     int xOffset = (int) ((double) 1/2 * (double) (width - (double) 285/2 - (((double) (2*2-1)*428)/2)));
    int yOffset = (int)((double)height/10) + (int) ((double) 1/2 * (double) (newHeight - (double) 285/2 - (double) (2-1)* (double) 428/2));
    ArrayList<Book> bookList = new ArrayList<Book>(l.books.values());
    for(StarterCode.Book book: bookList){
      if(book.title.contains(s)){
        PImage cover = book.getCoverImg();
        cover.resize(285/2, 285/2);
        image(cover, xOffset+(i % (2*2)) * 428/2, yOffset+(i - (i % (2*2)))/(2 * 2) * 428/2);
      }
    }
  }
    //this will do something i'm not sure what it is yet.
    
  }
