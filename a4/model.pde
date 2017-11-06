import java.util.*;

public class Model{
  Table table;
  Set<String> types;
  public Model(){
      table = loadTable("Pokemon.csv", "header");
      types = new HashSet<String>();
      setTypes();
  }
  
  void setTypes(){
    for(TableRow row : table.rows()){
       if(row.getString("Type 1") != null && !row.getString("Type 1").isEmpty()){
         types.add(row.getString("Type 1"));
       }
       
       if(row.getString("Type 2") != null && !row.getString("Type 2").isEmpty()){
          types.add(row.getString("Type 2")); 
       }
    }
  }
  Float[] avgStatsGeneration(){
    Float[] avgStats = new Float[6];
    for(int i = 1; i <= 6; i++){
        float sum = 0;
        float num = 0;
        for(TableRow row : table.rows()) {
          if(row.getInt("Generation") == i){
              sum = sum + row.getInt("Total");
              num++;
          }
        }
        
        float avg = sum / num;
        avgStats[i-1] = avg;
    }
    
    return avgStats;
  }
  
  Float[] avgStatsGeneration(String type){
    Float[] avgStats = new Float[6];
    for(int i = 1; i <= 6; i++){
        float sum = 0;
        float num = 0;
        for(TableRow row : table.rows()) {
          if(row.getInt("Generation") == i && row.getString("Type 1").equals(type)){
              sum = sum + row.getInt("Total");
              num++;
          }
        }
        
        float avg = sum / num;
        avgStats[i-1] = avg;
    }
    
    return avgStats;
  }
  
   Hashtable<String, Hashtable<String, Integer>>[] getHierarchy(){
    Hashtable<String, Hashtable<String, Integer>>[] hierarchy = new Hashtable[6];
    for(int i = 0; i < 6; i++){
      hierarchy[i] = new Hashtable<String, Hashtable<String, Integer>>();
    }
    //Hashtable t = new Hashtable<String, Hashtable<String, Integer>>();
    
    for(int i = 0; i < 6; i++){
      hierarchy[i] = new Hashtable<String, Hashtable<String, Integer>>();
      //hierarchy[i] = (Hashtable<String, Hashtable<String, Integer>>)t.clone();
      for(String type : types){
          hierarchy[i].put(type, new Hashtable<String, Integer>());
        }
    }
    
    for(TableRow row: table.rows()){
       int g = row.getInt("Generation");
       if(row.getString("Type 2") != null && !row.getString("Type 2").isEmpty()){
         
           if(!hierarchy[g-1].get(row.getString("Type 1")).containsKey(row.getString("Type 2"))){
               hierarchy[g-1].get(row.getString("Type 1")).put(row.getString("Type 2"), 1);
           } else{
              hierarchy[g-1].get(row.getString("Type 1")).put(row.getString("Type 2"), hierarchy[g-1].get(row.getString("Type 1")).get(row.getString("Type 2")) + 1);
           }
       } else{
         if(!hierarchy[g-1].get(row.getString("Type 1")).containsKey("NA")){
             hierarchy[g-1].get(row.getString("Type 1")).put("NA", 1);
         } else{
             hierarchy[g-1].get(row.getString("Type 1")).put("NA",  hierarchy[g-1].get(row.getString("Type 1")).get("NA") + 1);
         }
       }
    }
    
    return hierarchy;
  }
  
  //for index, row in df.iterrows():
  //if(not pd.isnull(row['Type 2'])):
  //  if row['Type 2'] not in typeAggregate[row['Type 1']]:
  //    typeAggregate[row['Type 1']][row['Type 2']] = 1
  //  else:
  //    typeAggregate[row['Type 1']][row['Type 2']] += 1
  //else:
  //  if 'NA' not in typeAggregate[row['Type 1']]:
  //    typeAggregate[row['Type 1']]['NA'] = 1
  //  else:
  //    typeAggregate[row['Type 1']]['NA'] += 1
  //Float[] avgOtherStats(int g){
  //  Float[] stats = new Float[];
    
    
  //  return nice;
  //}
  
  //Float[] getByGenerationType(int g, String type){
    
  //}
  
  
}