function foo() {
    console.log(arguments.callee.name);
}

const aa = {
    bb: {
        cc() {
            console.log(arguments.callee.name);
        }
    }
}

foo()
aa.bb.cc()
