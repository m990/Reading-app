class DummyPage {
  private PImage text;
  private PImage pic;
  private color c;
  
  public DummyPage(String textFile, String picFile, color c) {
     this.text = loadImage(textFile);
     this.pic = loadImage(picFile);
     this.c = c;
  }
}
