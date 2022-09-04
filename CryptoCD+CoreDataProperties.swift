//
//  CryptoCD+CoreDataProperties.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 04/09/22.
//
//

import Foundation
import CoreData


extension CryptoCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CryptoCD> {
        return NSFetchRequest<CryptoCD>(entityName: "CryptoCD")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var name: String?
    @NSManaged public var currentPrice: Double
    @NSManaged public var high24H: Double
    @NSManaged public var low24H: Double
    @NSManaged public var idCrypto: String?
    @NSManaged public var priceChangePersent24H: Double
    @NSManaged public var image: String?
    @NSManaged public var id: UUID?
    @NSManaged public var history: NSSet?
    @NSManaged public var potfolio: NSSet?

}

// MARK: Generated accessors for history
extension CryptoCD {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: HistoryCD)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: HistoryCD)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}

// MARK: Generated accessors for potfolio
extension CryptoCD {

    @objc(addPotfolioObject:)
    @NSManaged public func addToPotfolio(_ value: PotfolioCD)

    @objc(removePotfolioObject:)
    @NSManaged public func removeFromPotfolio(_ value: PotfolioCD)

    @objc(addPotfolio:)
    @NSManaged public func addToPotfolio(_ values: NSSet)

    @objc(removePotfolio:)
    @NSManaged public func removeFromPotfolio(_ values: NSSet)

}

extension CryptoCD : Identifiable {

}
