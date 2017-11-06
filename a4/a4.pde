import java.util.*;

RadialChart rc;
LineChart lc;
SquareMap square;
Hashtable<String, Hashtable<String, Integer>>[] hierarchy;
int numGens, numTypes, numSubTypes;
Model model;


void setup() {
  size(1500, 1000);
  String[] names = {"hi", "bob", "charlie", "poop", "blah", "pls"};
  float [] data = {200.0, 200.0, 200.0, 200.0, 200.0, 200.0};
  model = new Model();
  this.hierarchy = model.getHierarchy();

  rc = new RadialChart(names, data, 0, 0, width/2, height/2);

  //lc = new LineChart("names", "data", data, 0, height/2, width/2, height/2, null);
  TreeNode root = parseData();
  square = new SquareMap(width/2, height, width/2, root);
  
}

TreeNode parseData() {
  this.numGens = hierarchy.length;
  
  int sum = 0;
  TreeNode root = new TreeNode("root", sum);
  for (int i = 0; i < this.numGens; i++) {
    Hashtable<String, Hashtable<String, Integer>> gen = hierarchy[i];
    println(gen, "--------------------------------------------");
    float generationVal = 0;
    TreeNode generation = new TreeNode(Integer.toString(i), generationVal);
    Set<String> keys = gen.keySet();
    for (String key : keys) {
      Hashtable<String, Integer> typeTable = gen.get(key);
      int valLeaf = 0;
      TreeNode type = new TreeNode(key, valLeaf);
      Set<String> subTypes = typeTable.keySet();
      for (String k : subTypes) {
        TreeNode subType = new TreeNode(k, typeTable.get(k));
        type.children.add(subType);
        valLeaf += subType.value;
        //sum += valLeaf;
      }
      type.value = valLeaf;
      generationVal += type.value;

      generation.children.add(type);
    }
    generation.value = generationVal;
    root.children.add(generation);

  }
  root.value = sum;
  return root;
  
  
  
  
  
}

void draw() {
 background(255); 
 rc.draw();
 //lc.draw();
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