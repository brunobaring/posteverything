//: Playground - noun: a place where people can play

import UIKit

let abc = "1508463909.70408"
let bca = Double(abc)

var jk = [1,2,3,4,5,6]
var kj = [7,8,9,0,11]
jk.removeLast(2)
jk.append(contentsOf: kj)
print(jk)

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

struct Key {
    struct User {
        static var jabba = "jabba"
    }
}

print(Key.User.jabba is String)

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


