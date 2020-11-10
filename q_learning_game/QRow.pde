public class QRow extends QEntry{
  QEntry[] entries;
  
  QRow(QEntry[] _entries){
    entries = _entries;
  }
  
  QRow(){}
  
  String toString(){
    String out = "[\n";
    for(int i = 0; i < entries.length; i++){
      String entry = entries[i].toString();
      
      //tab out
      if(entries[i] instanceof QRow){
        String[] entryLines = split(entry, "\n");
      
        for(int j = 0; j < entryLines.length; j++) out += "\t" + entryLines[j];
      }else out += entry;
      //end of line
      if(i != entries.length - 1) {
        out += ", ";
        if(entries[i] instanceof QRow) out += "\n";
      }
    }
    return out + "\n]";
  }
  
  QEntry get(int index){
    return entries[index];
  }
  
  void set(int index, QValue value){
    entries[index] = value;
  }
}
