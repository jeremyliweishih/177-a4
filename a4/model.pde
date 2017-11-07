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
        
        float avg = 0;
        if(num != 0){
          avg = sum / num;
        }
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
        
        float avg = 0;
        if(num != 0){
          avg = sum / num;
        }
        
        avgStats[i-1] = avg;
    }
    
    return avgStats;
  }
  
  Float[] otherStats(){
    Float[] otherStats = new Float[6];
    for(int i = 0; i < 6; i++){
       float num = 0;
       float hp = 0;
       float atck = 0;
       float def = 0;
       float spatck = 0;
       float spdef = 0;
       float speed = 0;
       
       for(TableRow row : table.rows()){
          hp = hp + row.getInt("HP");
          atck = atck + row.getInt("Attack");
          def = def + row.getInt("Defense");
          spatck = spatck + row.getInt("Sp. Atk");
          spdef = spdef + row.getInt("Sp. Def");
          speed = speed + row.getInt("Speed"); 
          num++;
       }
      
      hp = hp / num;
      atck = atck / num;
      def = def / num;
      spatck = spatck / num;
      spdef = spdef / num;
      speed = speed / num;
      
      otherStats[0] = hp;
      otherStats[1] = atck;
      otherStats[2] = def;
      otherStats[3] = spatck;
      otherStats[4] = spdef;
      otherStats[5] = speed;
    }
    
    return otherStats;
  }
  Float[] otherStats(String type){
    Float[] otherStats = new Float[6];
    for(int i = 0; i < 6; i++){
       float num = 0;
       float hp = 0;
       float atck = 0;
       float def = 0;
       float spatck = 0;
       float spdef = 0;
       float speed = 0;
       
       for(TableRow row : table.rows()){
           if(row.getString("Type 1") == type){
              hp = hp + row.getInt("HP");
              atck = atck + row.getInt("Attack");
              def = def + row.getInt("Defense");
              spatck = spatck + row.getInt("Sp. Atk");
              spdef = spdef + row.getInt("Sp. Def");
              speed = speed + row.getInt("Speed"); 
              num++;
           }
       }
      
      hp = hp / num;
      atck = atck / num;
      def = def / num;
      spatck = spatck / num;
      spdef = spdef / num;
      speed = speed / num;
      
      otherStats[0] = hp;
      otherStats[1] = atck;
      otherStats[2] = def;
      otherStats[3] = spatck;
      otherStats[4] = spdef;
      otherStats[5] = speed;
    }
    
    return otherStats;
  }
  
  Float[] otherStats(int g){
    Float[] otherStats = new Float[6];
    for(int i = 0; i < 6; i++){
       float num = 0;
       float hp = 0;
       float atck = 0;
       float def = 0;
       float spatck = 0;
       float spdef = 0;
       float speed = 0;
       
       for(TableRow row : table.rows()){
           if(row.getInt("Generation") == g){
              hp = hp + row.getInt("HP");
              atck = atck + row.getInt("Attack");
              def = def + row.getInt("Defense");
              spatck = spatck + row.getInt("Sp. Atk");
              spdef = spdef + row.getInt("Sp. Def");
              speed = speed + row.getInt("Speed"); 
              num++;
           }
       }
      
      hp = hp / num;
      atck = atck / num;
      def = def / num;
      spatck = spatck / num;
      spdef = spdef / num;
      speed = speed / num;
      
      otherStats[0] = hp;
      otherStats[1] = atck;
      otherStats[2] = def;
      otherStats[3] = spatck;
      otherStats[4] = spdef;
      otherStats[5] = speed;
    }
    
    return otherStats;
  }
  
  
  Float[] otherStats(int g, String type){
    Float[] otherStats = new Float[6];
    for(int i = 0; i < 6; i++){
       float num = 0;
       float hp = 0;
       float atck = 0;
       float def = 0;
       float spatck = 0;
       float spdef = 0;
       float speed = 0;
       
       for(TableRow row : table.rows()){
          if(row.getInt("Generation") == g && row.getString("Type 1").equals(type)){         
            hp = hp + row.getInt("HP");
            atck = atck + row.getInt("Attack");
            def = def + row.getInt("Defense");
            spatck = spatck + row.getInt("Sp. Atk");
            spdef = spdef + row.getInt("Sp. Def");
            speed = speed + row.getInt("Speed"); 
            num++;
          }
       }
      
      hp = hp / num;
      atck = atck / num;
      def = def / num;
      spatck = spatck / num;
      spdef = spdef / num;
      speed = speed / num;
      
      otherStats[0] = hp;
      otherStats[1] = atck;
      otherStats[2] = def;
      otherStats[3] = spatck;
      otherStats[4] = spdef;
      otherStats[5] = speed;
    }
    
    return otherStats;
  }

    Float[] otherStats(int g, String type1, String type2){
    Float[] otherStats = new Float[6];
    for(int i = 0; i < 6; i++){
       float num = 0;
       float hp = 0;
       float atck = 0;
       float def = 0;
       float spatck = 0;
       float spdef = 0;
       float speed = 0;
       
       if(type2 != "NA"){
         for(TableRow row : table.rows()){
            if(row.getInt("Generation") == g && row.getString("Type 1").equals(type1) && row.getString("Type 2").equals(type2)){         
              hp = hp + row.getInt("HP");
              atck = atck + row.getInt("Attack");
              def = def + row.getInt("Defense");
              spatck = spatck + row.getInt("Sp. Atk");
              spdef = spdef + row.getInt("Sp. Def");
              speed = speed + row.getInt("Speed"); 
              num++;
            }
         }
       } else{
         for(TableRow row : table.rows()){
            if(row.getInt("Generation") == g && row.getString("Type 1").equals(type1) && (row.getString("Type 2") == null || row.getString("Type 2").isEmpty())){         
              hp = hp + row.getInt("HP");
              atck = atck + row.getInt("Attack");
              def = def + row.getInt("Defense");
              spatck = spatck + row.getInt("Sp. Atk");
              spdef = spdef + row.getInt("Sp. Def");
              speed = speed + row.getInt("Speed"); 
              num++;
            }
         }       
       }
       
      hp = hp / num;
      atck = atck / num;
      def = def / num;
      spatck = spatck / num;
      spdef = spdef / num;
      speed = speed / num;
      
      otherStats[0] = hp;
      otherStats[1] = atck;
      otherStats[2] = def;
      otherStats[3] = spatck;
      otherStats[4] = spdef;
      otherStats[5] = speed;
    }
    
    return otherStats;
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
  
  Message bestStat(int g, String col){
     int maxG = -1;
     String maxType = "";
     float max = 0;
     if(g == -1){
        for(int i = 0; i < 6; i++){
           for(String type : types){
              float typeAvg = 0;
              int typeNum = 0;
              for(TableRow row : table.rows()){
                  if(row.getInt("Generation") == i + 1 && row.getString("Type 1").equals(type)){
                     typeAvg  += row.getInt(col);
                     typeNum++;
                  }
              }
              
              typeAvg = typeAvg / typeNum;
              if(typeAvg > max){
                 max = typeAvg;
                 maxG = i +1;
                 maxType = type;
              }
           }
        }
        
        return new Message(maxG, maxType, "");
     } else{
            for(String type : types){
              float typeAvg = 0;
              int typeNum = 0;
              for(TableRow row : table.rows()){
                  if(row.getInt("Generation") == g && row.getString("Type 1").equals(type)){
                     typeAvg  += row.getInt(col);
                     typeNum++;
                  }
              }
              
              typeAvg = typeAvg / typeNum;
              if(typeAvg > max){
                 max = typeAvg;
                 maxG = g;
                 maxType = type;
              }
           }
           
           return new Message(g, maxType, "");
     }
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