//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func applyMutliplication(value: Int, multFunction: (Int) -> Int) -> Int {
    print("1")
    print("value1", multFunction(value))
    print("value1", multFunction(value))
    return 3
}

let a = applyMutliplication(value: 2, multFunction: {value in
    print("value2", value * 3)
    return value * 3
})
print(a)


print("aaaaaaaa")



func test(comp: (Int) -> Int)
{
    print("a")
    print(comp(2))
    comp(2)
}


test { (int) -> Int in
    print(int + 2)
    return int + 1
}

