class DummyPage {
  private String text;
  private PImage pic;
  private color c;
  
  public DummyPage(String textFile, String picFile, color c) {
     this.text = textFile;
     this.pic = loadImage(picFile);
     this.c = c;
  }
}
