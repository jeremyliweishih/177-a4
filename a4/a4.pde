 import java.util.*;

RadialChart rc;
LineChart lc;
SquareMap square;
Hashtable<String, Hashtable<String, Integer>>[] hierarchy;
int numGens, numTypes, numSubTypes;
Model model;
String[] pokeTypes = {"Steel", "Ghost", "Dark", "Electric", "Ice", "Normal", "Fire", "Psychic", "Flying", "Poison", "Dragon", "Water", "Fighting", "Rock", "Fairy", "Grass", "Bug", "Ground"};
Hashtable<String, Integer> typeColours = new Hashtable<String, Integer>() {{ put("Steel", #B7B7CE); put("Ghost", #735797); 
                put("Dark", #705746); put("Electric", #F7D02C); put ("Ice", #96D9D6); put("Normal", #A8A77A); 
                put("Fire", #EE8130); put("Psychic", #F95587); put("Flying", #A98FF3); put("Poison", #A33EA1);
                put("Dragon", #6F35FC); put("Water", #6390F0); put("Fighting", #C22E28); put("Rock", #B6A136);
                put("Fairy", #D685AD); put("Grass", #7AC74C); put("Bug", #A6B91A); put("Ground", #E2BF65); }};


void setup() {
  size(1000, 750);
  String[] names = {"hi", "bob", "charlie", "poop", "blah", "pls"};
  float [] data = {200.0, 200.0, 200.0, 200.0, 200.0, 200.0};
  model = new Model();
  this.hierarchy = model.getHierarchy();

  rc = new RadialChart(names, data, 0, 0, width/2, height/2);

  
  
  
  Hashtable<String, Float[]>val = new Hashtable<String, Float[]>();
  for (String t : pokeTypes) {
    Float[] blah = model.avgStatsGeneration(t);
    println(t);
    for (Float f : blah) print(Float.toString(f), ", ");
   val.put(t, model.avgStatsGeneration(t)); 
   
  }
  //println(val);
  lc = new LineChart("names", "data", data, 0, height/2, width/2, height/2, val, typeColours);
  TreeNode root = parseData();
  square = new SquareMap(width/2, height, width/2, root);
  
}

TreeNode parseData() {
  this.numGens = hierarchy.length;
  
  int sum = 0;
  TreeNode root = new TreeNode("root", sum);
  for (int i = 0; i < this.numGens; i++) {
    Hashtable<String, Hashtable<String, Integer>> gen = hierarchy[i];
    float generationVal = 0;
    TreeNode generation = new TreeNode("Generation " + Integer.toString(i+1), generationVal);
    Set<String> keys = gen.keySet();
    for (String key : keys) {
      Hashtable<String, Integer> typeTable = gen.get(key);
      int valLeaf = 0;
      TreeNode type = new TreeNode(key, valLeaf);
      Set<String> subTypes = typeTable.keySet();
      for (String k : subTypes) {
        TreeNode subType = new TreeNode(k, typeTable.get(k));
        type.children.add(subType);
        subType.parent = type;
        valLeaf += subType.value;
        //sum += valLeaf;
      }
      type.value = valLeaf;
      generationVal += type.value;
      type.parent = generation;
      generation.children.add(type);
    }
    generation.value = generationVal;
    generation.parent = root;
    root.children.add(generation);

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