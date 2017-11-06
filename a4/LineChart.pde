
class LineChart extends Chart{
  String[] names;
  float[] data;
  Point [] points;
  String xTitle, yTitle; 
  float yMin, yMax; 
  int xNum;
  float xMargin;
  float yMargin;
  float barFill = 0.8; 
  float barWidth, spacing;
  float xAxisLen;
  float yAxisLen;
  float ySpacing;  
  int chartW, chartH, chartX, chartY;


  LineChart(String xTitle, String yTitle, String[] days, float [] values, int chartX, int chartY, int chartW, int chartH) {
    super(chartX, chartY, chartW, chartH);

    this.xTitle = xTitle;
    this.yTitle = yTitle;
    this.names = days;
    this.data = values;
    this.yMin = min(values);
    this.yMax = max(values); 
    this.xNum = days.length; 
    this.chartH = chartH;
    this.chartW = chartW;
    this.xMargin = 0.15 * chartW; 
    this.yMargin = 0.15 * chartH;
    points = new Point[this.xNum];
    this.spacing = (chartW - 2 * xMargin)/xNum; 
    this.barWidth = this.barFill * spacing;
    this.chartX = chartX;
    this.chartY = chartY;
    calcStuff();
  }

  void calcStuff(){
    xAxisLen = (chartW - 2 * xMargin);
    yAxisLen = (chartH - 2 * yMargin);
    //spacing 

    float xStart = xMargin + chartX; 
    float yStart = yMargin + chartY; 
    ySpacing = (yAxisLen) / this.yMax;  
    
   
    for (int i = 0; i < xNum; i++) {
        float x, y; 
        float barHeight = this.data[i] * ySpacing; 
        x = xStart + this.spacing * i; 
        y = (yAxisLen - barHeight) + yStart;
        Point pnt = new Point(x + 10, y, this.names[i]);
        points[i] = pnt;
       
    }
  }
  
  void draw() { 
    drawLines();

    for (int i = 0; i < xNum; i++) {
      //stroke(color(55, 206, 229)); 
      fill(0);
      points[i].drawPoint();
    }
    
    for(int i = 0; i < xNum; i++) {
       Point pnt = points[i];
       if (pnt.intersect()) {
         pnt.highlighted(true);
         fill(0);
         text(this.data[i], mouseX + 10, mouseY + 10);
       } else {
         pnt.highlighted(false);
        }   
    }
  
    drawAxes();
  }
  
void drawAxes(){
    strokeWeight(1);
    stroke(0);
    fill(0); 
    line(xMargin + chartX, yMargin + chartY, xMargin + chartX, chartH - yMargin + chartY);
    line(xMargin + chartX, chartH - yMargin + chartY, chartW - xMargin + chartX, chartH - yMargin + chartY);
    float y_axis_spacing = (yAxisLen / 11);

    for (int i = 0; i < 12; i++) {
      float currY = chartH - yMargin - i * y_axis_spacing;
      line(xMargin - 5 + chartX, currY + chartY, xMargin + 5 + chartX, currY + chartY);
      float val = (1/ySpacing) * (yMargin - currY) + yAxisLen * (1/ySpacing);
      text(val, xMargin - 60 + chartX, currY + chartY); 
      
      
    }
    
    for (int i = 0; i < this.data.length; i++) {
      /* rotating x axis text */
      pushMatrix();
      translate(xMargin + 5 + this.spacing * i + chartX, yAxisLen + yMargin + chartY); //change origin 
      rotate(PI/2); //rotate around new origin 
      fill(0);
      text(" " + this.names[i], 0, 0); //put text at new origin 
      popMatrix();
     /* end rotate text */
    }
  }
  
  void drawLines(){
    for(int i = 0; i < points.length -1; i++){
      stroke(color(0, 0,0)); 
      strokeWeight(1);
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
    }
}
}