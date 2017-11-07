import java.util.Collections;
import java.util.Map;
import java.util.Queue;

class SquareMap {
  TreeNode root;
  Rectangle canvas;
  color ON = color(65, 105, 225);
  color OFF = color(255, 255, 255);
  float currWid, currHgt;
  int chartW, chartH, originX, originY;
  Message hover;
  SquareMap(int chartW, int chartH, int originX, int originY, TreeNode root) {
    background(color(255, 255, 255));
    currWid = chartW;
    currHgt = chartH;
    this.chartW = chartW;
    this.chartH = chartH;
    this.originX = originX;
    this.originY = originY;
    this.root = root;
    canvas = makeCanvas(root);
  }
  
  ArrayList<String> draw() {
    if (root != null && canvas != null) {
      //onResize();
      mouseOff();
      ArrayList<String> hovered = mouseOver();
      if(hover != null) highLight(canvas, hover);
      hover = null;
      canvas.draw();
      drawLabelBox();
      return hovered;
    }
    
    return new ArrayList<String>();
  }
  
  // gets total weight of a tree
  // side effect: nonleaf nodes have their weights set to that of their children
  float sumNodeWeight(TreeNode node) {
    if (node.children.size() <= 0) {
      return node.value;
    }
    float sum = 0;
    for (TreeNode c : node.children) {
      sum += sumNodeWeight(c);
    }
    node.value = sum;
    return sum;
  }
  
  // convert all weights in tree to scalar
  void normalize(TreeNode node, float normfact) {
    node.ratio = node.value / normfact;
    for (TreeNode c : node.children) {
      normalize(c, normfact);
    }
    Collections.sort(node.children);
  }
  
  Rectangle makeCanvas(TreeNode node) {
    if (node != null) {
      normalize(node, sumNodeWeight(node));
      Rectangle newCanvas = new Rectangle(node, null, 0, 0, 1, 1, ON, OFF, this.chartW, this.chartH, this.originX, this.originY);
      squarify(node, newCanvas);
      return newCanvas;
    } else {
      return canvas;
    }
   
  }
  
  // assumes weights.size() > 0
  float aspectRatio(ArrayList<TreeNode> nodes, float w) {
    float area = chartW * chartH;
    float max = nodes.get(0).ratio * area;
    float min = nodes.get(0).ratio * area;
    float sum = 0;
    
    for (TreeNode node : nodes) {
      float wgt = node.ratio * area;
      max = max(max, wgt);
      min = min(min, wgt);
      sum += wgt;
    }
    
    return max((w * w * max) / (sum * sum), (sum * sum) / (w * w * min));
  }
  
  void highLight(Rectangle rect, Message m){
     String type = m.type1;
     int g = m.gen;
     if(rect.node.id.equals(type) && findGeneration(rect.node) == g && rect.node.parent.id.contains("Gen")) {
       rect.onOver();
     }
     
     if(rect.node.parent != null && findGeneration(rect.node) == g){
        if(rect.node.parent.id.equals(type)) rect.onOver(); 
     }
     for(Rectangle r : rect.children){
        highLight(r, m); 
     }
  }
  void squarify(TreeNode node, Rectangle r) {
    if (node.children.size() <= 0) {
      return;
    }
    
    float w = r.shortest();
    ArrayList<TreeNode> row = new ArrayList<TreeNode>();
    row.add(node.children.get(0));
    ArrayList<Rectangle> rects = new ArrayList<Rectangle>();
    
    for (int i = 1; i < node.children.size(); i++) {
      float currAR = aspectRatio(row, w);
      row.add(node.children.get(i));
      float newAR = aspectRatio(row, w);
      
      if (currAR <= newAR) {
        row.remove(row.size() - 1);
        rects.addAll(r.layoutRow(row));
        row.clear();
        row.add(node.children.get(i));
        w = r.shortest();
      }
   }
    
    if (row.size() > 0) {
      rects.addAll(r.layoutRow(row));
    }
    
    for (int i = 0; i < node.children.size(); i++) {
      squarify(node.children.get(i), rects.get(i));
    }
  }
  
 void onRects(Rectangle r, ArrayList<String> list) {
    if (r.isOver()) {
      r.onOver();
      if (r.node.id != "root") {
        if(r.node.children.size() == 0 && !list.contains(r.node.parent.id)) list.add(r.node.parent.id);
        list.add(r.node.id);
      }
      for (Rectangle c : r.children) {
        onRects(c, list);
      }
    }
  }
  
  ArrayList<String> mouseOver() {
    ArrayList hovered = new ArrayList<String>();
    onRects(canvas, hovered);
    return hovered;
  }
  
  void offRects(Rectangle r, Rectangle over) {
    if (r != over) {
      r.onOff();
    }
    for (Rectangle c : r.children) {
      offRects(c, over);
    }
  }
  
  void mouseOff() {
    offRects(canvas, canvas.whichOver());
  }
  
  Message mouseClicked() {
    CharSequence cs1 = "Gen";
    Rectangle over = canvas.whichOver();
    Message m;
    String type1 = "";
    String type2 = "";
    if (over != null) {
      int g = findGeneration(over.node);
      if (mouseButton == LEFT) {
        canvas = makeCanvas(over.node);
        if(over.node.id.equals("NA")){
           type1 = over.node.parent.id;
           type2 = "NA";
           if(type1.contains(cs1)) {
             type1 = "";
             type2 = "";
           }
        } else if(over.node.id.contains(cs1) || over.node.id.contains("root")){
           type1 = ""; 
           type2 = "";
        } else if (over.node.children.size() == 0) {
          type2 = over.node.id;
          type1 = over.node.parent.id;
        } else { //has children
          type2 = "";
          type1 = over.node.id;
        }
      }  else if (mouseButton == RIGHT) {
        if(canvas.node.parent != null){
          String toReturn = canvas.node.parent.id;
          canvas = makeCanvas(canvas.node.parent);
          if(toReturn.contains(cs1)){
             type1 = ""; 
             type2 = "";
          } else if(toReturn.equals("root")){
             type1 = ""; 
             type2 = "";
          }
          //println(canvas.node.parent.id, "    AHHHAIOSJAOJSLAK:LSA+======");
          else {
            type1 = toReturn;
            type2 = "";
          }
        }
      }
      
      return new Message(g, type1, type2);
    }
    
    return null;
  }
  
  int findGeneration(TreeNode n){
    CharSequence cs1 = "Gen";
    if(n.id.contains(cs1)){
       String[] s = n.id.split(" ");
       
       return Integer.valueOf(s[1]); 
    }
    
    else if(n.parent != null) return findGeneration(n.parent);
    return -1;
  }
  Boolean resized() {
    return currWid != chartW || currHgt != chartH;
  }
  
  void onResize() {
    if (resized()) {
      currWid = chartW;
      currHgt = chartH;
      
      canvas = makeCanvas(canvas.node);
    }
  }
  
  void drawLabelBox() {
    Rectangle over = canvas.whichOver();
    if (over == null) return;
    String idstr = "id: " + String.valueOf(over.node.id);
    String wgtstr = "weight: " + String.valueOf(over.node.value);
    float padding = 2 * FRAME;
    float boxW = max(textWidth(idstr), textWidth(wgtstr)) + 2 * padding;
    float boxH = 2 * (textAscent() + textDescent() + padding);
    float boxX = mouseX - this.originX;
    float boxY = mouseY - this.originY - boxH - padding;
    
    if (boxX + boxW > chartW) {
      boxX = mouseX - boxW - padding - this.originX;
      boxY = mouseY + boxH > chartH ? boxY - this.originY : mouseY;
    } else if (boxY < 0) {
      boxX = mouseX + 2 * padding - this.originX;
      boxY = mouseY - this.originY;
    }
    
    fill(color(255, 255, 255));
    rect(boxX, boxY, boxW, boxH);
    fill(color(0, 0, 0));
    text(idstr, boxX + FRAME, boxY + (textAscent() + textDescent()) + padding);
    text(wgtstr, boxX + FRAME, boxY + 2 * (textAscent() + textDescent()) + padding);
  }
}