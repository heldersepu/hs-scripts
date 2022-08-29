class A {
    constructor(a) {
        this.x = "xx" + a
    }
}

class B extends A {
    constructor() {
        super("y")
    }
}

const instance = new B()
console.log(instance.x)