//
//  Meme+CoreDataClass.swift
//  MemeMe 2.0
//
//  Created by osmanjan omar on 4/9/17.
//  Copyright © 2017 osmanjan omar. All rights reserved.
//

import Foundation
import CoreData


public class Meme: NSManagedObject {
    convenience init(_ entity: String, inContext context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: entity, in: context) {
            self.init(entity: ent, insertInto: context)
        }
        else {
            fatalError("can not initialize the Meme entity")
        }
    }

}
