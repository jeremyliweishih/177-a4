import java.util.*;

RadialChart rc;
LineChart lc;
SquareMap square;
Hashtable<String, Hashtable<String, Integer>>[] hierarchy;
int numGens, numTypes, numSubTypes;


void setup() {
  size(1000, 750);
  String[] names = {"hi", "bob", "charlie", "poop", "blah", "pls"};
  float [] data = {200.0, 200.0, 200.0, 200.0, 200.0, 200.0};
  rc = new RadialChart(names, data, 0, 0, width/2, height/2);

  lc = new LineChart("names", "data", data, 0, height/2, width/2, height/2, null);
  TreeNode root = parseData();
  square = new SquareMap(width/2, height, width/2, root);
  
}

TreeNode parseData() {
  this.numGens = hierarchy.length;
  int sum = 0;
  TreeNode root = new TreeNode("root", sum);
  for (int i = 0; i < this.numGens; i++) {
    Hashtable<String, Hashtable<String, Integer>> gen = hierarchy[i];
    Set<String> keys = gen.keySet();
    for (String key : keys) {
      Hashtable<String, Integer> type = gen.get(key);
      int valLeaf = 0;
      TreeNode child = new TreeNode(key, valLeaf);
      Set<String> subTypes = type.keySet();
      for (String k : subTypes) {
        TreeNode gc = new TreeNode(k, type.get(k));
        child.children.add(gc);
        valLeaf += gc.value;
        sum += valLeaf;
      }
      child.value = valLeaf;
      root.children.add(child);
    }
  }
  root.value = sum;
  return root;
  
  
  
  
  
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