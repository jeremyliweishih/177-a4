class RadialChart extends Chart {
 float[] data;
 String[] names;
 RadBar[] bars;
 float angleIncrem;
 float barWidth;
 float yMax;
 float yScale;
 int numIncrems;
 PGraphics pickbuffer = null;
 color buff = color(55, 55, 255);
 int chartW, chartH, chartX, chartY;
 float increm1, increm2;

 
 RadialChart(String[] names, float[] data, int chartX, int chartY, int chartW, int chartH) {
   super(chartX, chartY, chartW, chartH);
   this.names = names;
   this.data = data;
   //this.pickbuffer = createGraphics(width, height);
   this.barWidth = 10;
   this.yMax = findMax(data);
   this.yScale = (this.yMax - 50)/ (min(chartW, chartH)/2);
   bars = new RadBar[data.length];
   this.angleIncrem = (2 * PI) / data.length;
   this.chartH = chartH;
   this.chartW = chartW;
   this.chartX = chartX;
   this.chartY = chartY;
   this.numIncrems = 8;
   this.increm1 = (yMax * yScale)/ (numIncrems/2);

   this.pickbuffer = createGraphics(chartW + chartX, chartH + chartY);
   
   float increm = blue(buff) / data.length;  
   float angle = 0;
   for (int i = 0; i < data.length; i++) {
     bars[i] = new RadBar(barWidth, data[i] * yScale, names[i], 0, 0, data[i], angle);
     angle += angleIncrem;
     bars[i].setBuffColor(buff);
     buff = color(red(buff), green(buff), blue(buff)-increm);
   }

 }
 
 float findMax(float[] data) {
   float max = data[0];
   for (float d : data) {
     if (d > max) max = d;
   }
   return max;
 }
 
 void draw() {
   drawAxes();
   pushMatrix();
   translate(chartW/2 + chartX, chartH/2 + chartY) ;
   for (RadBar b : bars) {
     b.drawBar();
   }
   popMatrix();
   drawCircle();
   drawLabels();
   
 }
 
 void drawLabels(){
     pushMatrix();
     translate(chartW/2 + chartX, chartH/2 + chartY);
     line(0, 0, 0 + yMax * yScale, 0);
     fill(0);
     float increm2 = this.increm1;
     textSize(9);
     for(int i = 0; i < numIncrems; i++){
       text(Integer.toString((int)(yScale * increm2)), increm2/2, 0);
       increm2 += this.increm1;
     }
     textSize(12);
     
    for (RadBar b : bars) {
      text(b.name, (yMax * yScale + textWidth(b.name) + 5) * cos(b.angle + radians(90)), (yMax * yScale + textWidth(b.name) + 5) * sin(b.angle + radians(90)));    
    }
    popMatrix();
 }
 
 void drawCircle() {
     pushMatrix();
     translate(chartW/2 + chartX, chartH/2 + chartY);
     ellipseMode(CENTER);
     stroke(0);
     fill(255);
     ellipse(0, 0, this.increm1, this.increm1);
     popMatrix();
     strokeWeight(5);
     point(chartW/2 + chartX, chartH/2 + chartY);
     strokeWeight(1);
 }
 
 void drawAxes() {
   pushMatrix();
   translate(chartW/2 + chartX, chartH/2 + chartY);
   float increm2 = this.increm1;
   for (int i = 0; i < numIncrems; i++) {
     ellipseMode(CENTER);
     noFill();
     stroke(0);
     if(i == 1) fill(255);
     ellipse(0, 0, increm2, increm2);
     increm2 += this.increm1;
   }
   
   popMatrix();
   
 }
 
 void drawPickBuffer() {
   pickbuffer.beginDraw();
   pickbuffer.pushMatrix();
   pickbuffer.translate(chartW/2 + chartX, chartH/2 + chartY);
   for (RadBar b : bars) {
     pickbuffer.pushMatrix();
     pickbuffer.fill(b.buffColor);
     pickbuffer.rotate(b.angle);
     pickbuffer.rect(b.x, b.y, b.w, b.h);
     pickbuffer.popMatrix();
   }
   pickbuffer.popMatrix();
   pickbuffer.endDraw();

 }
 
 void radBarChartIsect() {
   drawPickBuffer();
  
   for (int i = 0; i< data.length; i++) { 
     if (bars[i].isect(pickbuffer) == true) {
       bars[i].highlighted();
     }
     else {
       bars[i].notHighlighted();
     }
   }  
 }
   
}