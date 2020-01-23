class Complex{
  float a;
  float b;
  
  Complex(float a_, float b_){
    a = a_;
    b = b_;
  }
  
  Complex mult(Complex second){
    float a1 = a;
    float b1 = b;
    float a2 = second.a;
    float b2 = second.b;
    
    float real = a1*a2-b1*b2;
    float complex = a1*b2+a2*b1;
    return new Complex(real, complex);
  }
  
  Complex add(Complex second){
    float a1 = a;
    float b1 = b;
    float a2 = second.a;
    float b2 = second.b;
    
    float real = a1+a2;
    float complex = b1+b2;
    return new Complex(real, complex);
  }
}
