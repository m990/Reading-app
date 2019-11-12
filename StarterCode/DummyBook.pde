class DummyBook {
 private String title;
 private int nPages;
 //current page object
 private DummyPage currentPage;
 //current page #
 private int curPageN;
 
 DummyPage[] pages = new DummyPage[nPages];
 
 public DummyBook(String title, int nPages, DummyPage[] pages) {
   if(pages.length != nPages) {
     System.out.println("Page number mismatch");
   }
   
   this.title = title;
   this.nPages = nPages;
   this.pages = pages;
   currentPage = pages[0];
   curPageN = 1;
 }
 
 public DummyPage getCurrentPage() {
   return currentPage;
 }
 
 public String getTitle() {
   return title;
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
 
 
}
