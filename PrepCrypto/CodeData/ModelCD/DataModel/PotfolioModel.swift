//
//  potfolioModel.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 04/09/22.
//

import Foundation

struct PotfolioModel{
    var buyAmount: Double
    var buyRate: Double
    var cryptoModel: DetailedCryptoModel?
    var cryptoCD: CryptoCD?
    var cryptoID: String?
    var historyCD: NSOrderedSet?
    var moneyLeft: Double
}
