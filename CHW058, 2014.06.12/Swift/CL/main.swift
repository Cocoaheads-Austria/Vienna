// xcrun swift main.swift -Ofast -o swiftmain

var array = Array<Double>()

for i in 0..1_000_000 {
    array.append(Double(i) * Double(i))
}

println("\(array.count) iterations")
