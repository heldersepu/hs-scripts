var out = "";
for (var i = 0; i < input.length; i++) {
  if (i % 2 == 0) {
    out += input[i].toUpperCase();
  } else {
    out += input[i].toLowerCase();
  }
}
out;
