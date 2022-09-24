//
//  PotfolioCD+CoreDataProperties.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 14/09/22.
//
//

import Foundation
import CoreData


extension PotfolioCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PotfolioCD> {
        return NSFetchRequest<PotfolioCD>(entityName: "PotfolioCD")
    }

    @NSManaged public var buyRate: Double
    @NSManaged public var cryptoid: String?
    @NSManaged public var holdingAmount: Double
    @NSManaged public var id: UUID?
    @NSManaged public var moneyLeft: Double
    @NSManaged public var cryptoCD: CryptoCD?
    @NSManaged public var historyCD: NSOrderedSet?

}

// MARK: Generated accessors for historyCD
extension PotfolioCD {

    @objc(insertObject:inHistoryCDAtIndex:)
    @NSManaged public func insertIntoHistoryCD(_ value: HistoryCD, at idx: Int)

    @objc(removeObjectFromHistoryCDAtIndex:)
    @NSManaged public func removeFromHistoryCD(at idx: Int)

    @objc(insertHistoryCD:atIndexes:)
    @NSManaged public func insertIntoHistoryCD(_ values: [HistoryCD], at indexes: NSIndexSet)

    @objc(removeHistoryCDAtIndexes:)
    @NSManaged public func removeFromHistoryCD(at indexes: NSIndexSet)

    @objc(replaceObjectInHistoryCDAtIndex:withObject:)
    @NSManaged public func replaceHistoryCD(at idx: Int, with value: HistoryCD)

    @objc(replaceHistoryCDAtIndexes:withHistoryCD:)
    @NSManaged public func replaceHistoryCD(at indexes: NSIndexSet, with values: [HistoryCD])

    @objc(addHistoryCDObject:)
    @NSManaged public func addToHistoryCD(_ value: HistoryCD)

    @objc(removeHistoryCDObject:)
    @NSManaged public func removeFromHistoryCD(_ value: HistoryCD)

    @objc(addHistoryCD:)
    @NSManaged public func addToHistoryCD(_ values: NSOrderedSet)

    @objc(removeHistoryCD:)
    @NSManaged public func removeFromHistoryCD(_ values: NSOrderedSet)

}

extension PotfolioCD : Identifiable {

}
