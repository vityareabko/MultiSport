//
//  Test+CoreDataProperties.swift
//  MultiSport
//
//  Created by Витя Рябко on 18/04/23.
//
//

import Foundation
import CoreData


extension Test {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Test> {
        return NSFetchRequest<Test>(entityName: "Test")
    }

    @NSManaged public var test121: String?

}

extension Test : Identifiable {

}
