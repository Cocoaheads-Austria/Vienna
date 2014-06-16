// Compile with: `swift split.swift` and run with: `./main`,
// or run directly with `swift -i split.swift`

extension String {
    func split(separator: Character) -> Array<String> {
        var result = Array<String>()
        var str = ""
        
        for character in self {
            if separator == character {
                result.append(str)
                str = ""
            } else {
                str += character
            }
        }
        
        result.append(str)
        
        return result
    }
}

let argc = Int(C_ARGC)
let argv = Array<String>(count: argc, repeatedValue: "")

for i in 0..argc {
    argv[i] = String.fromCString(C_ARGV[i])
}

if argv.count > 0 {
    let components = argv[1].split(" ")
    
    for obj in components {
        println(obj)
    }
}
