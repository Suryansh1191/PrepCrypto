//
//  HistoryCDRepository.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 05/09/22.
//

import Foundation
import CoreData

class HistoryCDRepository{
    
    static func addData(data: PotfolioModel, cryptoCD: CryptoCD, sellingAmount: Double?, complition: @escaping (HistoryCD)->Void){
        let historyCD = HistoryCD(context: PersistantStorage.shared.context)
        
        historyCD.idCrypto = data.cryptoID
        historyCD.date = Date()
        historyCD.id = UUID()
        if sellingAmount != nil {
            historyCD.sellRate = data.cryptoCD?.currentPrice ?? 0.0
            historyCD.amountSell = sellingAmount ?? 0.0
        }
        if sellingAmount == nil {
            historyCD.buyRate = data.buyRate
            historyCD.amountBuy = data.buyAmount
        }
        historyCD.cryptoCD = cryptoCD
        MoneyCDRepository.getData { balanceData in
            historyCD.availableMoney = balanceData.avalableMoney
            PersistantStorage.shared.saveContext()
            complition(historyCD)
        }
        
    }
    
    static func getAllData(complition: @escaping ([HistoryModel])->Void){
        
        var historyList = [HistoryModel]()
        
        do {
            
            guard let result = try PersistantStorage.shared.context.fetch(HistoryCD.fetchRequest()) as? [HistoryCD] else {return complition(historyList)}
            
            guard result.count != 0 else { complition(historyList); return }
            
            for historyCD in result.reversed() {
                let history = HistoryModel(idCrypto: historyCD.idCrypto, buyRate: historyCD.buyRate, sellRate: historyCD.sellRate, amountBuy: historyCD.amountBuy, availableMoney: historyCD.availableMoney, id: historyCD.id, date: historyCD.date, cryptoCD: historyCD.cryptoCD)
                historyList.append(history)
            }
            
            complition(historyList)
            return

        } catch let error {
            print(error)
            complition(historyList)
            return
        }
        
    }
    
    static func getById(cryptoID: String ,complition: @escaping ([HistoryCD])->Void){
        let fetchRequest = NSFetchRequest<HistoryCD>(entityName: "HistoryCD")
        let fetchByID = NSPredicate(format: "idCrypto=%@", cryptoID as CVarArg)
        fetchRequest.predicate = fetchByID
        
        let result = try! PersistantStorage.shared.context.fetch(fetchRequest)
        
        complition(result)
        return
    }
    
}
