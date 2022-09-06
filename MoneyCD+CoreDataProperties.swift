//
//  MoneyCD+CoreDataProperties.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 06/09/22.
//
//

import Foundation
import CoreData


extension MoneyCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoneyCD> {
        return NSFetchRequest<MoneyCD>(entityName: "MoneyCD")
    }

    @NSManaged public var availableMoney: Double
    @NSManaged public var totalMoney: Double
    @NSManaged public var id: String?

}

extension MoneyCD : Identifiable {

}
