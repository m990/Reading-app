class Page {
  private String text;
  private PImage illustration; 
  private color bgColor;
  private Audio audio;
  private int bookID;
  
  public Page(String text, String pFile, color bgColor, int bookID){
    this.text = text;
    this.illustration = loadImage(pFile);
    this.bgColor = bgColor;
    this.bookID = bookID;
  }
  
  public Page(String text, String pFile, color bgColor, String audioPath, int bookID){
    this.text = text;
    this.illustration = loadImage(pFile);
    this.bgColor = bgColor;
    audio = new Audio(audioPath);
    this.bookID = bookID;
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
  
  // Getter for audio
  Audio getAudio() {
   return audio; 
  }
  void stopSound() {
   if (audio != null) {
     audio.endSound();
   }
  }
  void playSound() {
   if (audio != null) {
    audio.startSound(); 
   }
  }
  // Getters and setters -- book id
  int getBookID(){
    return bookID;
  }
  void setBookID(int newBookID){
    bookID = newBookID;
  }
}
