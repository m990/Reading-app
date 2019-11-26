class Page {
  
  String text;
  PImage illustration; 
  int pageNumber;
  
  Page(String text, PImage illustration, int pageNumber){
    this.text = text;
    this.illustration = illustration;
    this.pageNumber = pageNumber;
  }
  
  
  // Getters and setters -- text
  String getText() {
   return text; 
  }
  void setText(String newText) {
   text = newText; 
  }
  
  // Getters and setters -- illustration
  PImage getIllustration() {
   return illustration; 
  }
  void setIllustration(PImage newImage) {
   illustration = newImage; 
  }
  
  // Getters and setters -- pageNumber
  int getPageNumber() {
   return pageNumber; 
  }
  
  void setPageNumber(int newPage) {
    pageNumber = newPage;
  }
}
