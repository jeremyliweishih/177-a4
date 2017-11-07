
class LineChart{
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
  Hashtable<String, Integer> typeColours;
  ArrayList<String> hovered;

  LineChart(String xTitle, String yTitle, int chartX, int chartY, int chartW, int chartH, Hashtable<String, Float[]> values, Hashtable<String, Integer> typeColours, ArrayList<String> h) {
    this.hovered = h;
    this.values = values;
    this.types = new Line[values.size()];
    
    this.xTitle = xTitle;
    this.yTitle = yTitle;
    this.xNum = 6;
    this.chartH = chartH;
    this.chartW = chartW;
    this.xMargin = 0.15 * chartW; 
    this.yMargin = 0.15 * chartH;
    this.spacing = (chartW - 2 * xMargin)/xNum; 
    this.barWidth = this.barFill * spacing;
    this.chartX = chartX;
    this.chartY = chartY;
    this.typeColours = typeColours;
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
   for (String type : keys) {
     Float[] gens = this.values.get(type);
     color c = typeColours.get(type);
     this.types[curr] = new Line(gens, type, this.chartX, this.chartY, this.xMargin, this.yMargin, this.barWidth, this.spacing, c);
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
    for (Line l : types) l.calcStuff(this.ySpacing, this.xAxisLen, this.yAxisLen);
    
   
    //for (int i = 0; i < xNum; i++) {
    //    float x, y; 
    //    float barHeight = this.data[i] * ySpacing; 
    //    x = xStart + this.spacing * i; 
    //    y = (yAxisLen - barHeight) + yStart;
    //    Point pnt = new Point(x + 10, y, this.names[i]);
    //    points[i] = pnt;
       
    //}
  }
  
  Message draw() { 
    Message m = new Message(-1, "", "");
    if(hovered.size() != 0){
      int hiSection = Integer.valueOf(hovered.get(0).split(" ")[1]) - 1;
      fill(color(158, 220, 229));
      stroke(color(158, 220, 229));
      rect(xMargin + this.spacing * hiSection + chartX, chartY + yMargin, this.spacing * 0.7, yAxisLen);
    }
    for (Line l : this.types) {
      strokeWeight(1);
      if(hovered.size() > 1){
        if (l.type.equals(hovered.get(1))) {
          strokeWeight(5);
          l.currColor = (color(255,230,45));
          //stroke(color(255,230,45));
        } else {
          l.currColor = typeColours.get(l.type);
          //stroke(0);
          strokeWeight(1);
        }
      }
      Message temp_m = l.draw();
      if(!temp_m.type1.isEmpty()) m = temp_m;
    }
    drawAxes();

    return m;
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
    
    for (int i = 0; i < xNum; i++) {
      /* rotating x axis text */
      pushMatrix();
      translate(xMargin + 5 + this.spacing * i + chartX, yAxisLen + yMargin + chartY); //change origin 
      rotate(PI/2); //rotate around new origin 
      fill(0);
      text(" Gen " + Integer.toString(i+1), 0, 0); //put text at new origin 
      popMatrix();
     /* end rotate text */
    }
  }
  

}