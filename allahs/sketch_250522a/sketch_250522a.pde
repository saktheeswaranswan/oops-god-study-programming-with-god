PImage makkahImg, madinaImg;
Masjid masjid;
ArrayList<AllahAttribute> traits = new ArrayList<AllahAttribute>();
boolean animateTraits = false;
boolean combined = false;
float angle = 0;

void setup() {
  size(1200, 800);
  textFont(createFont("Segoe UI Emoji", 32));  // Emoji font
  textAlign(CENTER, CENTER);

  // Load images, check for loading failure
  makkahImg = loadImage("makkah.jpg");
  if (makkahImg == null) println("Warning: makkah.jpg not loaded");
  madinaImg = loadImage("madina.jpg");
  if (madinaImg == null) println("Warning: madina.jpg not loaded");

  masjid = new Masjid(width/2, height/2, makkahImg, madinaImg);

  // Add sample Allah attributes (expandable)
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

  arrangeTraitsCircle();
  println("Setup done");
}

void draw() {
  background(255);

  masjid.display();

  if (combined) {
    // Display combined emojis centered with text
    fill(0);
    textSize(64);
    String combinedEmojis = "";
    for (AllahAttribute trait : traits) {
      combinedEmojis += trait.emoji;
    }
    text(combinedEmojis, width/2, height/2);
    textSize(48);
    text("لَا إِلٰهَ إِلَّا ٱللَّٰهُ\n(There is no god but Allah)", width/2, height/2 + 100);
  } else {
    // Normal display and optional animation
    for (int i = 0; i < traits.size(); i++) {
      AllahAttribute trait = traits.get(i);
      if (animateTraits) {
        float a = angle + TWO_PI / traits.size() * i;
        trait.setPosition(width/2 + 300 * cos(a), height/2 + 300 * sin(a));
      }
      trait.display();
    }
    if (animateTraits) {
      angle += 0.01;
    }
  }
}

void mousePressed() {
  if (combined) {
    // If combined, click anywhere resets
    combined = false;
  } else {
    // Check if any trait emoji clicked
    for (AllahAttribute trait : traits) {
      if (trait.isMouseOver(mouseX, mouseY)) {
        combined = true;
        animateTraits = false;
        println("Combined all emojis!");
        return;
      }
    }
    // Otherwise toggle rotation animation
    animateTraits = !animateTraits;
  }
}

void arrangeTraitsCircle() {
  for (int i = 0; i < traits.size(); i++) {
    float a = TWO_PI / traits.size() * i;
    traits.get(i).setPosition(width/2 + 300 * cos(a), height/2 + 300 * sin(a));
  }
}

// ----- Masjid Class -----
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
    if (makkah != null) image(makkah, x - 150, y - 100, 180, 180);
    if (madina != null) image(madina, x + 150, y - 100, 180, 180);
    fill(0);
    textSize(28);
    text("Masjid al-Haram & Masjid an-Nabawi", x, y + 90);
  }
}

// ----- AllahAttribute Base Class -----
class AllahAttribute {
  String name, emoji, meaning;
  float x, y;
  float emojiSize = 48;

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
    text(name, x, y + 40);
  }

  boolean isMouseOver(float mx, float my) {
    // Approximate hitbox as square around emoji
    return mx > x - emojiSize/2 && mx < x + emojiSize/2 && my > y - emojiSize/2 && my < y + emojiSize/2;
  }
}

// ----- AllahAttribute Subclasses -----
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
