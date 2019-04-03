int width = 600;
int height = 600;

void setup() {
  size(600, 600);
  background(255);
  smooth();

  float xStart = random(10);
  float xNoise = xStart;
  float yNoise = random(10);

  for(int y = 0; y <= height; y+=7) {
    yNoise += 0.1;
    xNoise = xStart;
    for(int x = 0; x <= width; x+=7) {
      xNoise += 0.1;

      drawPoint(x, y, noise(xNoise, yNoise));
    }
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(360));
  stroke(123, 193 + noiseFactor * 4, 214);
  line(0, 0, 30 * noiseFactor * 2, 0);
  popMatrix();
}