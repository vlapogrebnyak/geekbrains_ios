import UIKit

enum ShopErrors : Error {
    case NotFound, OutOfStock, NotEnoughtItems
}

class ShopItem {
    var name : String
    var price : Double
    var count : UInt32
    
    init(name: String, price : Double, count : UInt32) {
        self.name = name
        self.price = price
        self.count = count
    }
}

class Shop{
    var items: Array<ShopItem> = [ShopItem(name: "Banana", price: 100.0, count: 1000),
                                  ShopItem(name: "T-shirt", price: 1500.0, count: 40),
                                  ShopItem(name: "Coca-Cola", price: 50.0, count: 2000)]
    
    func getPriceForItem(name : String) -> (Double?, ShopErrors?) {
        let item = findItem(name: name)
        guard item != nil else {
            return (nil, ShopErrors.NotFound)
        }
        return (item!.price, nil)
    }
    
    func findItem(name : String) -> ShopItem? {
        return items.first { (item:ShopItem) -> Bool in
            return item.name == name
        }
    }
    
    func getItemsCount(name : String) -> (UInt32?, ShopErrors?) {
        let item = findItem(name: name)
        guard item != nil else {
            return (nil, ShopErrors.NotFound)
        }
        if item!.count == 0 {
            return (item!.count, ShopErrors.OutOfStock)
        }
        return (item!.count, nil)
    }
    
    func buyItems(name : String, count : UInt32) throws -> ShopItem? {
        if let item = findItem(name: name){
            if item.count == 0{
                throw ShopErrors.OutOfStock
            }
            
            if item.count < count {
                throw ShopErrors.NotEnoughtItems
            }
            
            item.count -= count
            return item
        }
        else {
            throw ShopErrors.NotFound
        }
    }
}

let shop = Shop()

let validItem = shop.getPriceForItem(name: "Banana")
if let price = validItem.0 {
    print("Price for Banana: \(price)")
}
else {
    print(validItem.1!)
}

let notValidCount = shop.getItemsCount(name: "Pepsi")
    
if let count = notValidCount.0 {
    print("Coca-Cola count is:\(count)")
}
else {
    print(notValidCount.1!)
}

do {
    if let item = try shop.buyItems(name: "T-shirt", count: 15){
        print("T-shirts available count:\(item.count)")
    }
    
    if let item = try shop.buyItems(name: "T-shirt", count: 30){
        print("T-shirts available count:\(item.count)")
    }
    
}
catch let error{
    print("Exception occured: \(error)")
}

