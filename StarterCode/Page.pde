class Page {
  private String text;
  private PImage illustration; 
  private color bgColor;
  private Audio audio;
  
  public Page(String text, String pFile, color bgColor){
    this.text = text;
    this.illustration = loadImage(pFile);
    this.bgColor = bgColor;
  }
  
  public Page(String text, String pFile, color bgColor, String audioPath){
    this.text = text;
    this.illustration = loadImage(pFile);
    this.bgColor = bgColor;
    audio = new Audio(audioPath);
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
  
  // TODO add getter/setter (?) for the audio
}
