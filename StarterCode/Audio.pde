import processing.sound.*;

class Audio {
 // Data + variables
 SoundFile soundFile;
 
 // Constructors
 public Audio(String path) {
   soundFile = new SoundFile(StarterCode.this, path);
 }
 
 // Methods
 void startSound() {
   soundFile.play();
 }
 
 void endSound() {
  soundFile.stop(); 
 }
}
