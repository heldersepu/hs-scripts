const fs = require('fs/promises');
async function test() {
  let x = await fs.readFile("1x1-0000ff7f.png", { encoding: "base64" });
  console.log(x);
}
test().then();
