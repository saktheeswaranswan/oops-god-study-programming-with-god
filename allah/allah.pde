// Main Sketch File: sketch.pde

PImage makkahImg, madinaImg;
Masjid masjid;
ArrayList<AllahAttribute> traits = new ArrayList<AllahAttribute>();
boolean animateTraits = false;
float angle = 0;

void setup() {
  size(1200, 800);
  textFont(createFont("Segoe UI Emoji", 24));
  textAlign(CENTER, CENTER);

  // Load images
  makkahImg = loadImage("makkah.jpg");
  madinaImg = loadImage("madina.jpg");

  masjid = new Masjid(width/2, height/2, makkahImg, madinaImg);

  // Add Allah's 99 attributes + AllahRoot
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
  traits.add(new AllahRoot("Allah", "🕋️", "The Only God"));

  for (int i = 0; i < traits.size(); i++) {
    float a = TWO_PI / traits.size() * i;
    traits.get(i).setPosition(width/2 + 300 * cos(a), height/2 + 300 * sin(a));
  }
}

void draw() {
  background(255);
  masjid.display();

  for (int i = 0; i < traits.size(); i++) {
    AllahAttribute trait = traits.get(i);
    if (animateTraits) {
      float a = angle + TWO_PI / traits.size() * i;
      trait.setPosition(width/2 + 300 * cos(a), height/2 + 300 * sin(a));
    }
    trait.display();
  }

  if (animateTraits) {
    fill(0);
    textSize(36);
    text("لا إِلَهَ إِلَّا ٱللهُ", width/2, height - 50);
    angle += 0.01;
  }
}

void mousePressed() {
  animateTraits = !animateTraits;
}

// File: Masjid.pde
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
    image(makkah, x - 120, y - 100, 150, 150);
    image(madina, x + 120, y - 100, 150, 150);
    textSize(28);
    fill(0);
    text("Masjid al-Haram & Masjid an-Nabawi", x, y + 80);
  }
}

// File: AllahAttribute.pde
class AllahAttribute {
  String name, emoji, meaning;
  float x, y;

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
    textSize(24);
    text(emoji, x, y - 20);
    text(name, x, y + 10);
  }
}

// File: AllahTraitClasses.pde
class ArRahman extends AllahAttribute {
  ArRahman(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class ArRaheem extends AllahAttribute {
  ArRaheem(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AlMalik extends AllahAttribute {
  AlMalik(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AlQuddus extends AllahAttribute {
  AlQuddus(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AsSalam extends AllahAttribute {
  AsSalam(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AlMumin extends AllahAttribute {
  AlMumin(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AlMuhaymin extends AllahAttribute {
  AlMuhaymin(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AlAziz extends AllahAttribute {
  AlAziz(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AlJabbar extends AllahAttribute {
  AlJabbar(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AlMutakabbir extends AllahAttribute {
  AlMutakabbir(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AlKhaliq extends AllahAttribute {
  AlKhaliq(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
class AllahRoot extends AllahAttribute {
  AllahRoot(String name, String emoji, String meaning) {
    super(name, emoji, meaning);
  }
}
