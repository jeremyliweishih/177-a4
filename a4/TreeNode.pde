class TreeNode implements Comparable<TreeNode> {
  String id;
  float value;
  float ratio;
  TreeNode parent;
  ArrayList<TreeNode> children;
  
  TreeNode(String id, float value) {
    this.id = id;
    this.value = value;
    this.ratio = value;
    this.parent = null;
    this.children = new ArrayList<TreeNode>();
  }
  
  @Override
  int compareTo(TreeNode other) {
    if (this.value > other.value) {
      return -1;
    } else if (this.value == other.value) {
      return 0;
    } else {
      return 1;
    }
  }
}