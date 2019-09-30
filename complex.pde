class Complex {
  float r, i;

  Complex(float r, float i) {
    this.r = r;
    this.i = i;
  }
  
  Complex clone() {
    return new Complex(r, i);
  }

  String toString(int precision) {
    float f = pow(10, precision);
    float r = round(this.r * f) / f;
    float i = round(this.i * f) / f;
    if (r == 0 && i == 0) {
      return "0";
    }
    if (i == 0) {
        return "" + r;
      }
    if (i > 0) {
      if (r == 0) {
        return i + "i";
      }
      return r + " - " + i + "i";
    }
    if (r == 0) {
        return (-i) + "i";
      }
    return r + " + " + (-i) + "i";
  }
}
