import UIKit

enum EngineState {
    case stopped, started
}

enum EngineOperation {
    case start, stop
}

enum WindowState {
    case closed, openned
}

enum WindowOperation {
    case open, close
}

protocol EngineStateChangable {
    var engineState : EngineState { get set }
    
    func applyOperation(operation : EngineOperation)
}

protocol WindowStateChangable {
    var windowState : WindowState { get set }
    
    func applyOperation(operation : WindowOperation)
}

protocol Car {
    
    var carBrand : String { get set }
    var engineStateChangable : EngineStateChangable { get }
    var windowStateChangable : WindowStateChangable { get }
    func drive()
    
}

extension Car {
    func drive() {
        print("Driving car:\(self.carBrand)")
    }
    
}

class Engine : EngineStateChangable {
    var engineState: EngineState = .stopped
    
    init() {
        
    }
    
    func applyOperation(operation: EngineOperation) {
        switch operation {
        case .start:
            self.engineState = .started
        case .stop:
            self.engineState = .stopped
        }
    }
}

class CarWindow : WindowStateChangable {
    var windowState: WindowState = .closed
    
    init() {
    }
    
    func applyOperation(operation: WindowOperation) {
        switch operation {
        case .close:
            self.windowState = .closed
        case .open:
            self.windowState = .openned
        }
    }
}

extension Engine : CustomStringConvertible {
    var description : String {
        return "Engine state:\(self.engineState)\n"
    }
}

extension CarWindow : CustomStringConvertible {
    var description : String {
        return "Car windows state:\(self.windowState)\n"
    }
}

class BaseCar : Car {
    
    var carBrand: String
    
    var engineStateChangable: EngineStateChangable
    
    var windowStateChangable: WindowStateChangable
    
    init(carBrand : String) {
        self.carBrand = carBrand
        self.engineStateChangable = Engine()
        self.windowStateChangable = CarWindow()
    }
}


class SportCar : BaseCar {

    var convertible : Bool // откидная крыша
    
    init(carBrand : String, convertible : Bool) {
        self.convertible = convertible
        super.init(carBrand: carBrand)
    }
}

enum TankTruckShape {
    case Cylindrical, Conical, Rectangle // форма цистерны
}

class TrunkCar : BaseCar {
    var tankTruckShape: TankTruckShape
    
    init(carBrand : String, tankTruckShape : TankTruckShape) {
        self.tankTruckShape = tankTruckShape
        super.init(carBrand: carBrand)
    }
}


extension SportCar : CustomStringConvertible {
    var description: String {
        return "\(self.carBrand) has convertible roof :\(self.convertible); Engine state:\(self.engineStateChangable.engineState); Car windows state: \(self.windowStateChangable.windowState)"
    }
}

extension TrunkCar : CustomStringConvertible {
    var description: String {
        return "\(self.carBrand) has tank truck shape:\(self.tankTruckShape); Engine state:\(self.engineStateChangable.engineState); Car windows state: \(self.windowStateChangable.windowState)"
    }
}

var ferrari = SportCar(carBrand: "Ferrari F50", convertible: true)
var bugatti = SportCar(carBrand: "Bugatti Veyron", convertible: false)
var kamaz = TrunkCar(carBrand: "KAMAZ", tankTruckShape: .Rectangle)
var man = TrunkCar(carBrand: "MAN", tankTruckShape: .Cylindrical)

let cars : [Car] = [ferrari, bugatti, kamaz, man]

func testCar(car : Car){
    car.engineStateChangable.applyOperation(operation: .start)
    car.windowStateChangable.applyOperation(operation: .open)
    print(car)
    car.drive()
    car.windowStateChangable.applyOperation(operation: .close)
    car.engineStateChangable.applyOperation(operation: .stop)
    print(car)
}

for car in cars {
    testCar(car: car)
}
