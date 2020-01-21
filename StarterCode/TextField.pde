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
        rect(x, y, w, h, 6);
    }

    public TextField(float x, float y, float w, float h, String text) {
        this(x, y, w, h);
        this.text = text;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void appendText(String append) {
        text = text+append;
    }

    public void updateText() {
        fill(0);
        textSize(16);
        text(this.text, x, y+h-(height/110));
    }
}