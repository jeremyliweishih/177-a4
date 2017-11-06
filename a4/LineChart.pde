
class LineChart extends Chart{
  //String[] names;
  float[] data;
  Point [] points;
  String xTitle, yTitle; 
  float yMax; 
  int xNum;
  float xMargin;
  float yMargin;
  float barFill = 0.8; 
  float barWidth, spacing;
  float xAxisLen;
  float yAxisLen;
  float ySpacing;  
  int chartW, chartH, chartX, chartY;
  Hashtable<String, Float[]> values;
  Line[] types;


  LineChart(String xTitle, String yTitle, float [] data, int chartX, int chartY, int chartW, int chartH, Hashtable<String, Float[]> values) {
    super(chartX, chartY, chartW, chartH);
    
    this.values = values;
    this.types = new Line[values.size()];
    
    this.xTitle = xTitle;
    this.yTitle = yTitle;
    this.data = data; 
    this.xNum = data.length; 
    this.chartH = chartH;
    this.chartW = chartW;
    this.xMargin = 0.15 * chartW; 
    this.yMargin = 0.15 * chartH;
    this.spacing = (chartW - 2 * xMargin)/xNum; 
    this.barWidth = this.barFill * spacing;
    this.chartX = chartX;
    this.chartY = chartY;
    
    makeLines(); 
    this.yMax = getTotalMax(); 
    
    calcStuff();
 
    
  }
  
  
  float getTotalMax() {
    float max = types[0].yMax;
    for (Line l : this.types) {
      if (l.yMax > max) max = l.yMax;
    }
    return max;
  }
  
  void makeLines() {
   Set<String> keys = values.keySet();
   int curr = 0;
   for (String k : keys) {
     Float[] gens = this.values.get(k);
     this.types[curr] = new Line(gens, k, this.xAxisLen, this.yAxisLen, this.chartX, this.chartY, this.xMargin, this.yMargin, this.barWidth, this.spacing);
     curr++;
   }

  }

  void calcStuff(){
    this.xAxisLen = (chartW - 2 * xMargin);
    this.yAxisLen = (chartH - 2 * yMargin);
    //spacing 

    //float xStart = xMargin + chartX; 
    //float yStart = yMargin + chartY; 
    this.ySpacing = (yAxisLen) / this.yMax;
    for (Line l : types) l.calcStuff(this.ySpacing);
    
   
    //for (int i = 0; i < xNum; i++) {
    //    float x, y; 
    //    float barHeight = this.data[i] * ySpacing; 
    //    x = xStart + this.spacing * i; 
    //    y = (yAxisLen - barHeight) + yStart;
    //    Point pnt = new Point(x + 10, y, this.names[i]);
    //    points[i] = pnt;
       
    //}
  }
  
  void draw() { 
    for (Line l : this.types) l.draw();

    //for (int i = 0; i < xNum; i++) {
    //  //stroke(color(55, 206, 229)); 
    //  fill(0);
    //  points[i].drawPoint();
    //}
    
    //for(int i = 0; i < xNum; i++) {
    //   Point pnt = points[i];
    //   if (pnt.intersect()) {
    //     pnt.highlighted(true);
    //     fill(0);
    //     text(this.data[i], mouseX + 10, mouseY + 10);
    //   } else {
    //     pnt.highlighted(false);
    //    }   
    //}
  
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
      text(" Generation" + Integer.toString(i+1), 0, 0); //put text at new origin 
      popMatrix();
     /* end rotate text */
    }
  }
  

}