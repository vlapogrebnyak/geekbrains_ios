import UIKit

// Solving Square equation a * x^2 + b * x + c = 0
let a : Float = 1.0
let b : Float =  -70.0
let c : Float = 600.0

let D : Float = b * b - 4 * a * c
if D > 0.0 {
    let x1 = ( -b +  sqrt( D ) )/( 2 * a )
    let x2 = ( -b -  sqrt( D ) )/( 2 * a )
    print( "x1 = ", x1 )
    print( "x2 = ", x2 )
    
}
else if D == 0.0{
    let x = ( -b )/( 2 * a )
    print( "x1 = x2 = ", x )
}
else {
    print("The equation has no real roots")
}

// Right triangle calculation

let A : Float = 3.0
let B : Float = 4.0

let C : Float = sqrt( A * A + B * B )

let S : Float = 0.5 * A * B

let P : Float = A + B + C


print( "Hypotenuse =  ", C )
print( "Area = ", S )
print( "Perimetr = ", P )


// Bank deposit calculation

let input_amount : Double = 1000000.0
let year_persentage : Double = 5.0

let years : Int = 5

var output_amount : Double = input_amount

for _ in 1...years {
    output_amount += output_amount * year_persentage / 100.0
}

print("Bank will return \(output_amount) after \(years) years")

