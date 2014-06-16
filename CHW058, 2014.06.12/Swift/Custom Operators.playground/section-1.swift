// Custom Operators - Function composition in Swift

operator infix >>> { precedence 140 associativity left }
func >>><T, U, V>(f: T -> U, g: U -> V) -> (T -> V) { return { g(f($0)) } }

operator infix <<< { precedence 140 associativity left }
func <<<<T, U, V>(f: U -> V, g: T -> U) -> (T -> V) { return g >>> f }

func id<T>(x: T) -> T { return x }

operator infix |> { precedence 150 associativity left }
func |><T, U>(x: T, f: T -> U) -> U { return f(x) }

operator infix <| { precedence 150 associativity left }
func <|<T, U>(f: T -> U, x: T) -> U { return x |> f }

// Examples

let square: Int -> Int = { $0 * $0 }
let double: Int -> Int = { $0 * 2 }

square(countElements([1, 2, 3])) == (countElements >>> square)([1, 2, 3])

square(double(5)) == (square <<< double)(5)
double(square(5)) == (square >>> double)(5)

5 |> (square >>> double)
5 |> square |> double

// Partial Application
func curry<T, U, V>(f: (T, U) -> V, x: U) -> (T -> V) {
    return { f($0, x) }
}

let add: (Int, Int) -> Int = { $0 + $1 }
let sub: (Int, Int) -> Int = { $0 - $1 }

let array = [1, 2, 3, 4, 5]
    
array |> countElements |> curry(add, 5) |> square |> curry(sub, 5)
