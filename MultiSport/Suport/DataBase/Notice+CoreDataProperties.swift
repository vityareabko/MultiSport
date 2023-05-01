//
//  Notice+CoreDataProperties.swift
//  MultiSport
//
//  Created by Витя Рябко on 29/04/23.
//
//

import Foundation
import CoreData


extension Notice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notice> {
        return NSFetchRequest<Notice>(entityName: "Notice")
    }

    @NSManaged public var idUser: Int64
    @NSManaged public var noticebody: String?
    @NSManaged public var noticetitle: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?

}

extension Notice : Identifiable {

}
