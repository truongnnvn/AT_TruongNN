//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func check(num: Int) -> Bool {
    for i in 1...Int(sqrt(Double(num))) {
        if (i * i == num) {
            return true
        }
    }
    return false
}

func scp() -> (scpdt: [Int], scpnh100: [Int]) {
    var scpdt = [Int]()
    var scpnh100 = [Int]()
    var i = 1
    
    while (scpdt.count < 100) {
        if check(i) {
            scpdt.append(i)
        }
        i = i + 1
    }
    for j in 1..<100 {
        if check(j) {
            scpnh100.append(j)
        }
    }
    return (scpdt, scpnh100)
}
let s = scp()
print(s.scpdt)
print(s.scpnh100)