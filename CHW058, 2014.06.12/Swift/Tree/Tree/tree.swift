//
//  tree.swift
//  Tree
//
//  Created by Mikael Konutgan on 12/06/14.
//  Copyright (c) 2014 Mikael Konutgan. All rights reserved.
//

struct Tree<T> {
    struct Node<T> {
        let data: T
        let left: Node<T>?, right: Node<T>?
    }
    
    let root: Node<T>?
}
