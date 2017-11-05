RadialChart rc;

void setup() {
  size(600, 600);
  String[] names = {"hi", "bob", "charlie", "poop", "blah", "pls"};
  float [] data = {200.0, 200.0, 200.0, 200.0, 200.0, 200.0};
  rc = new RadialChart(names, data);
}

void draw() {
 background(255); 
 rc.draw();
 
}


void mouseMoved() {
  rc.radBarChartIsect();
   
}