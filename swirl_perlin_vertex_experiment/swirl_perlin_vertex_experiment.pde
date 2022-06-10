// amount of one side of the square grid
int gAmt = 50;

// time value for controlling perlin.
float t = 0;

// initializing Polygon array
Polygon[][] polyg = new Polygon[gAmt][gAmt];

void setup() {
  size(1000, 1000, P2D); // P2D is what makes this code work!!
  
  // set to this so that it has that cool looking gradient
  colorMode(HSB);

  // setting up positions of polygons in grid.
  float size = width/gAmt;
  for (int y = 0; y < gAmt; y++) {
    float yPos = map(y, 0, gAmt, 0, height);
    for (int x = 0; x < gAmt; x++) {
      float xPos = map(x, 0, gAmt, 0, width);

      polyg[y][x] = new Polygon(xPos, yPos, size);
    }
  }
  
  noStroke();
}

void draw() {
  background(0);  

  t = millis()/300.0;
  
  // going through Polygon methods.
  for (int y = 0; y < gAmt; y++) {
    for (int x = 0; x < gAmt; x++) {
      polyg[y][x].findPerl();
      polyg[y][x].setVals();
      polyg[y][x].show();
    }
  }
}
