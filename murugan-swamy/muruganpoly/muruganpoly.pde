import processing.core.*;
import java.util.ArrayList;

public class MuruganDivinityVisualizer extends PApplet {

  ArrayList<SupremeDivinity> forms = new ArrayList<>();
  SupremeDivinity activeForm = null;
  PImage muruganImg;

  float mainX = 50, mainY = 40;
  float mainW = 850, mainH = 500;
  float avatarW = 120, avatarH = 120, gap = 20;

  public static void main(String[] args) {
    PApplet.main("MuruganDivinityVisualizer");
  }

  public void settings() {
    size(950, 650);
  }

  public void setup() {
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

    float startX = mainX + 60;
    float y = mainY + 310;

    for (int i = 0; i < names.length; i++) {
      float x = startX + i*(avatarW + gap);
      forms.add(new SupremeDivinity(this, names[i], imgs[i], x, y, causes[i]));
    }
  }

  public void draw() {
    background(250);
    drawMainCBlock(mainX, mainY, mainW, mainH);

    image(activeForm != null ? activeForm.img : muruganImg,
          mainX + mainW/2, mainY + 120, 260, 260);

    fill(30);
    textSize(24);
    text(activeForm != null ? activeForm.name : "Murugan", mainX + 40, mainY + 30);

    fill(50);
    textSize(18);
    text("for (Avatar form : forms) {", mainX + 40, mainY + 260);

    for (SupremeDivinity s : forms) {
      s.displayAvatar();
    }

    text("}", mainX + mainW - 60, mainY + 260);

    if (activeForm != null) {
      fill(80, 0, 120);
      textSize(16);
      text(activeForm.revealCause(), mainX + 40, mainY + mainH - 100, mainW - 80, 80);
    }
  }

  public void mousePressed() {
    for (SupremeDivinity s : forms) {
      if (s.isOver(mouseX, mouseY)) {
        activeForm = s;
        break;
      }
    }
  }

  void drawMainCBlock(float x, float y, float w, float h) {
    fill(220, 240, 255);
    stroke(60, 100, 160);
    strokeWeight(3);
    rect(x, y, w, h, 10);

    noFill();
    strokeWeight(5);
    stroke(60, 100, 160);
    arc(x - 10, y + 80, 60, 60, PI / 2, 3 * PI / 2);
    line(x - 10, y + 80, x - 10, y + h - 80);
    arc(x - 10, y + h - 80, 60, 60, 3 * PI / 2, PI / 2);
  }
}
