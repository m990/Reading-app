class Book {

  
  String title;
  ArrayList<Page> pages;
  PImage cover;
   
  Book (String title, ArrayList<Page> pages, PImage cover){
    this.title = title;
    this.pages = pages;
    this.cover = cover;
  }
  // Getters and setters
  PImage getCover() {
   return cover; 
  }
  void setCover(PImage cover){
   this.cover = cover;
  }
  String getTitle() {
   return title; 
  }
  void setTitle(String newTitle) {
   title = newTitle; 
  }
  
  ArrayList<Page> getPages() {
    return pages;
  }
  void setPages(ArrayList<Page> newPages) {
    pages = newPages; 
  }
  void setOnePage(Page p, int pageNumber) {
    // Sets object at pageNumber index to Page p
    pages.set(pageNumber, p); 
  }
}
