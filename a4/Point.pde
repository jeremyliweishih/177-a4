class Point{
  float x, y;
  String name;
  color c1, c2, currColor;
  
  Point(float x, float y, String name, color c){
      this.x = x;
      this.y = y;
      this.name = name;
      this.c1 = c;
      this.c2 = color(red(c) * 0.7, green(c) * 0.7, blue(c) * 0.7);
      this.currColor = c1;
  }
  
  void drawPoint(){
     strokeWeight(7);
     stroke(currColor);
     point(x,y); 
  }
  
  void highlighted(boolean isect) {
    if (isect) { 
      currColor = c2;
    } else {
      currColor = c1;
     }
   }
  
  boolean intersect() {
   if (mouseX <= this.x + 1 && mouseX >= this.x - 1 && mouseY <= this.y + 5 && mouseY >= this.y-5) return true;
   
   return false;
  }
}