Bar [] bars;
color c1 = color(10, 10, 10);

PGraphics pickbuffer = null;
void setup(){
  size(500,500);
  pickbuffer = createGraphics(width, height);
  float angle = 0;
  bars = new Bar[4];
  for (int i = 0; i < 4; i++) {
    bars[i] = new Bar (10, 50, "bob", 0,0, 50, angle);
    angle += PI/2;
  }
  
  pickbuffer.beginDraw();
  for (Bar b : bars) {
   pickbuffer.fill(c1);
   pushMatrix();
   translate(width/2, height/2);
   rotate(b.angle);
   popMatrix();
   pickbuffer.rect(b.x, b.y, b.w, b.h);
  }
  pickbuffer.endDraw();
 

}

void draw(){
  background(255);
      translate(width/2, height/2);

  for (Bar b : bars) {
   b.drawBar(); 
  }
}

void mouseMoved() {
 for (int i = 0; i < 4; i++ ) {
   if (pickbuffer.get(mouseX, mouseY) == c1) println("intersect");
   
 }
}

//void setup(){
//   size(500,500); 
//}

//float angle = 0;
//void draw(){
//  angle += 0.01;
//  background(255);
//  translate(250, 250);
//  rotate(0);
//  rect(0, 0, 25, 50);
//  //for(int i = 0; i < 4; i++){
//  //  //translate(width/2, height/2);
//  //   rotate(angle);
//  //   rect(250, 250, 25, 50);
//  //   angle+= PI/2;
//  //}
//}  