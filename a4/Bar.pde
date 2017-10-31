 class Bar {
  color c1, c2, currColor;
  color[] colours;
  String name;
  float value;
  float x, y;
  float w, h;
  float angle; //angle in degrees
  Point[] shape = new Point[4];
  int numPoints = 4;
  Point endP = new Point();

  
  
  Bar(float w, float h, String name, float x, float y, float value, float angle) {
    this.name = name;   
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.value = value;
    this.angle = angle;
    c1 = color(158, 220, 229);
    c2 = color(55, 206, 229);
    currColor = c1; 
    Point p1 = new Point();
    Point p2 = new Point();
    Point p3 = new Point();
    Point p4 = new Point();
    
    p1.x = x;
    p1.y = y;
    p2.x = h * cos(angle) + x;
    p2.y = h * sin(angle) + y;
    p3.x = w * cos(angle + PI) + x;
    p3.y = w * sin(angle + PI) + y;
    p4.x = w * cos(angle + PI) + p2.x;
    p4.y = w * sin(angle + PI) + p2.y;
    
    shape[0] = p1;
    shape[1] = p2;
    shape[2] = p3;
    shape[3] = p4;
    
    endP.x = random(-1, 1) * 2 * width;
    endP.y = random(-1, 1) * 2 * height;
 } 
 
 void setColor(color c) {
  this.c1 = c; 
 }
   
 
 void drawBar() {
   if (false) {
     currColor = c2;
   } else {
     currColor = c1;
   }
    stroke(0);
    fill(currColor);
    rotate(angle);
    rect(x, y, w, h);
  }
    
  // x = rcos(theta)
  // y = rsin(theta)
  //boolean intersect() {
  //  if (mouseX >= this.x && mouseX <= this.w + this.x && 
  //        mouseY > this.y  && mouseY < this.y + this.h) {
  //    return true;
  //  } else {
  //    return false;
  //  }
  //}
  
  void changeHeight(float change) {
    this.h += change;
  }
  
  void changeWidth(float change) {
   this.w += change;
  }
  
  boolean isectTest() {
    Point mouse = new Point();
    mouse.x = mouseX;
    mouse.y = mouseY;
    int numIsects = 0;
    for (int i = 0; i < numPoints; i++) {
      int start = i;
      int end = (i + 1) % numPoints;
      Point startPoint = new Point();
      Point endPoint = new Point();
      startPoint.x = shape[start].x;
      startPoint.y = shape[start].y;
      endPoint.x = shape[end].x;
      endPoint.y = shape[end].y;
      if (lineIsect (mouse, endP, startPoint, endPoint)) {
        numIsects++;
      }
    }
    println("total intersections:", numIsects);
    return (! ((numIsects % 2) == 0));
  }
  
  boolean isBetween(float val, float range1, float range2) {
      float largeNum = range1;
      float smallNum = range2;
      if (smallNum > largeNum) {
          largeNum = range2;
          smallNum = range1;
      }
  
      if ((val < largeNum) && (val > smallNum)) {
          return true;
      }
      return false;
  }
  
  boolean lineIsect(Point p1, Point q1, Point p2, Point q2) {
      float a1 = p1.y - q1.y;
      float b1 = q1.x - p1.x;
      float c1 = q1.x * p1.y - p1.x * q1.y;
  
      float a2 = p2.y - q2.y;
      float b2 = q2.x - p2.x;
      float c2 = q2.x * p2.y - p2.x * q2.y;
  
      float det = a1 * b2 - a2 * b1;
  
      //if (det == 0) {
      if (isBetween(det, -0.0000001, 0.0000001)) {
          return false;
      } else {
          float isectx = (b2 * c1 - b1 * c2) / det;
          float isecty = (a1 * c2 - a2 * c1) / det;
  
          //println ("isectx: " + isectx + " isecty: " + isecty);
  
          if ((isBetween(isecty, p1.y, q1.y) == true) &&
              (isBetween(isecty, p2.y, q2.y) == true) &&
              (isBetween(isectx, p1.x, q1.x) == true) &&
              (isBetween(isectx, p2.x, q2.x) == true)) {
              return true;
          }
      }
  
      return false;
  }
}