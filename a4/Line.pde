
class Line{
  Float[] data;
  Point [] points;
  String type; 
  float yMax; 
  int xNum;
  float xMargin;
  float yMargin;
  float barFill = 0.8; 
  float barWidth, spacing;
  float xAxisLen;
  float yAxisLen;
  float ySpacing;  
  int chartX, chartY;
  color currColor;


  Line(Float[] data, String type, int chartX, int chartY, float xMargin, float yMargin, float barWidth, float spacing, color c) {
    this.data = data;
    this.type = type;
    this.xNum = data.length;
    this.yMax = getMax();

    this.chartX = chartX;
    this.chartY = chartY;
    this.xMargin = xMargin;
    this.yMargin = yMargin;
    this.spacing = spacing;
    this.barWidth = barWidth;
    this.points = new Point[data.length];
    this.currColor = c;
  }
  
  float getMax() {
    Float max = data[0];
    for (int i = 1; i < data.length; i++) {
      if (data[i] > max) max = data[i];
    }
    return max;
  }

  void calcStuff(float ySpacing, float xAxisLen, float yAxisLen){
    float xStart = xMargin + chartX; 
    float yStart = yMargin + chartY; 
    this.ySpacing = ySpacing;
    this.xAxisLen = xAxisLen;
    this.yAxisLen = yAxisLen;
   //println(xStart, yStart, "xstart and y start");
    for (int i = 0; i < xNum; i++) {
        float x, y; 
        float barHeight = this.data[i] * ySpacing; 
        x = xStart + this.spacing * i; 
        y = (yAxisLen - barHeight) + yStart;

        Point pnt = new Point(x + 10, y, this.type, this.currColor);
        points[i] = pnt; 
       
    }
  }
  
  Message draw() { 
    drawLines();
    String type = "";
    int g = -1;
    for (int i = 0; i < xNum; i++) {
      //stroke(color(55, 206, 229)); 
      fill(0);
      points[i].drawPoint();
    }
    
    for(int i = 0; i < xNum; i++) {
       Point pnt = points[i];
       if (pnt.intersect()) {
         type = pnt.name;
         g = i + 1;
         pnt.highlighted(true);
         drawLabelBox(pnt, this.data[i]);
         //fill(0);
         //text(pnt.name, mouseX + 10, mouseY + 10);
         //text(this.data[i], mouseX + 10, mouseY + 10 + textDescent() + textAscent());
       } else {
         pnt.highlighted(false);
        }   
    }
    
    return new Message(g, type, "");
  }
  
  void drawLabelBox(Point p, float val) {
    String type = p.name;
    String value = Float.toString(val);
    
    float padding = 2 * 5;
    
    float boxW = max(textWidth(type), textWidth(value)) + 2 * padding;
    float boxH = 2 * (textAscent() + textDescent() + padding);
    float boxX = mouseX + 10;
    float boxY = mouseY - boxH - padding;
    stroke(0);
    strokeWeight(1);
    fill(255);
    rect(boxX, boxY, boxW, boxH);
    fill(0);
    text(type, boxX + padding, boxY + (textAscent() + textDescent()) + padding);
    text(value, boxX + padding, boxY + 2 * (textAscent() + textDescent()) + padding);
    
  }
  

  
  void drawLines(){
    for(int i = 0; i < points.length -1; i++){
      stroke(currColor); 
      //strokeWeight(1);
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
    }
  }
}