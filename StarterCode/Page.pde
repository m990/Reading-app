class Page {
  private String text;
  private PImage illustration; 
  private color bgColor;
  
  public Page(String text, String pFile, color bgColor){
    this.text = text;
    this.illustration = loadImage(pFile);
    this.bgColor = bgColor;
  }
  
  // Getters and setters -- text
  public String getText() {
   return text; 
  }
  public void setText(String newText) {
   text = newText; 
  }
  
  // Getters and setters -- illustration
  public PImage getIllustration() {
   return illustration; 
  }
  public void setIllustration(String pFile) {
   illustration = loadImage(pFile); 
  }
}
