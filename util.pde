color lerpColors(color[] colors, float t) {
  int len = colors.length - 1;
  float scaledTime = t * float(len);
  color oldColor = colors[int(scaledTime) % len];
  color newColor = colors[(int(scaledTime) + 1) % len];
  float newT = scaledTime - floor(scaledTime);
  return lerpColor(oldColor, newColor, newT);
}

float square(float n) {
  return n * n;
}
