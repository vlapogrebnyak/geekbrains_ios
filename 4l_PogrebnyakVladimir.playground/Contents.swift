import UIKit

enum EngineState {
    case stopped, started
}

enum EngineOperation {
    case start, stop
}

enum WeatherType {
    case sunny, rainy
}
class WeatherForecaster {
    static func getForecast() -> WeatherType {
        let rand = arc4random_uniform(2)
        return rand == 0 ? .sunny : .rainy
    }
}

class Car {
    let maximumSpeed: Double
    let modelName: String
    let trunkMaximumCapacity: Double
    var engineState : EngineState = .stopped
    
    init(modelName : String, maximumSpeed : Double, trunkMaximumCapacity : Double ){
        self.maximumSpeed = maximumSpeed
        self.modelName = modelName
        self.trunkMaximumCapacity = trunkMaximumCapacity
    }
    
    func prepareToDrive(){
        print("Preparation finished! Ready to drive!")
    }
    
    func operateEngine(engineOperation : EngineOperation) {
        self.engineState = engineOperation == EngineOperation.start ? .started : .stopped
    }
}


class SportCar : Car {
    
    var hasHingedRoof : Bool
    
    init(modelName : String, maximumSpeed : Double, trunkMaximumCapacity : Double, hasHingedRoof : Bool ){
        self.hasHingedRoof = hasHingedRoof
        super.init(modelName: modelName, maximumSpeed: maximumSpeed, trunkMaximumCapacity: trunkMaximumCapacity)
    }
    
    override func prepareToDrive() {
        print("Prepare to drive a car:\(self.modelName)")
        checkRoof()
        super.prepareToDrive()
    }
    
    private func checkRoof() {
        switch WeatherForecaster.getForecast() {
        case .sunny:
            print("It's sunny! Time to open the roof!")
        case.rainy:
            print("It's rainy! We should close the roof!")
        }
    }
}

class TruncCar : Car {
    
    var hasTrailer : Bool
    
    init(modelName : String, maximumSpeed : Double, trunkMaximumCapacity : Double, hasTrailer : Bool ){
        self.hasTrailer = hasTrailer
        super.init(modelName: modelName, maximumSpeed: maximumSpeed, trunkMaximumCapacity: trunkMaximumCapacity)
    }
    
    override func prepareToDrive() {
        print("Prepare to drive a car:\(self.modelName)")
        checkTrailer()
        super.prepareToDrive()
    }
    
    func checkTrailer() {
        print("Checking Trunc trailer")
        if (self.hasTrailer) {
            print("Trunc contains trailer!")
        }
        else {
            print("Trunc has no trailer!")
        }
    }
}

let sportCar = SportCar(modelName: "Ferrari", maximumSpeed: 350.0, trunkMaximumCapacity: 100.0, hasHingedRoof: true)
let truncCar = TruncCar(modelName: "Kamaz", maximumSpeed: 120.0, trunkMaximumCapacity: 20000.0, hasTrailer: true)

sportCar.prepareToDrive()
truncCar.prepareToDrive()

func startEngine( car : Car ) {
    car.operateEngine(engineOperation: .start)
    print("\(car.modelName) is \(car.engineState)")
}

func stopEngine( car : Car ) {
    car.operateEngine(engineOperation: .stop)
    print("\(car.modelName) is \(car.engineState)")
}

startEngine(car: sportCar)
startEngine(car: truncCar)

stopEngine(car: sportCar)
stopEngine(car: truncCar)

