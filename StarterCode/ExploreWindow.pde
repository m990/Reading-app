import javax.swing.JOptionPane;


String s;
Library libra;
Window win;
boolean b = true;
class ExploreWindow{



  void setup(){

  }
  void drawExploreWindow(){
    if(b){
    s = JOptionPane.showInputDialog("What book do you want to search for?");
    }
    b = false;
    textSize((int) ((double)1 / (double)(sqrt(s.length())*8) * (double)height));
    text("Showing Results For: " + s, (int)((double)1/(double)40 * (double)width), (int)((double)3/(double)40 * (double)height));

   
  }
}
