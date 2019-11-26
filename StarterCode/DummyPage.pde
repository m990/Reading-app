class DummyPage {
  private String text;
  private PImage pic;
  private color c;
  
  public DummyPage(String text, String picFile, color c) {
     this.text = text;
     this.pic = loadImage(picFile);
     this.c = c;
  }
}
