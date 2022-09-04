//
//  PotfolioCD+CoreDataProperties.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 04/09/22.
//
//

import Foundation
import CoreData


extension PotfolioCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PotfolioCD> {
        return NSFetchRequest<PotfolioCD>(entityName: "PotfolioCD")
    }

    @NSManaged public var holdingAmount: Double
    @NSManaged public var buyRate: Double
    @NSManaged public var id: UUID?
    @NSManaged public var cryptoid: String?
    @NSManaged public var cryptoCD: CryptoCD?

}

extension PotfolioCD : Identifiable {

}
