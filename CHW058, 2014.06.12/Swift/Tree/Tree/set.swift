//
//  tree.swift
//  Tree
//
//  Created by Mikael Konutgan on 12/06/14.
//  Copyright (c) 2014 Mikael Konutgan. All rights reserved.
//

struct Set<T: Hashable>: Equatable {
    var elements = Dictionary<T, Bool>()
    
    var count: Int {
        return elements.count
    }
    
    init(_ elements: T...) {
        self.init(elements)
    }
    
    init(_ elements: T[]) {
        for element in elements {
            add(element)
        }
    }
    
    mutating func add(element: T) -> () {
        elements[element] = true
    }
    
    mutating func delete(element: T) {
        elements.removeValueForKey(element)
    }
    
    mutating func clear() {
        elements.removeAll()
    }
    
    func each(block: T -> ()) {
        for (key, value) in elements {
            block(key)
        }
    }
    
    func inlude(element: T) -> Bool {
        if elements[element] {
            return true
        } else {
            return false
        }
    }
    
    func map(block: T -> T) -> Set<T> {
        
        var set = Set()
        
        for (key, value) in elements {
            set.add(block(key))
        }
        
        return set
    }
}

func ==<T>(set: Set<T>, other: Set<T>) -> Bool {
    return set.elements == other.elements
}

extension Set {
    func toArray() -> Array<T> {
        var array = Array<T>()
        
        for (element, _) in self.elements {
            array.append(element)
        }
        
        return array
    }
}

struct SetGenerator<T>: Generator {
    
    var elements: Slice<T>
    
    mutating func next() -> T? {
        if elements.isEmpty {
            return nil
        }
        
        let element = elements[elements.startIndex]
        elements = elements[(elements.startIndex + 1)..elements.count]
        
        return element
    }
}

extension Set: Sequence {
    func generate() -> SetGenerator<T> {
        let array = toArray()
        return SetGenerator(elements: array[0..array.count])
    }
}

extension Set: ArrayLiteralConvertible {
    static func convertFromArrayLiteral(elements: T...) -> Set<T> {
        return Set(elements)
    }
}














