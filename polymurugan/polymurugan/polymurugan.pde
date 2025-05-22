ArrayList<SupremeDivinity> forms = new ArrayList<SupremeDivinity>();
SupremeDivinity activeForm = null;

PImage muruganImg;
float mainX = 50, mainY = 40;
float mainW = 850, mainH = 500;
float avatarW = 120, avatarH = 120, gap = 20;

void setup() {
  size(950, 650);
  imageMode(CENTER);
  textAlign(LEFT, TOP);
  rectMode(CORNER);
  smooth();

  muruganImg = loadImage("murugan.jpg");
  
  String[] names = {"Thiruchendur","Palani","Swamimalai","Thiruthani","Pazhamudircholai","Thirupparankundram"};
  String[] imgs  = {"1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg"};
  String[] causes = {
    "To defeat the demon Surapadman",
    "To teach renunciation and wisdom",
    "To enlighten Lord Shiva himself",
    "To bring peace and family reunion",
    "To bestow grace upon all",
    "To marry Deivanai, symbol of divine union"
  };
  
  // arrange horizontally with gap
  float startX = mainX + 60;
  float y = mainY + 310;
  for (int i = 0; i < names.length; i++) {
    float x = startX + i*(avatarW + gap);
    forms.add(new SupremeDivinity(names[i], imgs[i], x, y, causes[i]));
  }
}

void draw() {
  background(250);
  drawMainCBlock(mainX, mainY, mainW, mainH);
  
  // -- TOP: Murugan image & name
  image(activeForm != null ? activeForm.img : muruganImg,
        mainX + mainW/2, mainY + 120, 260, 260);
  fill(30);
  textSize(24);
  textAlign(LEFT, TOP);
  text(activeForm!=null ? activeForm.name : "Murugan",
       mainX + 40, mainY + 30);
  
  // -- Middle: for-loop line
  fill(50);
  textSize(18);
  text("for (Avatar form : forms) {", mainX + 40, mainY + 260);
  
  // -- Loop body: avatar blocks
  for (SupremeDivinity s : forms) {
    s.displayAvatar();
  }
  
  // -- Closing brace of loop
  text("}", mainX + mainW - 60, mainY + 260);
  
  // -- Bottom: cause text
  if (activeForm != null) {
    fill(80, 0, 120);
    textSize(16);
    textAlign(LEFT, TOP);
    text(activeForm.revealCause(),
         mainX + 40, mainY + mainH - 100, mainW - 80, 80);
  }
}

void mousePressed() {
  for (SupremeDivinity s : forms) {
    if (s.isOver(mouseX, mouseY)) {
      activeForm = s;
      break;
    }
  }
}

// draw a big C-style block with braces on the left
void drawMainCBlock(float x, float y, float w, float h) {
  fill(220, 240, 255);
  stroke(60, 100, 160);
  strokeWeight(3);
  rect(x, y, w, h, 10);
  // left curly braces
  noFill(); strokeWeight(5);
  stroke(60,100,160);
  // upper brace
  arc(x-10, y+80, 60, 60, PI/2, 3*PI/2);
  // middle line
  line(x-10, y+80, x-10, y+h-80);
  // lower brace
  arc(x-10, y+h-80, 60, 60, 3*PI/2, PI/2);
}

// --- SupremeDivinity class and override
class SupremeDivinity {
  String name, cause;
  PImage img;
  float x,y;
  float w=avatarW, h=avatarH;
  
  SupremeDivinity(String n, String imgP, float x, float y, String c) {
    name=n; cause=c; this.x=x; this.y=y; img=loadImage(imgP);
  }
  void displayAvatar() {
    // block
    fill(180,220,255); stroke(60,100,160); strokeWeight(2);
    rect(x,y,w,h,12);
    // notch
    noStroke(); fill(120,180,220);
    beginShape();
      vertex(x,y+25); vertex(x+25,y); vertex(x+w,y);
      vertex(x+w,y+h); vertex(x,y+h);
    endShape(CLOSE);
    // image & name
    image(img, x+w/2, y+h/2 - 10, w-40, h-40);
    fill(30); textSize(12); textAlign(CENTER, TOP);
    text(name, x+w/2, y+h-22);
  }
  boolean isOver(float mx, float my) {
    return mx>x && mx<x+w && my>y && my<y+h;
  }
  String revealCause() {
    return "As Murugan’s avatar \""+name+"\": "+cause;
  }
}
