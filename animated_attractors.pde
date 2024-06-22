// define canvas move
float m = 0;

// define value for de jong attractor
float x, y, xn, yn, a, c, d;
// -- random value setup to change in 10sec
float[] b = {-2.5, -4, 1.3, -0.6};
float currentB;
int hue_dj;
boolean increase_dj;

// define value for clifford attractor
float p, q, pn, qn;
// -- random value setup to change in 10sec
float[] e = {-3.2, -1.8, 0.5, -4.0};
float[] f = {-2.0, -1.3, -4, -2.0};
float[] g = {-0.5, -0.5, -0.5, -0.5};
float[] h = {-0.9, -0.9, -0.9, -0.9};
float currentE;
float currentF;
float currentG;
float currentH;
int lastUpdate;

int hue_cl;
boolean increase_cl;

float timer_dj;
float timer_cl;
float angle = -30;

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
  hue_dj = 200;
  currentB = getRnd(b);
  
  // init value for clifford attractor
  lastUpdate = millis();
  p = q = pn = qn = 0;
  currentE = getRnd(e);
  currentF = getRnd(f);
  currentG = getRnd(g);
  currentH = getRnd(h);
  hue_cl = 60;
  
  timer_dj = 0;
  timer_cl = 0;
  strokeWeight(2);
}


void draw() {
  // to rotate and move attractor
  background(0, 50);
  translate(width/2 + 300*sin(0.3 *m * PI), height/2 + 200*-cos(0.2*-m*PI));
  rotate(radians(angle));
 
  // *draw attractor*//
  
  
  // --------------------
  // de jong attractor
  // --------------------
  if(millis() - lastUpdate >= 15000) {
    currentB = getRnd(b);
    lastUpdate = millis();
  }
  timer_dj += 0.005;
  c = 3 * cos(timer_dj);
  d = 3 * sin(timer_dj);
  a = 3 * cos(timer_dj);
  
  for (int i = 0; i < 20000; i++) {
    xn = x;
    yn = y;
    x = sin(a * yn) - cos(currentB * xn);
    y = sin(c * xn) - cos(d * yn);
    
    point(200 * x,  200 * y);
    stroke(hue_dj, 40, 80);
  }
    
  if(increase_dj) {
    hue_dj++;
    if(hue_dj >= 400) {
      increase_dj = false;
    }
  } else {
    hue_dj--;
    if(hue_dj <= 0) {
      increase_dj = true;
    }
  }

  // --------------------
  // clifford attractor
  // --------------------
  if(millis() - lastUpdate >= 10000) {
    currentE = getRnd(e);
    currentF = getRnd(f);
    currentG = getRnd(g);
    currentH = getRnd(h);
    lastUpdate = millis();
  }
  timer_cl += 0.008;
  //x = millis()/2000;
  //y = millis()/2000;
  pn = p;
  qn = q;
  
  for(int n = 0; n < 20000; n++){
    
    // pattern a
    //p =  sin(e * qn + timer_cl) + g * cos(e * pn + timer_cl) * sin(f * pn + timer_cl);
    //q =  sin(f * pn + timer_cl) + h * cos(f * qn + timer_cl) * sin(e * qn + timer_cl);
    
    // pattern b
    p =  sin(currentE * qn + timer_cl)*cos(currentE * pn + timer_cl) + currentG * cos(currentE * pn + timer_cl) * sin(currentF * pn + timer_cl);
    q =  sin(currentF * pn + timer_cl)*cos(currentF * qn + timer_cl) + currentH * cos(currentF * qn + timer_cl) * sin(currentE * qn + timer_cl);

    point(400 * p, 400 * q);
    stroke(hue_cl, 40, 80);

    pn = p;
    qn = q;
  }
    
  if(increase_cl) {
    hue_cl++;
    if(hue_cl >= 400) {
      increase_cl = false;
    }
  } else {
    hue_cl--;
    if(hue_cl <= 0) {
      increase_cl = true;
    }
  }
  
  // *draw attractor end* //
  
  angle += 0.1;
  m += 0.01;
}
