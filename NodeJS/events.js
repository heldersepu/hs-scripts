const EventEmitter = require('events');
const eventEmitter = new EventEmitter();

eventEmitter.on('sum',  (a, b) => {
    console.log(a+b)
})

eventEmitter.emit('sum',5 ,3);

class Car extends EventEmitter {
    constructor(make) {
        super();
        this._make = make;

        this.on('honk', () =>{
            console.log("beep beep");
        });
    }

    get make() {
        return this._make;
    }

    get wheels() {
        return 4;
    }
}

const myCar = new Car("Jeep");
myCar.emit('honk');