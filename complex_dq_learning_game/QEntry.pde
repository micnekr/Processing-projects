public abstract class QEntry{
  QEntry(){}
  
  abstract String toString();
  
  QEntry get(int index) throws Exception{
    throw new Exception("The entry does not have children");
  }
}
