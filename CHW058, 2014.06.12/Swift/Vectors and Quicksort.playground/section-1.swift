// Vectors and Quicksort

// Using tuples for multiple return values, can also be named
func partition<T : Comparable>(array: T[], element: T) -> (T[], T[], T[]) {
    var left = T[](), mid = T[](), right = T[]()
    
    for e in array {
        if (e < element) { left.append(e) }
        else if (e == element) { mid.append(e) }
        else { right.append(e) }
    }
    
    return (left, mid, right)
}

func quicksort<T: Comparable>(var array: T[]) -> T[] {
    if array.count <= 1 {
        return array
    }
    
    let (left, mid, right) = partition(array, array[0])
    
    return quicksort(left) + mid + quicksort(right)
}

let arrayOfInt: Int[] = [
    1, -5, 9, 8, 110, 42, -70, 0, 3, 4, 5, 2, 2, 1, 0, 1, -42, -13, 13
]

let sortedArrayOfInt = quicksort(arrayOfInt)

// A custom struct
struct Vector: Comparable {
    let x: Double = 0.0, y: Double = 0.0
}

// Adopt protocols in extension
extension Vector: Printable {
    var description: String {
        return "(\(x), \(y))"
    }
}

// Also keep the default initializer
extension Vector {
    init(_ x: Double, _ y: Double) {
        self.init(x: x, y: y)
    }
}

// Adopt Comparable
func ==(p: Vector, q: Vector) -> Bool {
    return p.x == q.x && p.y == q.y
}

// Which requires Equatable
func <(p: Vector, q: Vector) -> Bool {
    return p.x < q.x && p.y < q.y
}

let vectors = [
    Vector(1.0, 2.0),
    Vector(0.0, 1.0),
    Vector(x: -3.0, y: -2.0)
]

let sortedVectors = quicksort(vectors)
