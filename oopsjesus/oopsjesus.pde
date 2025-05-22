PImage fatherImg, sonImg, holySpiritImg;
ArrayList<TrinityEntity> entities = new ArrayList<TrinityEntity>();
God godBlock = null;

void setup() {
  size(800, 600);
  fatherImg     = loadImage("assets/father.jpg");
  sonImg        = loadImage("assets/son.jpg");
  holySpiritImg = loadImage("assets/holy_spirit.jpg");

  // big emoji font
  textSize(64);
  textAlign(CENTER, CENTER);
  textFont(createFont("Segoe UI Emoji", 64));

  // place each Person
  entities.add(new Father(fatherImg,       200, 400));
  entities.add(new Son   (sonImg,          400, 400));
  entities.add(new HolySpirit(holySpiritImg, 600, 400));
}

void draw() {
  background(255);
  if (godBlock != null) {
    godBlock.display();
  } else {
    for (TrinityEntity e : entities) {
      e.display();
    }
  }
}

void mousePressed() {
  if (godBlock == null) {
    TrinityEntity f = entities.get(0);
    if (dist(mouseX, mouseY, f.x, f.y) < 50) {
      // inheritance: God *is* a TrinityEntity
      godBlock = new God(fatherImg, sonImg, holySpiritImg, width/2, 150);
    }
  } else {
    godBlock = null;
  }
}

// ——————————————————————
// Abstract base for all four
// ——————————————————————
abstract class TrinityEntity {
  PImage img;
  float x, y, angle = 0;
  TrinityEntity(PImage img, float x, float y) {
    this.img = img;  this.x = x;  this.y = y;
  }
  abstract void display();
}

// ——————————————————————
// Father, Son, HolySpirit
// ——————————————————————
class Father extends TrinityEntity {
  Father(PImage img, float x, float y) { super(img, x, y); }
  void display() {
    pushMatrix();
      translate(x, y);
      rotate(angle);
      imageMode(CENTER);
      image(img, 0, 0, 100, 100);
    popMatrix();
    angle += 0.01;
    
    // emoji above
    text("⛰️", x, y - 70);
    // label below
    fill(0);
    textSize(16);
    textFont(createFont("Arial-BoldMT", 16));
    text("Father", x, y + 60);
    
    // restore big emoji font
    textFont(createFont("Segoe UI Emoji", 64));
    textSize(64);
  }
}

class Son extends TrinityEntity {
  Son(PImage img, float x, float y) { super(img, x, y); }
  void display() {
    pushMatrix();
      translate(x, y);
      scale(1 + 0.1 * sin(angle));
      imageMode(CENTER);
      image(img, 0, 0, 100, 100);
    popMatrix();
    angle += 0.05;
    
    text("💧", x, y - 70);
    fill(0);
    textSize(16);
    textFont(createFont("Arial-BoldMT", 16));
    text("Son", x, y + 60);
    textFont(createFont("Segoe UI Emoji", 64));
    textSize(64);
  }
}

class HolySpirit extends TrinityEntity {
  HolySpirit(PImage img, float x, float y) { super(img, x, y); }
  void display() {
    pushMatrix();
      translate(x, y + sin(angle)*10);
      imageMode(CENTER);
      image(img, 0, 0, 100, 100);
    popMatrix();
    angle += 0.1;
    
    text("☁️", x, y - 70);
    fill(0);
    textSize(16);
    textFont(createFont("Arial-BoldMT", 16));
    text("Holy Spirit", x, y + 60);
    textFont(createFont("Segoe UI Emoji", 64));
    textSize(64);
  }
}

// ——————————————————————
// God subclass demonstrates inheritance
// ——————————————————————
class God extends TrinityEntity {
  PImage img2, img3;
  God(PImage f, PImage s, PImage h, float x, float y) {
    super(f, x, y);
    this.img2 = s;
    this.img3 = h;
  }
  void display() {
    // draw rotating crown around
    pushMatrix();
      translate(x, y - 20);
      rotate(-angle);
      textSize(100);
      text("👑", 0, 0);
    popMatrix();
    
    // draw the three images side-by-side
    pushMatrix();
      translate(x, y + 20);
      rotate(angle);
      imageMode(CENTER);
      image(img,  -120, 0, 100, 100);
      image(img2,    0, 0, 100, 100);
      image(img3,  120, 0, 100, 100);
    popMatrix();
    angle += 0.01;
    
    // emojis above each
    pushMatrix();
      translate(x, y - 40);
      textSize(48);
      text("⛰️", -120, -80);
      text("💧",    0, -80);
      text("☁️",  120, -80);
    popMatrix();
    
    // labels below
    fill(0);
    textSize(18);
    textFont(createFont("Arial-BoldMT", 18));
    textAlign(CENTER, TOP);
    text("Father",       x - 120, y + 80);
    text("Son",           x,      y + 80);
    text("Holy Spirit",  x + 120, y + 80);
    
    // overall “God” label
    textSize(24);
    textFont(createFont("Arial-BoldMT", 24));
    text("God (Inheritance)", x, y + 120);
    
    // restore emoji font
    textFont(createFont("Segoe UI Emoji", 64));
    textSize(64);
  }
}
