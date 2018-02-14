//
//  Block.swift
//  OneExplorer
//
//  Created by Mohit Garg on 2/14/18.
//  Copyright © 2018 Mohit Garg. All rights reserved.
//

import Foundation

class Block: NSObject {
    
    let previous: NSString?
    
    let timeStamp: NSDate?
    
    let producer: NSString?
    
    let signature: NSString?
    
    let id: NSString?
    
    let number: NSInteger?
    
    let prefix: NSInteger?
    
    init(previous:NSString, timeStamp:NSDate, producer:NSString, signature:NSString, id:NSString, number:NSInteger, prefix:NSInteger) {
        
        self.previous = previous
        self.timeStamp = timeStamp
        self.producer = producer
        self.signature = signature
        self.id = id
        self.number = number
        self.prefix = prefix
    }
}
