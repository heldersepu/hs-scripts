let canvas = document.getElementById("gameScreen");
let ctx = canvas.getContext("2d")

let width = 50
let margin = 5

for (var row = 0; row < 10; row++) {
  for (var column = 0; column < 10; column++) {
    ctx.fillRect(column * (width + margin), row * (width + margin), width, width)
  }
}