class TextField {
    private float x;
    private float y;
    private float w;
    private float h;

    private String text = "";

    public TextField(float x, float y, float w, float h) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        
        fill(#ffffff);
        rect(x, y, w, h, 5);
    }

    public TextField(float x, float y, float w, float h, String text) {
        this(x, y, w, h);
        this.text = text;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public float getW() {
        return w;
    }

    public float getH() {
        return h;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int strLength() {
        return text.length();
    }

    public void appendText(String append) {
        text = text+append;
    }

    public void updateText(int blinkCounter, boolean display) {
        fill(0);
        textSize(16);
        text(this.text, x+(float)w/40, y+h-(height/110));

        //blinking animation
        //display if searchField is clicked
        //blinkCounter ensures drawn in 16/32 iterations
        if(display && blinkCounter < 16) {
            line(x+textWidth(this.text)+(float)w/30, y+(float)h/20, x+textWidth(this.text)+(float)w/30, y+h-(height/110)+(float)h/20);
        }
    }
}