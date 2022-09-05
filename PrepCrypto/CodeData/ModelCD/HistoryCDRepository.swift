//
//  HistoryCDRepository.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 05/09/22.
//

import Foundation

class HistoryCDRepository{
    
    static func addData(data: PotfolioModel, sellingRate: Double?, complition: @escaping ()->Void){
        let historyCD = HistoryCD(context: PersistantStorage.shared.context)
        
        historyCD.buyRate = data.buyRate
        historyCD.idCrypto = data.cryptoID
        historyCD.amountBuy = data.buyAmount
        historyCD.availableMoney = 0.0
        historyCD.date = Date()
        historyCD.id = UUID()
        if sellingRate != nil {
            historyCD.sellRate = sellingRate!
        }
        
        
        PersistantStorage.shared.saveContext()
    }
    
    static func getAllData(complition: @escaping ([HistoryModel])->Void){
        
        var historyList = [HistoryModel]()
        
        do {
            
            guard let result = try PersistantStorage.shared.context.fetch(HistoryCD.fetchRequest()) as? [HistoryCD] else {return complition(historyList)}
            
            result.forEach { (historyCD) in
                let history = HistoryModel(idCrypto: historyCD.idCrypto, buyRate: historyCD.buyRate, sellRate: historyCD.sellRate, amountBuy: historyCD.amountBuy, availableMoney: historyCD.availableMoney, id: historyCD.id, date: historyCD.date, cryptoCD: historyCD.cryptoCD)
                historyList.append(history)
            }
            
            return complition(historyList)

        } catch let error {
            print(error)
            return complition(historyList)
        }
        
    }
    
    static func getById(complition: @escaping ([HistoryModel])->Void){
        
    }
    
}
