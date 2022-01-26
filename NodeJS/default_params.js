function test(a, b, c = "c", d = "d") {
    console.log(a, b, c, d)
}

test("aa", "bb", "cc")
test("aa", "bb", d="ddd")
test("aa", "bb", d="ddd")
test(...[,,,], "ddd")