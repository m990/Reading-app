class DummyBook {
 private String title;
 private int nPages;
 private DummyPage currentPage;
 
 DummyPage[] pages = new DummyPage[nPages];
 
 public DummyBook(String title, int nPages, DummyPage[] pages) {
   if(pages.length != nPages) {
     System.out.println("Page number mismatch");
   }
   
   this.title = title;
   this.nPages = nPages;
   this.pages = pages;
   currentPage = pages[0];
 }
 
 public DummyPage getCurrentPage() {
   return currentPage;
 }
 
 
}
