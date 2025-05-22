PImage fatherImg, sonImg, holySpiritImg;
ArrayList<TrinityEntity> entities = new ArrayList<TrinityEntity>();
God godBlock = null;
Priest priest;

void setup() {
  size(800, 600);
  fatherImg     = loadImage("assets/father.jpg");
  sonImg        = loadImage("assets/son.jpg");
  holySpiritImg = loadImage("assets/holy_spirit.jpg");

  // Fonts
  textSize(64);
  textAlign(CENTER, CENTER);
  textFont(createFont("Segoe UI Emoji", 64));

  // Place Trinity members
  entities.add(new Father(fatherImg, 200, 400));
  entities.add(new Son(sonImg, 400, 400));
  entities.add(new HolySpirit(holySpiritImg, 600, 400));

  // Encapsulated Priest
  priest = new Priest(400, 520);
}

void draw() {
  background(255);

  if (godBlock != null) {
    godBlock.display();
  } else {
    for (TrinityEntity e : entities) {
      e.display();

      if (dist(mouseX, mouseY, e.x, e.y) < 60) {
        fill(0);
        textSize(20);
        textFont(createFont("Arial-BoldMT", 20));
        text(e.getNature(), e.x, e.y - 110);
        textFont(createFont("Segoe UI Emoji", 64));
        textSize(64);
      }
    }
  }

  // Priest is always visible
  priest.display();
}

void mousePressed() {
  if (dist(mouseX, mouseY, priest.x, priest.y) < 60) {
    priest.setBelief(true);
    if (priest.reachGod()) {
      TrinityEntity f = entities.get(0);
      godBlock = new God(fatherImg, sonImg, holySpiritImg, width/2, 150);
    }
  } else if (godBlock != null) {
    godBlock = null;
    priest.setBelief(false); // reset belief
  }
}

// ——————————————————————
// Abstract base
// ——————————————————————
abstract class TrinityEntity {
  PImage img;
  float x, y, angle = 0;
  TrinityEntity(PImage img, float x, float y) {
    this.img = img;
    this.x = x;
    this.y = y;
  }
  abstract void display();
  abstract String getNature();
}

// ——————————————————————
// Trinity Subclasses
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
    text("⛰️", x, y - 70);
    label();
  }
  String getNature() { return "⛰️ Eternal Creator – All-Powerful"; }
  void label() {
    fill(0); textSize(16);
    textFont(createFont("Arial-BoldMT", 16));
    text("Father", x, y + 60);
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
    label();
  }
  String getNature() { return "💧 Redeemer – Sacrificial Love"; }
  void label() {
    fill(0); textSize(16);
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
    label();
  }
  String getNature() { return "☁️ Comforter – Guiding Presence"; }
  void label() {
    fill(0); textSize(16);
    textFont(createFont("Arial-BoldMT", 16));
    text("Holy Spirit", x, y + 60);
    textFont(createFont("Segoe UI Emoji", 64));
    textSize(64);
  }
}

// ——————————————————————
// God class (inheritance demo)
// ——————————————————————
class God extends TrinityEntity {
  PImage img2, img3;
  God(PImage f, PImage s, PImage h, float x, float y) {
    super(f, x, y);
    this.img2 = s;
    this.img3 = h;
  }
  void display() {
    pushMatrix();
      translate(x, y - 20);
      rotate(-angle);
      textSize(100);
      text("👑", 0, 0);
    popMatrix();

    pushMatrix();
      translate(x, y + 20);
      rotate(angle);
      imageMode(CENTER);
      image(img,  -120, 0, 100, 100);
      image(img2,    0, 0, 100, 100);
      image(img3,  120, 0, 100, 100);
    popMatrix();
    angle += 0.01;

    pushMatrix();
      translate(x, y - 40);
      textSize(48);
      text("⛰️", -120, -80);
      text("💧",    0, -80);
      text("☁️",  120, -80);
    popMatrix();

    fill(0);
    textSize(18);
    textFont(createFont("Arial-BoldMT", 18));
    text("Father", x - 120, y + 80);
    text("Son", x, y + 80);
    text("Holy Spirit", x + 120, y + 80);
    textSize(24);
    text("God (Inheritance)", x, y + 120);
    textFont(createFont("Segoe UI Emoji", 64));
    textSize(64);
  }
  String getNature() { return "👑 Unity of Trinity – One God"; }
}

// ——————————————————————
// Priest Class (Encapsulation Demo)
// ——————————————————————
class Priest {
  float x, y;
  boolean belief = false;

  Priest(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    textSize(48);
    text("👨‍⚖️", x, y);
    textSize(16);
    fill(0);
    textFont(createFont("Arial-BoldMT", 16));
    text("Priest (ABNN)", x, y + 40);
    textFont(createFont("Segoe UI Emoji", 64));
    textSize(64);
  }

  void setBelief(boolean b) {
    this.belief = b;
  }

  boolean getBelief() {
    return this.belief;
  }

  boolean reachGod() {
    return belief;
  }
}
