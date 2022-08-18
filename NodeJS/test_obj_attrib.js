const types = ["capped", "uncapped", "test"]
const contracts = {
    collection: {
        capped: "CappedCollection",
        uncapped: "UncappedCollection",
        test: null
    }
}

function test(type) {
    console.log((types.includes(type))? "yes": "no")
    console.log((contracts.collection[type])? "yes": "no")
    console.log("")
}

test("capped")
test("uncapped")
test("bad")
test("test")
