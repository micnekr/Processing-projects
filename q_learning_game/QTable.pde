class QTable{
  int actionsNum;
  int[] statesNum;
  int[] rowsNum;
  
  QRow table;
  
  QTable(int _actionsNum, int[] _statesNum, float maxVal, float minVal){
    statesNum = _statesNum;
    actionsNum = _actionsNum;
    
    //overall row nums should include actions num ans states num
    rowsNum = new int[statesNum.length + 1];
    for(int i = 0; i < statesNum.length; i++) rowsNum[i] = statesNum[i];
    rowsNum[statesNum.length] = actionsNum;
    
    //randomse
    randomiseTable(maxVal, minVal);
  }
  
  QRow randomiseTable(float maxVal, float minVal){
    table = randomiseTable(new QRow(), 0, maxVal, minVal);
    return table;
  }
  
  QRow randomiseTable(QRow newTable, int rowIndex, float maxVal, float minVal){
    //if this is the last recursion, fill with random values
    if(rowIndex == rowsNum.length - 1) {
      QValue[] values = new QValue[rowsNum[rowIndex]];
      for(int i = 0; i < rowsNum[rowIndex]; i++) values[i] = new QValue(random(maxVal, minVal));
      newTable.entries = values;
      return newTable;
      //else if it is another row
    }else{
      QRow[] entries = new QRow[rowsNum[rowIndex]];
      for(int i = 0; i < rowsNum[rowIndex]; i++) {
        entries[i] = new QRow();
        randomiseTable(entries[i], rowIndex+1, maxVal, minVal);
      }
      newTable.entries = entries;
      return newTable;
    }
  }
  
  String toString(){
    return table.toString();
  }
}
