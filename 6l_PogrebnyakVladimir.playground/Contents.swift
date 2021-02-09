import UIKit

struct Queue<T>  {
    
    private var elements : [T] = []
    
    mutating func push(_ element : T) {
        self.elements.insert(element, at: 0)
    }
    
    mutating func pop_front() -> T? {
        return !self.empty() ? self.elements.removeFirst() : nil
    }
    
    func empty() -> Bool {
        return self.count() == 0
    }
    
    func count() -> Int {
        return self.elements.count
    }
    
    func filter(predicate : (T) -> Bool) -> [T] {
        return self.elements.filter(predicate)
    }
    
    subscript(index : Int) -> T? {
        if self.empty() || index >= self.count() {
            return nil
        }
        let count = self.count()
        var newIndex = index
        if index < 0 {
            newIndex = count + index
        }
        if newIndex < 0 {
            return nil
        }
        
        return self.elements[newIndex]
    }
    
}

var testQueue : Queue<Int> = Queue<Int>()

for i in 1...15 {
    testQueue.push(i)
}
print(testQueue)

let result = testQueue.filter{
    return $0 % 2 == 0
}

print(result)

print(testQueue[-1]!)
print(testQueue[-5]!)
print(testQueue[0]!)
print(testQueue[1]!)


while(!testQueue.empty()) {
    testQueue.pop_front()
}

print(testQueue)
