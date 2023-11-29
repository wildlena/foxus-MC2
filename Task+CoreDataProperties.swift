//
//  Task+CoreDataProperties.swift
//  foxus-MC2
//
//  Created by AlJawharh AlOtaibi on 14/05/1445 AH.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var priority: String?
    @NSManaged public var time: Int32

}

extension Task : Identifiable {

}
