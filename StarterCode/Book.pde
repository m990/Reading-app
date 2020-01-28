class Book {
 private String title;
 private int nPages;
 //current page object
 private Page currentPage;
 //current page #
 private int curPageN;
 private PImage coverImg;
 private int page;
 private int spot;
 
 private Page[] pages;

 public Book(String title, int nPages, Page[] pages, String coverFile) {
   if(pages.length != nPages) {
     System.out.println("Page number mismatch");
   }
   
   this.pages = pages;
   this.title = title;
   this.nPages = nPages;
   this.pages = pages;
   currentPage = pages[0];
   curPageN = 1;
   coverImg = loadImage(coverFile);
 }
 
 public String getTitle() {
   return title;
 }
 
 public Page getCurrentPage() {
   return currentPage;
 }
 
 public int getCurPage() {
   return curPageN; 
 }
 
 public void setCurPage(int n) {
   curPageN = n; 
 }
 
 public int getTotalPages() {
   return nPages; 
 }
 
 public PImage getCoverImg() {
   return coverImg;
 }
 public void setPage(int p){
   page = p;
 }
 public int getPage(){
   return page;
 }
 public void setSpot(int s){
   spot = s;
 }
 public int getSpot(){
   return spot;
 }
}
