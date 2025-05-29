let mainImage;  // Main class image (Murugan)
let subclass;   // Subclass image (1.jpg)
let activeSubclass = false; // Flag to track if subclass is active

let scaleSlider;

function preload() {
  mainImage = loadImage('murugan.jpg'); // Main class image
  subclass = loadImage('1.jpg');        // Subclass image (1.jpg)
}

function setup() {
  createCanvas(1000, 600);
  
  // Slider to control the scaling of images
  scaleSlider = createSlider(0.1, 1, 0.5, 0.01);
  scaleSlider.position(820, 50);
  scaleSlider.style('width', '150px');
}

function draw() {
  background(255);
  
  // Draw the C-shaped block
  drawCBlock(50, 50, 200, height - 100);
  
  let scaleVal = scaleSlider.value();
  
  // Draw the main image or subclass image based on selection
  if (activeSubclass) {
    image(subclass, 300, height / 2 - subclass.height * scaleVal / 2, subclass.width * scaleVal, subclass.height * scaleVal);
  } else {
    image(mainImage, 300, height / 2 - mainImage.height * scaleVal / 2, mainImage.width * scaleVal, mainImage.height * scaleVal);
  }
  
  // Draw the subclass avatar (1.jpg) on the left side
  let w = subclass.width * scaleVal;
  let h = subclass.height * scaleVal;
  image(subclass, 50, 100 - h / 2, w, h);
  
  // Optional: Show slider value label
  fill(0);
  noStroke();
  textSize(14);
  text(`Scale: ${scaleVal.toFixed(2)}`, 820, 40);
}

function mousePressed() {
  let scaleVal = scaleSlider.value();
  
  // Check if clicked on the subclass avatar to replace the main image
  let w = subclass.width * scaleVal;
  let h = subclass.height * scaleVal;
  let x = 50;
  let y = 100 - h / 2;
  
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    activeSubclass = true;
  } else {
    activeSubclass = false;
  }
}

function drawCBlock(x, y, w, h) {
  fill(220);
  stroke(0);
  strokeWeight(3);
  beginShape();
  vertex(x, y);
  vertex(x + w, y);
  vertex(x + w, y + h);
  vertex(x + w / 2, y + h);
  vertex(x, y + h / 2);
  endShape(CLOSE);
}
