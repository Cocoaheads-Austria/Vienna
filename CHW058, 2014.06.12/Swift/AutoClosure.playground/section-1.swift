// Playground - noun: a place where people can play

// Operators are made up of one or more of the following characters:
// /, =, -, +, !, *, %, <, >, &, |, ^, ~, and .. 
// That said, the tokens =, ->, //, /*, */, ., and
// the unary prefix operator & are reserved.
// These tokens can’t be overloaded,
// nor can they be used to define custom operators.

operator infix ||| { associativity left precedence 140 }

func |||<T>(lhs: @auto_closure () -> T?, rhs: @auto_closure () -> T) -> T {
    if let l = lhs() {
        return l
    } else {
        return rhs()
    }
}

func fetchRecordWithId(id: Int) -> String? {
    
    println("Fetch the record with id = \(id)")
    
    if id > 42 {
        return "An awesome record"
    } else {
        return nil
    }
}

let record = fetchRecordWithId(34) ||| fetchRecordWithId(47)
// Output:
// Fetch the record with id = 34
// Fetch the record with id = 47


let otherRecord = fetchRecordWithId(72) ||| fetchRecordWithId(17)
// Output:
// Fetch the record with id = 72

// The alternative
let someRecord = fetchRecordWithId(72) ? fetchRecordWithId(72) : fetchRecordWithId(17)

func myIf<T>(condition: Bool, #then: @auto_closure () -> T, #els: @auto_closure () -> T) -> T {
    if condition {
        return then()
    } else {
        return els()
    }
}

func printlnAndReturn(string: String) -> String {
    println(string)
    
    return string
}

let x: String = myIf(1 == 0, then: printlnAndReturn("TRUE"), els: printlnAndReturn("FALSE"))
