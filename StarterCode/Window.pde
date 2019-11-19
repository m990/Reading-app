class Window {
  DummyBook cBook;
  
  public Window(DummyBook b) {
    cBook = b;
  }
  
  void display(DummyPage p) {
    //displays p's data and cBook's title
    //p's data is the text and image
    background(p.c);
    p.pic.resize(100, 100);
    image(p.pic, 225, 50);
   

    //universal shapes for every page
    noStroke();
    fill(192, 192, 192);
    rect(0, 0, 500, 30);
    rect(0, 425, 500, 75);
    
    //title text
    surface.setTitle("Book: "+cBook.getTitle());
    textSize(32);
    fill(50, 50, 50);
    text(cBook.getTitle(), 225, 25);
   
    //page text
    textSize(500/p.text.length());
    fill(0, 102, 153);
    text(p.text, 250-p.text.length(), 490-(2*p.text.length()/3));
   
    //back and forth arrows (visible dependent on page)
    //i.e. on page 1, no back arrow, on last page, no forward arrow
    stroke(0, 0, 0);
    fill(192, 192, 192);
    boolean forward = true;
    boolean back = true;
    if(cBook.getCurPage() == 1) {
       back = false;
    }
    if(cBook.getCurPage() == cBook.getTotalPages()) {
       forward = false;
    }
    //currently won't display arrows because there is only 1 page
    //add interaction when clicking arrow
    //^ should set currentpage of book to cur+1
    //call display again
    if(back) {
       triangle(10, 455/2, 45, 125, 45, 330);
    }
    if(forward) {
       triangle(490, 455/2, 455, 125, 455, 330);  
    }
    
    //add home button
    
  }
  
  //add actionlistener to advance to next page
}
