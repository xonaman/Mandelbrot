import controlP5.*;

ControlP5 cp5;
Toggle useColorsToggle;
Slider maxIterationsSlider;

void initControls() {
  cp5 = new ControlP5(this);
  
  useColorsToggle = cp5.addToggle("Colored");
  useColorsToggle.setPosition(10, 10);
  useColorsToggle.setSize(20, 20);
  useColorsToggle.addListener(new ControlListener() {
    public void controlEvent(ControlEvent event) {
      useColors = event.getValue() > 0;
      useColorsToggle.setColorCaptionLabel(useColors ? color(255) : color(255, 0, 0));
      maxIterationsSlider.setColorCaptionLabel(useColors ? color(255) : color(255, 0, 0));
      repaint = true;
    }
  });
  
  maxIterationsSlider = cp5.addSlider("Iterations");
  maxIterationsSlider.setPosition(10, 50);
  maxIterationsSlider.setRange(1, 1000);
  maxIterationsSlider.addListener(new ControlListener() {
    public void controlEvent(ControlEvent event) {
      maxIterations = int(event.getValue());
      repaint = true;
    }
  });
  
  useColorsToggle.setValue(useColors);
  maxIterationsSlider.setValue(maxIterations);
}
