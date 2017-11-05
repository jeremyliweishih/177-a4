class RadialChart {
 float[] data;
 String[] names;
 RadBar[] bars;
 float angleIncrem;
 float barWidth;
 PGraphics pickbuffer = null;
 color buff = color(55, 55, 255);

 
 RadialChart(String[] names, float[] data) {
   this.names = names;
   this.data = data;
   this.pickbuffer = createGraphics(width, height);
   this.barWidth = 50;
   bars = new RadBar[data.length];
   this.angleIncrem = (2 * PI) / data.length;
   pickbuffer = createGraphics(width, height);
   
   float increm = blue(buff) / data.length;  
   float angle = 0;
   for (int i = 0; i < data.length; i++) {
     bars[i] = new RadBar(barWidth, data[i], "bob", 0, 0, data[i], angle);
     angle += angleIncrem;
     println(degrees(bars[i].angle));
     bars[i].setBuffColor(buff);
     buff = color(red(buff), green(buff), blue(buff)-increm);
   }

 }
 
 void draw() {
   translate(width/2, height/2);
   for (RadBar b : bars) {
     b.drawBar();
   }
   
 }
 
 void drawPickBuffer() {
   pickbuffer.beginDraw();
   pickbuffer.translate(width/2, height/2);
   for (RadBar b : bars) {
     pickbuffer.fill(b.buffColor);
     pickbuffer.rotate(b.angle);
     pickbuffer.rect(b.x, b.y, b.w, b.h);
   }
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