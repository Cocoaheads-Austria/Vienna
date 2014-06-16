// A Fibonacci Generator

func fibonacciGenerator() -> () -> Int {
    var x = 0, y = 1
    return {
        (x, y) = (y, x + y)
        return y
    }
}

let next = fibonacciGenerator()

next()
next()
next()
next()
next()
next()
next()
next()
next()
next()
next()
next()

while next() < Int.max / 2 {
    continue
}

next()
