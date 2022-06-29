const COMMANDS = {
    "ido": "fantom",
    "eth": "ethereum",
    "one": "two"
}

var txt = "nneth bla"
let command = (ix = -1)
for (command in COMMANDS) {
    if ((ix = txt.indexOf((command))) >= 0) break
}
console.log(ix, command, COMMANDS[command])