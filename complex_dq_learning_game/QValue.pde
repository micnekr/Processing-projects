public class QValue extends QEntry{
  float value;
  QValue(float _value){
    value = _value;
  }
  
  String toString(){
    return str(value);
  }
}
