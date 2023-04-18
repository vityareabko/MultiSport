//
//  Test2+CoreDataProperties.swift
//  MultiSport
//
//  Created by Витя Рябко on 18/04/23.
//
//

import Foundation
import CoreData


extension Test2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Test2> {
        return NSFetchRequest<Test2>(entityName: "Test2")
    }

    @NSManaged public var name: String?

}

extension Test2 : Identifiable {

}
