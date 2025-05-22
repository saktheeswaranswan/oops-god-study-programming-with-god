PImage makkahImg, madinaImg;
Masjid masjid;
ArrayList<AllahAttribute> traits = new ArrayList<AllahAttribute>();
boolean animateTraits = true;  // start animating by default
boolean combined = false;
float angle = 0;

void setup() {
  size(1200, 800);
  textFont(createFont("Segoe UI Emoji", 48));  // Emoji font with good size
  textAlign(CENTER, CENTER);

  // Load mosque images (make sure these images exist in the sketch's "data" folder)
  makkahImg = loadImage("makkah.jpg");
  if (makkahImg == null) println("Warning: makkah.jpg not loaded");
  madinaImg = loadImage("madina.jpg");
  if (madinaImg == null) println("Warning: madina.jpg not loaded");

  masjid = new Masjid(width/2, height/2, makkahImg, madinaImg);

  // Add Allah's attributes as traits with emojis
  traits.add(new ArRahman("Ar-Rahman", "🌤️", "The Most Merciful"));
  traits.add(new ArRaheem("Ar-Raheem", "💖", "The Most Compassionate"));
  traits.add(new AlMalik("Al-Malik", "👑", "The King"));
  traits.add(new AlQuddus("Al-Quddus", "✨", "The Pure"));
  traits.add(new AsSalam("As-Salam", "🕊️", "Source of Peace"));
  traits.add(new AlMumin("Al-Mu'min", "🛡️", "The Granter of Security"));
  traits.add(new AlMuhaymin("Al-Muhaymin", "👁️", "The Protector"));
  traits.add(new AlAziz("Al-Aziz", "🗡️", "The Almighty"));
  traits.add(new AlJabbar("Al-Jabbar", "📏", "The Compeller"));
  traits.add(new AlMutakabbir("Al-Mutakabbir", "🧠", "The Majestic"));
  traits.add(new AlKhaliq("Al-Khaliq", "💪", "The Creator"));
  traits.add(new AllahRoot("Allah", "🕋", "The Only God"));

  // Arrange traits initially in a circle
  arrangeTraitsCircle();

  println("Setup done");
}

void draw() {
  background(255);

  // Display the mosque images at the center
  masjid.display();

  if (combined) {
    // Show combined emojis at center with declaration text
    fill(0);
    textSize(96);
    String combinedEmojis = "";
    for (AllahAttribute trait : traits) {
      combinedEmojis += trait.emoji;
    }
    text(combinedEmojis, width/2, height/2);

    textSize(48);
    text("لَا إِلٰهَ إِلَّا ٱللَّٰهُ\n(There is no god but Allah)", width/2, height/2 + 140);

  } else {
    // Show traits in circle, animate rotation if enabled
    for (int i = 0; i < traits.size(); i++) {
      AllahAttribute trait = traits.get(i);
      if (animateTraits) {
        // Calculate position on rotating circle
        float a = angle + TWO_PI / traits.size() * i;
        float radius = 300;
        trait.setPosition(width/2 + radius * cos(a), height/2 + radius * sin(a));
      }
      trait.display();
    }
    if (animateTraits) {
      angle += 0.01;  // Increment rotation angle smoothly
    }
  }
}

void mousePressed() {
  if (combined) {
    // Reset from combined view on any click
    combined = false;
    animateTraits = true;  // Resume animation
    arrangeTraitsCircle();
  } else {
    // Check if any emoji clicked to combine
    for (AllahAttribute trait : traits) {
      if (trait.isMouseOver(mouseX, mouseY)) {
        combined = true;
        animateTraits = false;
        println("Combined all emojis!");
        return;
      }
    }
    // Toggle animation on click outside emojis
    animateTraits = !animateTraits;
    if (!animateTraits) {
      // If animation stopped, keep traits fixed in current positions
      // So do nothing else here
    } else {
      // If animation resumed, reset circle arrangement to prevent jumps
      arrangeTraitsCircle();
    }
  }
}

// Arrange traits evenly in a circle around center (non-rotating)
void arrangeTraitsCircle() {
  float radius = 300;
  for (int i = 0; i < traits.size(); i++) {
    float a = TWO_PI / traits.size() * i;
    traits.get(i).setPosition(width/2 + radius * cos(a), height/2 + radius * sin(a));
  }
}

// --- Masjid class to display mosque images ---
class Masjid {
  float x, y;
  PImage makkah, madina;

  Masjid(float x, float y, PImage makkah, PImage madina) {
    this.x = x;
    this.y = y;
    this.makkah = makkah;
    this.madina = madina;
  }

  void display() {
    imageMode(CENTER);
    if (makkah != null) image(makkah, x - 180, y - 150, 200, 200);
    if (madina != null) image(madina, x + 180, y - 150, 200, 200);

    fill(0);
    textSize(28);
    textAlign(CENTER, CENTER);
    text("Masjid al-Haram & Masjid an-Nabawi", x, y + 90);
  }
}

// --- Base class for Allah Attributes ---
class AllahAttribute {
  String name, emoji, meaning;
  float x, y;
  float emojiSize = 64;

  AllahAttribute(String name, String emoji, String meaning) {
    this.name = name;
    this.emoji = emoji;
    this.meaning = meaning;
    this.x = 0;
    this.y = 0;
  }

  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(emojiSize);
    text(emoji, x, y);
    textSize(20);
    text(name, x, y + emojiSize/1.5);
  }

  boolean isMouseOver(float mx, float my) {
    // Simple square hitbox around emoji center
    return mx > x - emojiSize/2 && mx < x + emojiSize/2 &&
           my > y - emojiSize/2 && my < y + emojiSize/2;
  }
}

// --- Subclasses for each attribute (can add more later) ---
class ArRahman extends AllahAttribute { ArRahman(String n, String e, String m) { super(n,e,m); } }
class ArRaheem extends AllahAttribute { ArRaheem(String n, String e, String m) { super(n,e,m); } }
class AlMalik extends AllahAttribute { AlMalik(String n, String e, String m) { super(n,e,m); } }
class AlQuddus extends AllahAttribute { AlQuddus(String n, String e, String m) { super(n,e,m); } }
class AsSalam extends AllahAttribute { AsSalam(String n, String e, String m) { super(n,e,m); } }
class AlMumin extends AllahAttribute { AlMumin(String n, String e, String m) { super(n,e,m); } }
class AlMuhaymin extends AllahAttribute { AlMuhaymin(String n, String e, String m) { super(n,e,m); } }
class AlAziz extends AllahAttribute { AlAziz(String n, String e, String m) { super(n,e,m); } }
class AlJabbar extends AllahAttribute { AlJabbar(String n, String e, String m) { super(n,e,m); } }
class AlMutakabbir extends AllahAttribute { AlMutakabbir(String n, String e, String m) { super(n,e,m); } }
class AlKhaliq extends AllahAttribute { AlKhaliq(String n, String e, String m) { super(n,e,m); } }
class AllahRoot extends AllahAttribute { AllahRoot(String n, String e, String m) { super(n,e,m); } }
