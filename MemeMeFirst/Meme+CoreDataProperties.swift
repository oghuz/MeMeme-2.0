//
//  Meme+CoreDataProperties.swift
//  MemeMe 2.0
//
//  Created by osmanjan omar on 4/9/17.
//  Copyright © 2017 osmanjan omar. All rights reserved.
//

import Foundation
import CoreData


extension Meme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meme> {
        return NSFetchRequest<Meme>(entityName: "Meme")
    }

    @NSManaged public var meme: NSData?
    @NSManaged public var originalImage: NSData?
    @NSManaged public var topText: String?
    @NSManaged public var buttomText: String?

}
