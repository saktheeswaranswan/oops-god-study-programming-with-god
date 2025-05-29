let vehicles = [
  { emoji: '🏍️', name: 'Motorcycle', actions: ['🔑 Turn key ON', '⚙️ Set engine RUN', '🔘 Press starter button OR 🦶 Kick lever'] },
  { emoji: '🚗', name: 'Car (Manual)', actions: ['🔑 Turn ignition key ON', '🦶 Press clutch pedal fully', '🅿️ Release parking brake', '🔘 Press starter button'] },
  { emoji: '🚀', name: 'Rocket', actions: ['✅ Systems go', '🔌 Start APUs', '🔥 Ignite engines'] }
];

let gridSize = 3; // 3x3 grid
let gridWidth, gridHeight;
let selectedVehicle;
let showVehicleInfo = false;  // Toggle state for showing vehicle info

function setup() {
  createCanvas(600, 600);
  gridWidth = width / gridSize;
  gridHeight = height / gridSize;
  selectedVehicle = vehicles[1]; // Default to 'Car (Manual)'
}

function draw() {
  background(240);

  // Draw the grid of emojis
  drawEmojiGrid();

  // Display toggle area on right side
  displayRightSide();

  // Instructions
  fill(0);
  textSize(16);
  textAlign(CENTER);
  text("Click on an emoji to change the vehicle", width / 2, height - 20);
}

function mousePressed() {
  let clickedInGrid = false;

  // Check if clicked in grid to select vehicle
  for (let i = 0; i < gridSize; i++) {
    for (let j = 0; j < gridSize; j++) {
      let x = i * gridWidth;
      let y = j * gridHeight;

      if (mouseX > x && mouseX < x + gridWidth && mouseY > y && mouseY < y + gridHeight) {
        let index = i * gridSize + j;
        if (index < vehicles.length) {
          selectedVehicle = vehicles[index];
          showVehicleInfo = true;  // Show info after selecting
          clickedInGrid = true;
        }
      }
    }
  }

  // Toggle info display if clicked outside grid but on right half of canvas
  if (!clickedInGrid && mouseX > width / 2) {
    showVehicleInfo = !showVehicleInfo;
  }
}

function drawEmojiGrid() {
  for (let i = 0; i < gridSize; i++) {
    for (let j = 0; j < gridSize; j++) {
      let x = i * gridWidth;
      let y = j * gridHeight;

      textSize(48);
      textAlign(CENTER, CENTER);
      let index = i * gridSize + j;
      if (index < vehicles.length) {
        text(vehicles[index].emoji, x + gridWidth / 2, y + gridHeight / 2);
      }
    }
  }
}

function displayRightSide() {
  fill(0);
  textAlign(CENTER, TOP);

  let panelX = width * 0.75;
  let panelY = height * 0.2;

  if (showVehicleInfo && selectedVehicle) {
    // Show emoji
    textSize(64);
    text(selectedVehicle.emoji, panelX, panelY);

    // Show vehicle name
    textSize(24);
    text(selectedVehicle.name, panelX, panelY + 80);

    // Show actions
    textAlign(LEFT, TOP);
    textSize(16);
    let yOffset = panelY + 110;
    for (let i = 0; i < selectedVehicle.actions.length; i++) {
      text(selectedVehicle.actions[i], panelX - 100, yOffset + i * 22);
    }
  } else {
    // Just show "Vehicle"
    textSize(32);
    text("Vehicle", panelX, height / 2);
  }
}
