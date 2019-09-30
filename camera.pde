class Camera {
  float x = -150;
  float y = 0;
  float zoom = 250;
  
  PVector offset() {
    return new PVector(-width / 2 + x, -height / 2 + y);
  }
  
  float toX(float re) {
    return (re * zoom + width / 2 - x);
  }
  
  float toY(float im) {
    return (im * zoom + height / 2 - y);
  }
  
  Complex toComplex(float x, float y) {
    PVector offset = offset();
    return new Complex((x + offset.x) / zoom, (y + offset.y) / zoom);
  }
  
  Complex min() {
    PVector offset = offset();
    return new Complex(floor(offset.x / zoom), floor(offset.y / zoom));
  }
  
  Complex max() {
    PVector offset = offset();
    return new Complex(floor((width + offset.x) / zoom), floor((height + offset.y) / zoom));
  }
}
