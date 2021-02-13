import UIKit

var amount = 10.00

switch amount {
case 1...10.0:
    print("green")
case 10.1...100.0:
print("yelllow")
default:
    print("red")
}
