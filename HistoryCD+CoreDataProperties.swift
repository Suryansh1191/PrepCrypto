//
//  HistoryCD+CoreDataProperties.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 12/09/22.
//
//

import Foundation
import CoreData


extension HistoryCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryCD> {
        return NSFetchRequest<HistoryCD>(entityName: "HistoryCD")
    }

    @NSManaged public var amountBuy: Double
    @NSManaged public var amountSell: Double
    @NSManaged public var availableMoney: Double
    @NSManaged public var buyRate: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var idCrypto: String?
    @NSManaged public var sellRate: Double
    @NSManaged public var cryptoCD: CryptoCD?
    @NSManaged public var potfolioCD: PotfolioCD?

}

extension HistoryCD : Identifiable {

}
