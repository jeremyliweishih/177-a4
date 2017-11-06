RadialChart rc;
LineChart lc;
SquareMap square;

void setup() {
  size(1000, 750);
  String[] names = {"hi", "bob", "charlie", "poop", "blah", "pls"};
  float [] data = {200.0, 200.0, 200.0, 200.0, 200.0, 200.0};
  rc = new RadialChart(names, data, 0, 0, width/2, height/2);
  lc = new LineChart("names", "data", names, data, 0, height/2, width/2, height/2);

  square = new SquareMap(width/2, height, width/2);
  
}

void draw() {
 background(255); 
 rc.draw();
 lc.draw();
 pushMatrix();
 translate(width/2, 0);
 square.draw();
 popMatrix();
 
}


void mouseMoved() {
  rc.radBarChartIsect();
   
}

void mouseClicked() {
  square.mouseClicked();
}