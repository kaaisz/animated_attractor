// for screenshot
int screenshotCounter = 0;

// define canvas move
float m = 0;

// define value for de jong attractor
float x, y, xn, yn, a, c, d;
// -- random value setup to change in 10sec
float[] b = {-1.5*cos(PI%2), -2, 3.2653};
float currentB;
int hue_dj;
boolean increase_dj;

// define value for clifford attractor A
float p, q, pn, qn;
int hue_cl1;
boolean increase_cl1;

// define value for clifford attractor B
float r, s, rn, sn;
int hue_cl2;
boolean increase_cl2;

// -- random value setup to change in 10sec
float[] e = {-3.22846, -2.67889*cos(2*PI), -1.8*sin(2)};
float[] f = {-2.42392237, -1.3, -4, -2.06529, 1.8397894};
float[] g = {-0.5, -0.5, -0.5, -0.5};
float[] h = {-0.9, -0.9, -0.9, -0.9};
float currentE;
float currentF;
float currentG;
float currentH;

float timer_dj;
float timer_cl1;
float timer_cl2;
float angle = -30;
int lastUpdate;

float getRnd(float[] arr) {
  return arr[int(random(arr.length))];
}

void setup() {
  // init
  fullScreen();
  pixelDensity(displayDensity());
  colorMode(HSB, 400, 100, 100);
  background(0);
  
  // init value for de jong attractor
  x = y = xn = yn = a = c = d = 0;
  hue_dj = 120;
  currentB = getRnd(b);
  
  // init value for clifford attractor
  lastUpdate = millis();
  // Attractor A
  p = q = pn = qn = 0;
  hue_cl1 = 240;
  // Attractor B
  r = s = rn = sn = 0;
  currentE = getRnd(e);
  currentF = getRnd(f);
  currentG = getRnd(g);
  currentH = getRnd(h);
  hue_cl2 = 1;
  
  // timer
  timer_dj = 0;
  timer_cl1 = 0;
  timer_cl2 = 0;
  strokeWeight(1);
}


void draw() {
  // to rotate and move attractor
  background(0);
 
  ////////// *draw attractor start* ////////// 
  drawDeJongAttractor();
  drawCliffordAttractorA();
  drawCliffordAttractorB();
  ////////// *draw attractor end* ////////// 
  
  angle += 0.08;
  m += 0.002;
  
  if(keyPressed) {
    String filename = "screenshot_" + screenshotCounter + ".png";
    saveFrame(filename);
    screenshotCounter++;
  }
}

int updateHue(int hue, boolean increase) {
  if (increase) {
    hue += 1;
  } else {
    hue -=1;
  }
  return hue;
}

  // --------------------
  // de jong attractor
  // --------------------
void drawDeJongAttractor() {
  translate(width/2 + 200*-cos(0.2*-m*PI), height/3*sin(-0.3 *m * -PI));
  rotate(radians(angle));
  if(millis() - lastUpdate >= 10000) { // regenerate number once in 10sec
    currentB = getRnd(b);
    lastUpdate = millis();
  }
  timer_dj += 0.004; // speed
  c = 3 * cos(timer_dj);
  d = 3 * sin(timer_dj);
  a = 3 * cos(timer_dj);
  
  for (int i = 0; i < 20000; i++) { // density
    xn = x;
    yn = y;
    x = sin(a * yn + cos(a)) - cos(currentB * xn + sin(c * xn)); // attractor formula
    y = sin(c * xn) - cos(d * yn);
    // render
    point(160 * x,  160 * y); // attractor size
    stroke(hue_dj, 35, 90); // color
  }
  
  hue_dj = updateHue(hue_dj, increase_dj);
    
  if(hue_dj == 400) {
     increase_dj = false;
  } else if (hue_dj == 0) {
      increase_dj = true;
  }
}

  // --------------------
  // clifford attractor A
  // --------------------
void drawCliffordAttractorA() {
  // control entire movement
  translate(width/3 + 200*-cos(0.2*-m*PI), height/3*sin(-0.3 *m + PI));
  rotate(radians(-angle));
   if(millis() - lastUpdate >= 8000) { // regenerate number once in 8sec
    currentE = getRnd(e);
    currentF = getRnd(f);
    currentG = getRnd(g);
    currentH = getRnd(h);
    lastUpdate = millis();
  }
  timer_cl1 += 0.007; // speed
  pn = p;
  qn = q;
  
  for(int n = 0; n < 20000; n++){ // density
    p =  sin(currentE * qn + timer_cl1) + currentG * cos(currentE * pn + timer_cl1) * sin(currentF * pn + timer_cl1); // attractor formula
    q =  sin(currentF * pn + timer_cl1) + currentH * cos(currentF * qn + timer_cl1) * sin(currentE * qn + timer_cl1);
    point(240 * p, 240 * q); // attractor size
    stroke(hue_cl1, 35, 90); // color
    pn = p;
    qn = q;
  }
  
  hue_cl1 = updateHue(hue_cl1, increase_cl1);
  if(hue_cl1 == 400) {
     increase_cl1 = false;
  } else if (hue_cl1 == 0){
      increase_cl1 = true;
  }
}



// --------------------
// clifford attractor B
// --------------------  
void drawCliffordAttractorB() {
  // control entire movement
    translate(width/4 *sin(0.3 *m * PI), height/2*-cos(0.04*m*PI)); 
    rotate(radians(-angle));
    
    timer_cl2 += 0.005; // speed
    rn = r;
    sn = s;
    
    for(int n = 0; n < 20000; n++){ // density
      r =  sin(currentE * sn + timer_cl2)*cos(currentE * rn + timer_cl2) + currentG * cos(currentE * rn + timer_cl2) * sin(currentF * rn + timer_cl2); // attractor formula
      s =  sin(currentF * rn + timer_cl2)*cos(currentF * sn + timer_cl2) + currentH * cos(currentF * sn + timer_cl2) * sin(currentE * sn + timer_cl2);
      point(240 * r, 240 * s); // attractor size
      stroke(hue_cl2, 35, 90); // color
      rn = r;
      sn = s;
    }
    
    hue_cl2= updateHue(hue_cl2, increase_cl2);
    if(hue_cl2 == 400) {
       increase_cl2 = false;
    } else if (hue_cl2 == 0){
        increase_cl2 = true;
    }
  }
