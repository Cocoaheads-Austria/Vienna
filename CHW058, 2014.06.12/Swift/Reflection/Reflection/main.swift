//
//  main.swift
//  Reflection
//
//  Created by Mikael Konutgan on 11/06/14.
//  Copyright (c) 2014 Mikael Konutgan. All rights reserved.
//

struct Bookmark {
    let title: String, url: String
}

let bookmark = Bookmark(title: "Cocoaheads Austria", url: "https://cocoaheads.at")

var bookmarkMirror = reflect(bookmark)

func printMirror(mirror: Mirror) {
    for var propertyNumber = 0; propertyNumber < mirror.count; ++propertyNumber {
        let (propertyName, propertyMirror) = mirror[propertyNumber]
        println("\(propertyName) = \(propertyMirror.summary), \(propertyMirror.count) children")
    }
}

printMirror(bookmarkMirror)

class CocoaHead {
    var name: String
    var age: Int
    var homepage: Bookmark?
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let cocoahead = CocoaHead(name: "Mikael", age: 22)
cocoahead.homepage = Bookmark(title: "Mikael Konutgan", url: "http://kmikael.com")

let cocoaheadMirror = reflect(cocoahead)

printMirror(cocoaheadMirror)
