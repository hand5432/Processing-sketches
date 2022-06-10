class Polygon {
  
  // controls amount of vertices in the polygon
  float pAmt; // current verticies amt, affected by Perlin
  int maxAmt = 20; // max amount of verticies
  
  PVector[] poi; // verticies positions
  color[] pCol; // colour of each verticies for gradient
  
  float addAng; // offsetting angle of rotation for individual polygon, affected by Perlin

  // size of polygons.
  float size; // diameter of shape.
  float lcX;
  float lcY;
  
  // Perlin values n such
  float perl;
  float perlMag = 280; // higher value == smaller magnitude 

  // shape initialized from top left corner for easy grid work.
  Polygon(float lcX_, float lcY_, float size_) {

    size = size_;
    lcX = lcX_;
    lcY = lcY_;

    findPerl();
    setpAmt();

    //pAmt = round(random(3, 6));

    poi = new PVector[maxAmt];
    pCol = new color[maxAmt];
    addAng = 0;//random(0, 2*PI);
  
    // vertices have a set colour, creating the gradient effect.
    for (int i = 0; i < maxAmt; i++) {
      float r = map(i, 0, pAmt, 255, 0);
      float g = 255; // map(i, 0, pAmt, 255, 255);
      float b = map(i, 0, pAmt, 255, 0);
      pCol[i] = color(r, g, b);//color(random(255), random(255), random(255));
    }

    setVals();
  }
  
  // updates position values of the vertices in the polygon.
  void setVals() {
    setpAmt();
    addAng += (perl - 0.5) * 2;
    //addAng = perl * 2*PI;

    for (int i = 0; i < pAmt; i++) {
      float ang = i * 2.0*PI / pAmt;
      poi[i] = PVector.fromAngle(ang + addAng);
      poi[i].mult(size/2);
      poi[i].add(lcX + size/2, lcY + size/2);
    }
  }
  
  // displays shape.
  void show() {
    beginShape();

    for (int i = 0; i < pAmt; i++) {
      
      // having the fill() part before each vertex creates the gradient effect!!
      fill(pCol[i]);
      vertex(poi[i].x, poi[i].y);
      //circle(poi[i].x, poi[i].y, 10);
    }

    endShape(CLOSE);
  }
  
  // gets the perlin value of the individual polygon according to the position of it on the grid.
  void findPerl() {
    float perlX = lcX / perlMag;
    float perlY = lcY / perlMag;

    perl = noise(t + perlX, 194841.2394 + perlY);
  }
  
  // updates pAmt to a new amt value according to Perlin noise. 
  void setpAmt() {
    pAmt = lerp(5, maxAmt, perl);
  }
}
