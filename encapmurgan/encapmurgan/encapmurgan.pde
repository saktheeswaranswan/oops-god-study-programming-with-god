// MuruganEncapsulated.pde
ArrayList<SupremeDivinity> forms = new ArrayList<SupremeDivinity>();
SupremeDivinity activeForm = null;
boolean wrongClick = false;  // track wrong clicks

PImage muruganImg;
final float MAIN_X = 50, MAIN_Y = 40;
final float MAIN_W = 850, MAIN_H = 500;
final float AVATAR_W = 120, AVATAR_H = 120, GAP = 20;

void setup() {
  size(950, 650);
  imageMode(CENTER);
  textAlign(LEFT, TOP);
  rectMode(CORNER);
  smooth();

  muruganImg = loadImage("murugan.jpg");
  initializeForms();
}

void draw() {
  background(250);
  drawMainCBlock(MAIN_X, MAIN_Y, MAIN_W, MAIN_H);
  drawTopSection();
  drawLoopSection();
  drawBottomSection();
}

void mousePressed() {
  boolean found = false;
  for (SupremeDivinity form : forms) {
    if (form.isOver(mouseX, mouseY)) {
      setActiveForm(form);
      found = true;
      break;
    }
  }
  if (!found) {
    // wrong click by devotee pilgrim 🚶‍♂️
    setActiveForm(null);
    wrongClick = true;
  }
}

void setActiveForm(SupremeDivinity form) {
  // Priest setter enforces encapsulation
  this.activeForm = form;
  wrongClick = false;
}

void initializeForms() {
  String[] names = {"Thiruchendur", "Palani", "Swamimalai", "Thiruthani", "Pazhamudircholai", "Thirupparankundram"};
  String[] imgs  = {"1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg"};
  String[] causes = {
    "To defeat the demon Surapadman",
    "To teach renunciation and wisdom",
    "To enlighten Lord Shiva himself",
    "To bring peace and family reunion",
    "To bestow grace upon all",
    "To marry Deivanai, symbol of divine union"
  };
  float startX = MAIN_X + 60;
  float y = MAIN_Y + 310;
  for (int i = 0; i < names.length; i++) {
    float x = startX + i * (AVATAR_W + GAP);
    forms.add(new SupremeDivinity(names[i], imgs[i], x, y, causes[i]));
  }
}

void drawTopSection() {
  PImage img = (activeForm != null) ? activeForm.getImg() : muruganImg;
  image(img, MAIN_X + MAIN_W/2, MAIN_Y + 120, 260, 260);
  fill(30);
  textSize(24);
  text((activeForm != null) ? "🙏 " + activeForm.getName() : "🛕 Murugan", MAIN_X + 40, MAIN_Y + 30);
}

void drawLoopSection() {
  fill(50);
  textSize(18);
  text("for (Avatar form : forms) {", MAIN_X + 40, MAIN_Y + 260);
  for (SupremeDivinity s : forms) {
    s.displayAvatar();
  }
  text("}", MAIN_X + MAIN_W - 60, MAIN_Y + 260);
}

void drawBottomSection() {
  if (wrongClick) {
    fill(200, 0, 0);
    textSize(18);
    textAlign(CENTER, TOP);
    text("🚫🚶‍♂️ You must select a valid avatar block!", width/2, MAIN_Y + MAIN_H - 80);
  }
  else if (activeForm != null) {
    fill(80, 0, 120);
    textSize(16);
    textAlign(LEFT, TOP);
    text(activeForm.revealCause(), MAIN_X + 40, MAIN_Y + MAIN_H - 100, MAIN_W - 80, 80);
  }
}

// draw a big C-style block with braces on the left
void drawMainCBlock(float x, float y, float w, float h) {
  fill(220, 240, 255);
  stroke(60, 100, 160);
  strokeWeight(3);
  rect(x, y, w, h, 10);
  noFill(); strokeWeight(5);
  stroke(60,100,160);
  arc(x-10, y+80, 60, 60, PI/2, 3*PI/2);
  line(x-10, y+80, x-10, y+h-80);
  arc(x-10, y+h-80, 60, 60, 3*PI/2, PI/2);
}

// SupremeDivinity class encapsulated with getters
class SupremeDivinity {
  private String name, cause;
  private PImage img;
  private float x, y;
  private final float w = AVATAR_W, h = AVATAR_H;

  SupremeDivinity(String name, String imgPath, float x, float y, String cause) {
    this.name = name;
    this.cause = cause;
    this.x = x;
    this.y = y;
    this.img = loadImage(imgPath);
  }

  void displayAvatar() {
    fill(180,220,255); stroke(60,100,160); strokeWeight(2);
    rect(x,y,w,h,12);
    noStroke(); fill(120,180,220);
    beginShape();
      vertex(x,y+25); vertex(x+25,y); vertex(x+w,y);
      vertex(x+w,y+h); vertex(x,y+h);
    endShape(CLOSE);
    image(img, x+w/2, y+h/2 - 10, w-40, h-40);
    fill(30); textSize(12); textAlign(CENTER, TOP);
    text(name, x+w/2, y+h-22);
  }

  boolean isOver(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }

  String revealCause() {
    return "🙏 As Murugan’s avatar '" + name + "': " + cause;
  }

  // Getters
  String getName() { return name; }
  PImage getImg() { return img; }
}
