import UIKit

enum EngineState {
    case stopped, started
}

enum WindowsState {
    case closed, opened
}

enum TrunkState {
    case empty,not_empty, full
}

enum EngineOperation {
    case start, stop
}

enum WindowOperation {
    case open, close
}

enum TrunkOperation {
    case add, remove
}

struct CarInfo {
    let carBrand : String
    let year : UInt16
    
    init(carBrand : String, year : UInt16) {
        self.carBrand = carBrand
        self.year = year
    }
}

struct Engine {
    var engineState : EngineState
    
    mutating func changeState(operation : EngineOperation) {
        switch operation {
        case .start:
            self.engineState = .started
        case .stop:
            self.engineState = .stopped
        }
    }
}


struct Windows {
    var windowState : WindowsState
    
    mutating func changeState(operation : WindowOperation) {
        switch operation {
        case .open:
            self.windowState = .opened
        case .close:
            self.windowState = .closed
        }
    }
}

struct Trunk {
    var trunkState : TrunkState
    let maximumTrunkCapacity : Double
    var trunkSpaceAvailable : Double
    
    init(maximumCapacity : Double) {
        self.maximumTrunkCapacity = maximumCapacity
        self.trunkSpaceAvailable = maximumCapacity
        self.trunkState = .empty
    }

    mutating func changeState(amount : Double, operation : TrunkOperation) {
        switch operation {
        case .add:
            self.trunkSpaceAvailable = max(self.trunkSpaceAvailable - amount, 0.0)
        case .remove:
            self.trunkSpaceAvailable = min(self.trunkSpaceAvailable + amount, self.maximumTrunkCapacity)
        }
        
        switch self.trunkSpaceAvailable {
        case 0.0:
            self.trunkState = .full
        case self.maximumTrunkCapacity:
            self.trunkState = .empty
        default:
            self.trunkState = .not_empty
        }
        
    }
}

enum CarType {
    case sport, trunc
}

struct BaseCar {
    let carInfo : CarInfo
    var windows : Windows
    var engine : Engine
    var trunk : Trunk
   
    init(carBrand : String, year : UInt16, maximumTrunkCapacity : Double) {
        carInfo = CarInfo(carBrand: carBrand, year: year)
        windows = Windows(windowState: .closed)
        engine = Engine(engineState: .stopped)
        trunk = Trunk(maximumCapacity: maximumTrunkCapacity)
    }
    
    mutating func makeOperationWithWindow(operation : WindowOperation) {
        windows.changeState(operation: operation)
    }
    
    mutating func makeOperationWithEngine(operation : EngineOperation) {
        engine.changeState(operation: operation)
    }
   
    
    mutating func makeOperationWithTrunk(amount : Double, operation : TrunkOperation) {
        trunk.changeState(amount: amount, operation: operation)
    }
    
}

struct SportCar {
    
    let type : CarType = .sport
    var carBase : BaseCar
    
    init(carBrand : String, year : UInt16, maximumTrunkCapacity : Double) {
        carBase = BaseCar(carBrand: carBrand, year: year, maximumTrunkCapacity: maximumTrunkCapacity)
    }
}


struct TruncCar  {
    let type : CarType = .trunc
    var carBase : BaseCar
    
    init(carBrand : String, year : UInt16, maximumTrunkCapacity : Double) {
        carBase = BaseCar(carBrand: carBrand, year: year, maximumTrunkCapacity: maximumTrunkCapacity)
    }
}


var ferrari = SportCar(carBrand: "Ferrari", year: 2008, maximumTrunkCapacity: 80.0)
var tesla = SportCar(carBrand: "Tesla", year: 2020, maximumTrunkCapacity: 450.0)

var kamaz = TruncCar(carBrand: "KAMAZ", year: 2001, maximumTrunkCapacity: 20000.0)
var man = TruncCar(carBrand: "MAN", year: 2015, maximumTrunkCapacity: 20000.0)


func startEngine(baseCar : inout BaseCar) {
    baseCar.makeOperationWithEngine(operation: .start)
}

func stopEngine(baseCar : inout BaseCar) {
    baseCar.makeOperationWithEngine(operation: .stop)
}

func openWindows(baseCar : inout BaseCar) {
    baseCar.makeOperationWithWindow(operation: .open)
}

func closeWindows(baseCar : inout BaseCar) {
    baseCar.makeOperationWithWindow(operation: .close)
}

func addToTrunk(baseCar : inout BaseCar, amount : Double) {
    baseCar.makeOperationWithTrunk(amount: amount, operation: .add)
}

func removeFromTrunk(baseCar : inout BaseCar, amount : Double) {
    baseCar.makeOperationWithTrunk(amount: amount, operation: .remove)
}

startEngine(baseCar: &ferrari.carBase)
startEngine(baseCar: &kamaz.carBase)

print("\(ferrari.carBase.carInfo.carBrand) engine state is : \(ferrari.carBase.engine.engineState)")
print("\(kamaz.carBase.carInfo.carBrand) engine state is : \(kamaz.carBase.engine.engineState)")

openWindows(baseCar: &ferrari.carBase)
openWindows(baseCar: &tesla.carBase)

print("\(ferrari.carBase.carInfo.carBrand) windows state is : \(ferrari.carBase.windows.windowState)")
print("\(tesla.carBase.carInfo.carBrand) windows state is : \(tesla.carBase.windows.windowState)")

addToTrunk(baseCar: &tesla.carBase, amount: 300.0)
addToTrunk(baseCar: &man.carBase, amount: 15000.0)
addToTrunk(baseCar: &ferrari.carBase, amount: 100.0)

print("\(tesla.carBase.carInfo.carBrand) available space in trunk : \(tesla.carBase.trunk.trunkSpaceAvailable), trunk state is \(tesla.carBase.trunk.trunkState)")

print("\(ferrari.carBase.carInfo.carBrand) available space in trunk : \(ferrari.carBase.trunk.trunkSpaceAvailable), trunk state is \(ferrari.carBase.trunk.trunkState)")

print("\(kamaz.carBase.carInfo.carBrand) available space in trunk : \(kamaz.carBase.trunk.trunkSpaceAvailable), trunk state is \(kamaz.carBase.trunk.trunkState)")

print("\(man.carBase.carInfo.carBrand) available space in trunk : \(man.carBase.trunk.trunkSpaceAvailable), trunk state is \(man.carBase.trunk.trunkState)")


stopEngine(baseCar: &ferrari.carBase)
stopEngine(baseCar: &kamaz.carBase)

print("\(ferrari.carBase.carInfo.carBrand) engine state is : \(ferrari.carBase.engine.engineState)")
print("\(kamaz.carBase.carInfo.carBrand) engine state is : \(kamaz.carBase.engine.engineState)")
