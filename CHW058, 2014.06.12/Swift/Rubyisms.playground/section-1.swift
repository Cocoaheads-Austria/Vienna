// Ruby methods

extension Int {
    func times(block: Int -> ()) {
        for i in 0..self {
            block(i)
        }
    }
}


10.times { println("\($0) - Awesome!") }

extension Array {
    func each(block: T -> ()) {
        for object in self {
            block(object as T)
        }
    }
}

["hello", "world"].each { element in
    println(element)
}

// Trailing closure syntax + shorthand syntax!

let array = [1, 2, 3, 4]

array.map({ element in element * element })
array.map { element in element * element }
array.map { e in e * e }
array.map { $0 * $0 }

find(array, 5)
find(array, 4)

array.filter { $0 > 2 }

filter(array, { $0 > 2})

let total = array.reduce(0, combine: +)
total




























