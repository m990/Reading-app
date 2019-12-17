class Book {

  
  String title;
  ArrayList<Page> pages;
  PImage coverImage;
    Book (String title, ArrayList<Page> pages, PImage coverImage){
    this.title = title;
    this.pages = pages;
    this.coverImage = coverImage;
    pages.add(new Page(title, coverImage, 0));
  }
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
  PImage getCoverImg(){
    return coverImage;
  }
  void setCoverImg(PImage CoverImg){
    coverImage = CoverImg;
  }
}
