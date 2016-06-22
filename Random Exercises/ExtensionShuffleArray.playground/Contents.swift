//: Playground - noun: a place where people can play

import UIKit

extension MutableCollectionType where Index == Int {
    mutating func randomArray() {
        if count < 2 {
            return
        }
        for i in 0...count {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
var abc = [1, 2, 3, 4, 5, 6, 7, 8, 9]
abc.randomArray()