// Emoji Zoom + Access Grid Demo for Python OOP Encapsulation
// Public 🔓 Protected 🛡️ Private 🔐 with Python access code snippets

let emojis = {
  public: "🔓",
  protected: "🛡️",
  private: "🔐"
};

let grid = [
  ["Access Type", "Public 🔓", "Protected 🛡️", "Private 🔐"],
  ["Within Class", "✅", "✅", "✅"],
  ["In Subclass", "✅", "✅", "⚠️"],
  ["Outside Class", "✅", "⚠️", "❌"],
  ["Recommended", "Use freely", "Use in class & subclass", "Use only in class"],
  ["Not Recommended", "-", "Access outside discouraged", "Use name mangling"]
];

let cellW = 180;
let cellH = 80;
let zoomIndex = null;
let zoomProgress = 0;

function setup() {
  createCanvas(960, 600);
  textAlign(CENTER, CENTER);
  textSize(20);
  rectMode(CENTER);
  noStroke();
}

function draw() {
  background("#f5f5f5");

  // Draw grid cells
  for (let r = 0; r < grid.length; r++) {
    for (let c = 0; c < grid[r].length; c++) {
      let x = cellW / 2 + c * cellW;
      let y = cellH / 2 + r * cellH;

      // Highlight header row and special rows
      if (r === 0) fill("#b0c4de");
      else if (r === 4) fill("#d5f4e6");
      else if (r === 5) fill("#fcd5ce");
      else fill(255);

      // Highlight zoomed cell
      if (zoomIndex && zoomIndex.r === r && zoomIndex.c === c) {
        fill("#ffe066");
        push();
        translate(x, y);
        let s = lerp(1, 2.5, zoomProgress);
        scale(s);
        fill(0);
        rect(0, 0, cellW * 0.9, cellH * 0.9, 12);
        fill("#222");
        textSize(40);
        text(grid[r][c], 0, 0);
        pop();
      } else {
        rect(x, y, cellW * 0.9, cellH * 0.9, 10);
        fill(0);
        textSize(20);
        if (r === 0 && c > 0) {
          // Show big emojis for header cells
          textSize(50);
          text(grid[r][c], x, y);
        } else {
          text(grid[r][c], x, y);
        }
      }
    }
  }

  // Animate zoom progress
  if (zoomIndex) {
    zoomProgress += 0.1;
    if (zoomProgress > 1) zoomProgress = 1;
  }

  // Draw Python code snippet panel
  drawPythonSnippet();
}

function mousePressed() {
  // Detect cell clicked
  for (let r = 0; r < grid.length; r++) {
    for (let c = 0; c < grid[r].length; c++) {
      let x = cellW / 2 + c * cellW;
      let y = cellH / 2 + r * cellH;
      if (dist(mouseX, mouseY, x, y) < cellW / 2) {
        if (zoomIndex && zoomIndex.r === r && zoomIndex.c === c) {
          // Clicking zoomed cell closes zoom
          zoomIndex = null;
          zoomProgress = 0;
        } else {
          zoomIndex = {r, c};
          zoomProgress = 0;
        }
      }
    }
  }
}

function drawPythonSnippet() {
  if (!zoomIndex) {
    // Instructions when no zoom
    fill(50);
    textSize(18);
    textAlign(LEFT, TOP);
    text(
      "Click any cell in the grid to see example Python code\nshowing how to access the member type in that scenario.",
      cellW * 4 + 20,
      20,
      width - cellW * 4 - 40,
      height - 40
    );
    return;
  }

  let { r, c } = zoomIndex;
  if (c === 0) return; // No code for first column "Access Type"

  let snippet = getPythonCode(r, c);

  fill("#222");
  rectMode(CORNER);
  fill("#f0f0f0");
  rect(cellW * 4 + 20, 50, width - cellW * 4 - 40, height - 100, 10);

  fill("#111");
  textSize(16);
  textAlign(LEFT, TOP);
  text("Python Access Example:", cellW * 4 + 40, 60);

  fill("#333");
  textSize(14);
  textFont("monospace");
  textLeading(20);
  text(snippet, cellW * 4 + 40, 90, width - cellW * 4 - 60, height - 120);
}

function getPythonCode(row, col) {
  // Rows: 1: Within Class, 2: In Subclass, 3: Outside Class
  // Cols: 1: Public, 2: Protected, 3: Private
  // Return optimized Python snippet strings

  // Helper strings
  const className = "Bank";
  const subclassName = "SavingsBank";
  const instanceName = "bank";

  if (row === 1) { // Within Class
    if (col === 1) {
      return `class ${className}:\n    def __init__(self):\n        self.public_data = "Accessible everywhere"\n    \n    def access(self):\n        print(self.public_data)  # ✅ Allowed inside class`;
    } else if (col === 2) {
      return `class ${className}:\n    def __init__(self):\n        self._protected_data = "Accessible in class & subclass"\n    \n    def access(self):\n        print(self._protected_data)  # ✅ Allowed inside class`;
    } else if (col === 3) {
      return `class ${className}:\n    def __init__(self):\n        self.__private_data = "Only inside class"\n    \n    def access(self):\n        print(self.__private_data)  # ✅ Allowed inside class`;
    }
  }

  if (row === 2) { // In Subclass
    if (col === 1) {
      return `class ${className}:\n    def __init__(self):\n        self.public_data = "Accessible everywhere"\n\nclass ${subclassName}(${className}):\n    def access(self):\n        print(self.public_data)  # ✅ Allowed in subclass`;
    } else if (col === 2) {
      return `class ${className}:\n    def __init__(self):\n        self._protected_data = "Accessible in class & subclass"\n\nclass ${subclassName}(${className}):\n    def access(self):\n        print(self._protected_data)  # ✅ Allowed in subclass`;
    } else if (col === 3) {
      return `class ${className}:\n    def __init__(self):\n        self.__private_data = "Only inside class"\n\nclass ${subclassName}(${className}):\n    def access(self):\n        # print(self.__private_data)  # ⚠️ Not recommended (name mangling)\n        print(self._${className}__private_data)  # Possible but discouraged`;
    }
  }

  if (row === 3) { // Outside Class
    if (col === 1) {
      return `bank = ${className}()\nprint(bank.public_data)  # ✅ Allowed anywhere`;
    } else if (col === 2) {
      return `bank = ${className}()\nprint(bank._protected_data)  # ⚠️ Discouraged (by convention)`;
    } else if (col === 3) {
      return `bank = ${className}()\n# print(bank.__private_data)  # ❌ Error: AttributeError\nprint(bank._${className}__private_data)  # Possible but discouraged`;
    }
  }

  if (row === 4) { // Recommended usage
    if (col === 1) {
      return "# Public members are freely accessible.\n# Use without restrictions.";
    } else if (col === 2) {
      return "# Protected members:\n# Use within class and subclass.\n# Avoid external access.";
    } else if (col === 3) {
      return "# Private members:\n# Use only inside the defining class.\n# Use name mangling to access (discouraged).";
    }
  }

  if (row === 5) { // Not Recommended usage
    if (col === 1) {
      return "-";
    } else if (col === 2) {
      return "# Avoid accessing protected members\n# from outside the class hierarchy.";
    } else if (col === 3) {
      return "# Avoid accessing private members\n# outside the class (use mangling only if necessary).";
    }
  }

  return "";
}
