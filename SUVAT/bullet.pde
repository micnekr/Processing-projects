class Bullet extends Body {
  float w;
  Bullet(float x, float y, float m, float w) {
    super(x, y, m);
    this.w = w;
  }

  PVector findForce(PVector target, PVector force, float maxForce) {
    float sh = target.x-pos.x;
    float sv = target.y - pos.y;

    float uh = 0;
    float uv = 0;

    float ah = force.x / m;
    float av = force.y / m;

    //float t = sqrt(2*sv/av);

    //uh = sh/t - ah*t/2;

    //maxForce2 = uh2 + uv2
    //S = ut + at2/2
    //u = S/t - at/2
    //4maxForce2 = 4Sh*Sh/(t*t) + 4Sv*Sv/(t*t) - 4(Shah + Svav) + ah*ah*t*t + av*av*t*t
    // 4t*t*maxForce2 = 4Sh*Sh + 4*Sv*Sv - 4*t*t(Shah + Svav) + (ah*ah + av*av)*t*t*t*t 
    // 4Sh*Sh + 4*Sv*Sv - 4*t*t(Shah + Svav) + (ah*ah + av*av)*t*t*t*t - 4t*t*maxForce2 = 0
    // let d = t * t
    // 4Sh*Sh + 4*Sv*Sv - 4*d*(Shah + Svav) + (ah*ah + av*av)*d*d - 4*b*maxForce*maxForce = 0
    float a = ah * ah + av * av;
    float b = - 4 * maxForce - 4*(sh * ah + sv * av);
    float c = 4*sh*sh + 4*sv*sv;

    float D = b * b - 4 * a * c;

    if (D < 0) {
      println("D < 0");
      return null;
    }
    
    D = sqrt(D);
    
    float x1 = (-b + D)/(2*a);
    float x2 = (-b - D)/(2*a);
    
    // only get positive solutions
    
    float t;
    if(x1 > 0){
      t = sqrt(x1);
    }else if(x2 > 0){
      t = sqrt(x2);
    }else{
      println("Both roots are negative");
      return null;
    }
        
    uh = sh/t - ah*t/2;
    uv = sv/t - av*t/2;
    
    return new PVector((uh - vel.x)*m, (uv - vel.y)*m);
  }
  
  PVector findForce (Body target, PVector force, float maxForce){
    float sh = target.pos.x-pos.x;
    float sv = target.pos.y - pos.y;

    float uh = 0;
    float uv = 0;

    float ah = force.x / m;
    float av = force.y / m;
    
    float ath = target.acc.x;
    float atv = target.acc.y;
    
    float uth = target.vel.x;
    float utv = target.vel.y;
    
    //maxForce2 = uh2 + uv2
    //S = ut + at2/2
    //u = S/t - at/2
    //S = u * 
    //4maxForce2 = 4Sh*Sh/(t*t) + 4Sv*Sv/(t*t) - 4(Shah + Svav) + ah*ah*t*t + av*av*t*t
    // 4t*t*maxForce2 = 4Sh*Sh + 4*Sv*Sv - 4*t*t(Shah + Svav) + (ah*ah + av*av)*t*t*t*t 
    // 4Sh*Sh + 4*Sv*Sv - 4*t*t(Shah + Svav) + (ah*ah + av*av)*t*t*t*t - 4t*t*maxForce2 = 0
    // let d = t * t
    // 4Sh*Sh + 4*Sv*Sv - 4*d*(Shah + Svav) + (ah*ah + av*av)*d*d - 4*b*maxForce*maxForce = 0
    
    return new PVector((uh - vel.x)*m, (uv - vel.y)*m);
  }

  void draw() {
    pushStyle();
    noStroke();
    fill(255, 0, 0, 100);
    ellipse(pos.x, pos.y, w, w);
    popStyle();
  }
}
