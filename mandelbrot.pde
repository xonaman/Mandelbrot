final Camera camera = new Camera();
final Controls controls = new Controls();
final boolean julia = false;

Complex start = new Complex(0, 0);
boolean useColors = true;
int maxIterations = 100;
PVector lastMousePosition;
PImage mandelbrot;
boolean repaint;

void setup() {
  size(800, 600);
  pixelDensity(1);
  frameRate(30);
  surface.setTitle("Mandelbrot");
  
  controls.init(this);

  mandelbrot = createImage(width, height, RGB);
  repaint = true;
}

void draw() {
  if (repaint) {
    drawMandelbrot();
    repaint = false;
  }
  image(mandelbrot, 0, 0, width, height);
  drawCoordinateSystem();

  float px = camera.toX(start.r);
  float py = camera.toY(start.i);
  for (int i = 0; i < 2; i++) {
    if (i == 0) {
      stroke(0);
      strokeWeight(3);
    } else {
      stroke(255);
      strokeWeight(1.5);
    }
    line(px - 5, py - 5, px + 5, py + 5);
    line(px - 5, py + 5, px + 5, py - 5);
  }

  String t = camera.toComplex(mouseX, mouseY).toString(3);
  if (useColors) {
    fill(255);
  } else {
    fill(255, 0, 0);
  }
  textSize(14);
  text(t, 4, height - 8);

  surface.setTitle("Mandelbrot (" + floor(frameRate) + "fps)");
}

// https://randomascii.wordpress.com/2011/08/13/faster-fractals-through-algebra/
void drawMandelbrot() {
  int startTime = millis();
  mandelbrot.loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      Complex point = camera.toComplex(x, y);
      Complex num = start.clone();
      if (julia) {
        num = point;
        point = start;
      }
      float r2 = num.r * num.r;
      float i2 = num.i * num.i;
      int i;
      for (i = 0; i < maxIterations; i++) {
        if (r2 + i2 > 4) {
          break;
        }
        num.i = (num.r + num.i) * (num.r + num.i) - r2 - i2 + point.i;
        num.r = r2 - i2 + point.r;
        r2 = num.r * num.r;
        i2 = num.i * num.i;
      }
      if (i == maxIterations) {
        mandelbrot.set(x, y, color(0));
      } else if (!useColors) {
        mandelbrot.set(x, y, color(255));
      } else {
        float n = map(i, 0, 100, 0, 1);
        mandelbrot.set(x, y, lerpColors(colors, sqrt(n)));
      }
    }
  }
  mandelbrot.updatePixels();
  println("Time: " + (millis() - startTime) + "ms");
}

void drawCoordinateSystem() {
  Complex min = camera.min();
  Complex max = camera.max();
  for (int i = 0; i < 2; i++) {
    if (i == 0) {
      stroke(0);
      strokeWeight(2);
    } else {
      stroke(255);
      strokeWeight(1);
    }
    for (float r = min.r; r <= max.r; r++) {
      if (r == 0) {
        line(camera.toX(r), 0, camera.toX(r), height);
      } else {
        line(camera.toX(r), camera.toY(0) - 10, camera.toX(r), camera.toY(0) + 10);
      }
    }
    for (float j = min.i; j <= max.i; j++) {
      if (j == 0) {
        line(0, camera.toY(j), width, camera.toY(j));
      } else {
        line(camera.toX(0) - 10, camera.toY(j), camera.toX(0) + 10, camera.toY(j));
      }
    }
  }
}

void mouseMoved() {
  if (controls.isMouseOver()) {
    cursor(HAND);
  } else {
    cursor(CROSS);
  }
}

void mouseDragged() {
  if (controls.isMouseOver()) {
    return;
  }
  if (mouseButton == RIGHT) {
    start = camera.toComplex(mouseX, mouseY);
    repaint = true;
    return;
  }
  camera.x += (pmouseX - mouseX);
  camera.y += (pmouseY - mouseY);
  repaint = true;
}

void mousePressed() {
  if (controls.isMouseOver()) {
    return;
  }
  if (mouseButton == RIGHT) {
    start = camera.toComplex(mouseX, mouseY);
    repaint = true;
    return;
  }
  lastMousePosition = new PVector(mouseX, mouseY);
}

void mouseReleased() {
  if (lastMousePosition == null || lastMousePosition.x != mouseX || lastMousePosition.y != mouseY) {
    return;
  }
  float f = keyPressed && key == 32 ? 0.5 : 2;
  camera.zoom *= f;
  camera.x = f * (mouseX - width / 2 + camera.x);
  camera.y = f * (mouseY - height / 2 + camera.y);
  repaint = true;
}
