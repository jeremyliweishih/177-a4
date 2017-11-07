import java.util.*;
import processing.sound.*;
SoundFile file;
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

String[] names = {"HP", "Attack", "Defense", "Sp. Atk", "Sp. Def", "Speed"};
String type1 = "";
String type2 = "";
int generation = -1;
Message lineM;
ArrayList<String> hovered;
void setup() {
  size(1000, 750);
  smooth();
  pixelDensity(2);
  model = new Model();
  hovered = new ArrayList<String>();
  this.hierarchy = model.getHierarchy();
  Float[] data = model.otherStats();
  //Float[] data = {200.0, 200.0, 200.0, 200.0, 200.0, 200.0};
  rc = new RadialChart(names, data, 0, 20, width/2, height/2 - 20);
  
  Hashtable<String, Float[]>val = new Hashtable<String, Float[]>();
  for (String t : pokeTypes) {
   val.put(t, model.avgStatsGeneration(t)); 
  }
  
  //println(val);
  lc = new LineChart("names", "data", 0, height/2, width/2, height/2, val, typeColours, hovered);
  TreeNode root = parseData();
  square = new SquareMap(width/2 - 10, height - 10, width/2 + 5, 5, root);
  file = new SoundFile(this, "pokemon.mp3");
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
 if(!type1.isEmpty()){
     Hashtable<String, Float[]>val = new Hashtable<String, Float[]>();
     val.put(type1, model.avgStatsGeneration(type1)); 
     lc = new LineChart("names", "data", 0, height/2, width/2, height/2, val, typeColours, hovered);
     if(generation != -1 && type2.isEmpty()){
        Float[] data = model.otherStats(generation, type1);
        rc = new RadialChart(rc.names, data, 0, 20, width/2, height/2 - 20);
     }  else if(!type2.isEmpty()){
          Float[] data = model.otherStats(generation, type1, type2);
          rc = new RadialChart(rc.names, data, 0, 20, width/2, height/2 -20);
        }
 } else{
      Hashtable<String, Float[]>val = new Hashtable<String, Float[]>();
      for (String t : pokeTypes) {
       val.put(t, model.avgStatsGeneration(t)); 
      }      
      lc = new LineChart("names", "data", 0, height/2, width/2, height/2, val, typeColours, hovered);
      
        Float[] data = model.otherStats();
        rc = new RadialChart(rc.names, data, 0, 20, width/2, height/2 -20 ); 
 }
 mouseMoved();

 background(255); 
 
 pushMatrix();
 translate(width/2, 5);
 hovered = square.draw();
 if(hovered.size() != 0){ 
   if(!hovered.get(0).contains("Gen") && generation != -1){
      hovered.add(0, "Generation " + Integer.toString(generation));
   }   
 }
 popMatrix();
   rc.draw();
  if(hovered.size() == 2){
     rc.drawOtherBars(model.otherStats(Integer.valueOf(hovered.get(0).split(" ")[1]), hovered.get(1))); 
 } else if(hovered.size() == 1){
    rc.drawOtherBars(model.otherStats(Integer.valueOf(hovered.get(0).split(" ")[1]))); 
 } else if (hovered.size() == 3){
    rc.drawOtherBars(model.otherStats(Integer.valueOf(hovered.get(0).split(" ")[1]), hovered.get(1), hovered.get(2))); 
 }
 lineM = lc.draw();
 if(!lineM.type1.isEmpty()){
     rc.drawOtherBars(model.otherStats(lineM.gen,lineM.type1));
     square.hover = lineM;
     pushMatrix();
     translate(width/2, 5);
     square.draw();
     popMatrix();
 }
 
 if(!hoverCol.isEmpty()){
   Message best = model.bestStat(generation, hoverCol);
   ArrayList<String> radHover = new ArrayList();
   radHover.add(0, "Gen " + Integer.toString(best.gen));
   radHover.add(1, best.type1);
   lc.hovered = radHover;
   lc.draw();
   
     square.hover = best;
     pushMatrix();
     translate(width/2, 5);
     square.draw();
     popMatrix();
 }
}

String hoverCol = "";
void mouseMoved() {
  hoverCol = rc.radBarChartIsect();
}

void mouseClicked() {
  Message m = square.mouseClicked();
  if(m != null){
   type1 = m.type1;
    type2 = m.type2;
    generation = Integer.valueOf(m.gen); 
  }
  
  if(mouseX < width/2 && mouseButton == LEFT){
      file.play();
  } else if(mouseX < width/2 && mouseButton == RIGHT){
     file.stop(); 
  }
  
}