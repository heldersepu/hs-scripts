const types = ["capped", "uncapped"]
const contracts = {
    collection: {
        capped: "CappedCollection",
        uncapped: "UncappedCollection"
    }
}

function test(type) {
    console.log((types.includes(type))? "yes": "no")
    console.log((contracts.collection[type])? "yes": "no")
}

test("capped")
test("uncapped")
test("bad")
