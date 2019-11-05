class DummyPage {
  private String text;
  private PImage pic;
  
  public DummyPage(String text, String file) {
     this.text = text;
     this.pic = loadImage(file);
  }
}
