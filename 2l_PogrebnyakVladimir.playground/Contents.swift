import UIKit

// 1) Написать функцию, которая определяет, четное число или нет.
func isEven( number : Int ) -> Bool {
    return number % 2 == 0
}

var testNums : [Int] = [99, 120, 100, 451, 18998]

for testNum in testNums {
    print("Number \(testNum) is even: \(isEven(number: testNum))")
}

// 2)  Написать функцию, которая определяет, делится ли число без остатка на 3.

func isDevidedBy3( number : Int ) -> Bool {
    return number % 3 == 0
}

testNums = [99, 120, 321, 451, 999]

for testNum in testNums {
    print("Number \(testNum) is devided by 3: \(isDevidedBy3(number: testNum))")
}

// 3) Создать возрастающий массив из 100 чисел.

var testArray : Array<Int> = Array(0...99)

print("Created array:", testArray)

// 4) Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

func numberIsEvenOrNotDevidedByTree( number : Int ) -> Bool {
    return isEven(number: number) || !isDevidedBy3(number: number)
}


testArray.removeAll { (num: Int) -> Bool in
    return numberIsEvenOrNotDevidedByTree(number: num)
}

print("Modified array: ", testArray)

// 5) Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов

func finonacci(numberIndex_1 : Decimal, numberIndex_2 : Decimal) -> Decimal {
    return numberIndex_1 + numberIndex_2
}

func addFibonacciNumberToArray( array : inout [Decimal], numberIndex : Int )
{
    if numberIndex < 2 {
        array.append(1)
    }
    else {
        //let maxNum : UInt64 = 18446744073709551615;
        let nextNumber = finonacci(numberIndex_1: array[numberIndex - 1], numberIndex_2: array[numberIndex - 2])
        //print(numberIndex, maxNum - nextNumber)
        array.append(nextNumber)
    }
}
var fibonacciArray : [Decimal] = []
for i in 0...99{
    addFibonacciNumberToArray(array: &fibonacciArray, numberIndex: i)
}

for (index,fibNum) in fibonacciArray.enumerated() {
    print("Fibonacci \(index) number is:\(fibNum)")
}


