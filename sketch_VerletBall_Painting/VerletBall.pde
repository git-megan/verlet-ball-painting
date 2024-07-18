class VerletBall {

  PVector pos, posOld; // tracks current and last position
  PVector push; // a nudge when starting or needing to reset the ball
  float radius; // radius of the ball
  float diameter;
  color fillCol;

  VerletBall() {
  }

  VerletBall(PVector pos, PVector push, float radius, color fillCol) {
    this.pos = pos;
    this.push = push;
    this.radius = radius;
    this.diameter = radius*2;
    this.fillCol = fillCol;
    
    this.posOld = new PVector(pos.x, pos.y);

    // start motion
    pos.add(push);
  }

  /**
   * Move position based on a verlet calculation
   * Ball will now be at its current place + the delta between its current place and previous location
   */
  void move() {
    // temporarily store its current position, as this will become the previous position
    PVector posTemp = new PVector(pos.x, pos.y);

    // add the delta between the previous and current location to make the new location
    pos.x += (pos.x - posOld.x);
    pos.y += (pos.y - posOld.y);

    // set the previous position to where the ball last was
    posOld.set(posTemp);

    // render the ball based on its updated location
    this.render();

    // check to ensure the ball is within the bounds, update if not
    this.boundsCollision();
  }

  void render() {
    // render the ball
    fill(this.fillCol);
    stroke(0, 200);
    ellipse(pos.x, pos.y, diameter, diameter);
  }

  void boundsCollision() {
    if (pos.x>width-radius) {
      pos.x = width-radius;
      posOld.x = pos.x;
      pos.x -= push.x;
    } else if (pos.x<radius) {
      pos.x = radius;
      posOld.x = pos.x;
      pos.x += push.x;
    }

    if (pos.y<radius) {
      pos.y = radius;
      posOld.y = pos.y;
      pos.y += push.y;
    }

    if (pos.y>height-radius) {
      pos.y = height-radius;
      posOld.y = pos.y;
      pos.y -= push.y;
    }
  }
}
