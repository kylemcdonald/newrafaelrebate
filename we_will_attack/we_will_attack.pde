// http://www.wewillattack.com/ (2002)

PVector cur, prev;
PVector curGrad, prevGrad;
color curColor, prevColor;

void setup() {
  size(800, 600, P2D);
  colorMode(HSB, 1);
}

void drawGradient() {
  float longest = dist(0, 0, width, height);

  PVector direction = new PVector();
  PVector corner = new PVector();
  PVector fnw = new PVector();
  PVector fsw = new PVector();
  PVector fne = new PVector();
  PVector fse = new PVector();
  PVector nw = new PVector();
  PVector sw = new PVector();
  PVector ne = new PVector();
  PVector se = new PVector();

  direction.set(curGrad);
  direction.sub(prevGrad);
  direction.normalize();
  direction.mult(longest);
  corner.set(direction);
  corner.rotate(HALF_PI);

  nw.set(prevGrad);
  sw.set(prevGrad);
  ne.set(curGrad);
  se.set(curGrad);
  nw.add(corner);
  sw.sub(corner);
  ne.add(corner);
  se.sub(corner);

  fnw.set(nw);
  fsw.set(sw);
  fne.set(ne);
  fse.set(se);
  fnw.sub(direction);
  fsw.sub(direction);
  fne.add(direction);
  fse.add(direction);

  noStroke();
  beginShape(QUADS);
  fill(prevColor);
  vertex(fsw.x, fsw.y);
  vertex(fnw.x, fnw.y);
  vertex(nw.x, nw.y);
  vertex(sw.x, sw.y);
  
  vertex(sw.x, sw.y);
  vertex(nw.x, nw.y);

  fill(curColor);
  vertex(ne.x, ne.y);
  vertex(se.x, se.y);
  
  vertex(se.x, se.y);
  vertex(ne.x, ne.y);
  vertex(fne.x, fne.y);
  vertex(fse.x, fse.y);
  endShape();
}

void draw() {
  background(0, 0, 1);
  cur = new PVector(mouseX, mouseY);
  if (prev != null && prev.x != 0 && prev.x != 0) {
    if(prevGrad != null) {
      drawGradient();
    }
    stroke(0);
    line(prev.x, prev.y, cur.x, cur.y);
  }
}

void mousePressed() {
  // random substitute for what's probably a palette
  float baseHue = random(1);
  prevColor = color(baseHue, 1, 1);
  curColor = color((baseHue + random(.2, .8)) % 1., 1, 1);
  if(random(1) < .1) {
    if(random(1) < .5) {
      prevColor = color(0, 0, 1);
    } else {
      curColor = color(0, 0, 1);
    }
  }
  
  prevGrad = prev;
  curGrad = cur;
  prev = cur;
}

