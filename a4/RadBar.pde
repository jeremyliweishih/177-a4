 class RadBar {
  color c1, c2, currColor, buffColor;
  String name;
  float value;
  float x, y;
  float w, h, angle;
  
  RadBar(float w, float h, String name, float x, float y, float value, float angle) {
    this.name = name;   
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.value = value;
    c1 = color(158, 220, 229);
    c2 = color(55, 206, 229);
    currColor = c1; 
 } 
 
 void setBuffColor(color c) {
   this.buffColor = c;  
 }
  
 void drawBar() {
    stroke(0);
    fill(currColor);
    pushMatrix();
    rotate(angle);
    rect(x, y, w, h);
    popMatrix();
  }
    

  void highlighted() {
    this.currColor = this.c2;  
  }
  
  void notHighlighted() {
    this.currColor = this.c1; 
  }
  
  boolean isect(PGraphics pg) {
    color c = pg.get(mouseX, mouseY);
    if (c == buffColor) {
      println("aifalksfja");
      return true;
    }
    return false;
  }
  
}