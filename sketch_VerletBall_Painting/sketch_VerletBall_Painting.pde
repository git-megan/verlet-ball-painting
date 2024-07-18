/**
 Verlet ball chain to paint in black and white
 
 Verlet Integration
 Pos = pos + (pos-posOld)
 
 this is an alternative to changing the position based on speed e.g.(x += speed)
 */

int particles = 10;
VerletBall[] vballs = new VerletBall[particles];
int bonds = particles - 1;
VerletStick[] vsticks = new VerletStick[bonds];

void setup() {
  size(800, 700);
  float theta = PI/4.0;
  float shapeR = 40;

  PVector nudge = new PVector(1.5, 2.2);
  for (int i=0; i<particles; i++) {
    PVector start = new PVector(width/2+cos(theta)*shapeR, height/2+sin(theta)*shapeR);
    color myColor = color(20*i);
    vballs[i] = new VerletBall(start, nudge, (10 + 2*i), myColor);
    theta += TWO_PI/particles;

    if (i > 0) {
      vsticks[i-1] = new VerletStick(vballs[i-1], vballs[i]);
    }
  }
}

void draw() {
  // background(255);
  for (int i = 0; i < bonds; i++) {
    vsticks[i].render();
  }
}
