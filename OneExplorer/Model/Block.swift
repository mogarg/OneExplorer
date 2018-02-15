//
//  Block.swift
//  OneExplorer
//
//  Created by Mohit Garg on 2/14/18.
//  Copyright © 2018 Mohit Garg. All rights reserved.
//

import Foundation

class Block: CustomStringConvertible{
    
    let id: String
    let number: Int
    let previous: String
    let timeStamp: Date
    let producer: String
    let signature: String
    let prefix: Int
    
    init(id:String, number:Int, previous:String, timeStamp:Date, producer:String, signature:String,  prefix:Int) {
        self.id = id
        self.number = number
        self.previous = previous
        self.timeStamp = timeStamp
        self.producer = producer
        self.signature = signature
        self.prefix = prefix
    }
    
    var description: String {
        return "(Block: \(id), \(number), \(previous), \(timeStamp), \(producer), \(signature), \(prefix))"
    }
}
