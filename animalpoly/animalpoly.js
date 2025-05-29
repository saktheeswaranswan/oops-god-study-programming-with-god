// Base Animal class with polymorphic methods
class Animal {
  constructor(emoji, name) {
    this.emoji = emoji;
    this.name = name;
  }
  birth() {
    return `A new ${this.name} is born!`;
  }
  eat() {
    return `${this.name} is eating.`;
  }
  pair() {
    return `${this.name} is finding a mate.`;
  }
  getActions() {
    return [this.birth(), this.eat(), this.pair()];
  }
}

// Different animals override eating and pairing behavior
class Lion extends Animal {
  constructor() { super('🦁', 'Lion'); }
  eat() { return 'Lion hunts and eats meat.'; }
  pair() { return 'Lion roars to attract a mate.'; }
}
class Elephant extends Animal {
  constructor() { super('🐘', 'Elephant'); }
  eat() { return 'Elephant eats grass and leaves.'; }
  pair() { return 'Elephant trumpets to find a mate.'; }
}
class Penguin extends Animal {
  constructor() { super('🐧', 'Penguin'); }
  eat() { return 'Penguin eats fish and krill.'; }
  pair() { return 'Penguins form lifelong pairs.'; }
}
class Monkey extends Animal {
  constructor() { super('🐒', 'Monkey'); }
  eat() { return 'Monkey eats fruits and insects.'; }
  pair() { return 'Monkeys groom each other to bond.'; }
}
class Frog extends Animal {
  constructor() { super('🐸', 'Frog'); }
  eat() { return 'Frog catches flies with its tongue.'; }
  pair() { return 'Frog croaks loudly to attract a mate.'; }
}
class Owl extends Animal {
  constructor() { super('🦉', 'Owl'); }
  eat() { return 'Owl hunts small rodents at night.'; }
  pair() { return 'Owls hoot to call a mate.'; }
}
class Dolphin extends Animal {
  constructor() { super('🐬', 'Dolphin'); }
  eat() { return 'Dolphin eats fish and squid.'; }
  pair() { return 'Dolphins use clicks to communicate during mating.'; }
}
class Snake extends Animal {
  constructor() { super('🐍', 'Snake'); }
  eat() { return 'Snake swallows prey whole.'; }
  pair() { return 'Snakes perform courtship dances.'; }
}
class Butterfly extends Animal {
  constructor() { super('🦋', 'Butterfly'); }
  eat() { return 'Butterfly drinks nectar from flowers.'; }
  pair() { return 'Butterflies flutter to attract mates.'; }
}
class Dog extends Animal {
  constructor() { super('🐕', 'Dog'); }
  eat() { return 'Dog eats kibble or meat.'; }
  pair() { return 'Dogs sniff and wag tails to greet mates.'; }
}

let animals = [
  new Lion(), new Elephant(), new Penguin(), new Monkey(), new Frog(),
  new Owl(), new Dolphin(), new Snake(), new Butterfly(), new Dog()
];

let gridSize = 5; // 5 columns x 2 rows
let gridWidth, gridHeight;
let selectedAnimal;
let showAnimalInfo = false;

function setup() {
  createCanvas(800, 600);
  gridWidth = width / gridSize;
  gridHeight = height / 2;
  selectedAnimal = animals[0];
  textFont('Segoe UI Emoji');
}

function draw() {
  background(240);

  drawEmojiGrid();
  displayRightSide();

  fill(0);
  textSize(16);
  textAlign(CENTER);
  text("Click an emoji to view animal details. Click right panel to toggle info.", width / 2, height - 10);
}

function mousePressed() {
  let clickedInGrid = false;

  for (let i = 0; i < gridSize; i++) {
    for (let j = 0; j < 2; j++) {
      let x = i * gridWidth;
      let y = j * gridHeight;
      if (mouseX > x && mouseX < x + gridWidth && mouseY > y && mouseY < y + gridHeight) {
        let index = j * gridSize + i;
        if (index < animals.length) {
          selectedAnimal = animals[index];
          showAnimalInfo = true;
          clickedInGrid = true;
        }
      }
    }
  }

  if (!clickedInGrid && mouseX > width / 2) {
    showAnimalInfo = !showAnimalInfo;
  }
}

function drawEmojiGrid() {
  textSize(64);
  textAlign(CENTER, CENTER);
  for (let i = 0; i < gridSize; i++) {
    for (let j = 0; j < 2; j++) {
      let idx = j * gridSize + i;
      if (idx < animals.length) {
        let x = i * gridWidth + gridWidth / 2;
        let y = j * gridHeight + gridHeight / 2;
        text(animals[idx].emoji, x, y);
      }
    }
  }
}

function displayRightSide() {
  fill(0);
  let panelX = width * 0.75;
  let panelY = height * 0.2;
  textAlign(CENTER, TOP);

  if (showAnimalInfo && selectedAnimal) {
    textSize(96);
    text(selectedAnimal.emoji, panelX, panelY);
    textSize(28);
    text(selectedAnimal.name, panelX, panelY + 110);

    let actions = selectedAnimal.getActions();
    textAlign(LEFT, TOP);
    textSize(18);
    let yOffset = panelY + 150;
    for (let i = 0; i < actions.length; i++) {
      text(actions[i], panelX - 150, yOffset + i * 30);
    }
  } else {
    textSize(48);
    text("Animal", panelX, height / 2);
  }
}
