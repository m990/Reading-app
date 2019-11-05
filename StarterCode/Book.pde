class Book {
  
  String title;
  ArrayList<Page> pages;
  
  // Getters and setters
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
