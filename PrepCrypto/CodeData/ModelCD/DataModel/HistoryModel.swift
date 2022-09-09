//
//  HistoryModel.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 04/09/22.
//

import Foundation

struct HistoryModel{
    public var idCrypto: String?
    public var buyRate: Double?
    public var sellRate: Double?
    public var amountBuy: Double
    public var availableMoney: Double
    public var id: UUID?
    public var date: Date?
    public var cryptoCD: CryptoCD?
}
