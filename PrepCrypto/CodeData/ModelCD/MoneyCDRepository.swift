//
//  MoneyCDRepository.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 06/09/22.
//

import Foundation


class MoenyCDRepository{
    
    static func getData(complition: @escaping (MoneyModel) -> Void){
        var moneyModel = MoneyModel(totalMoney: 0.0, avalableMoney: 0.0)
        
        do {
            guard let result = try PersistantStorage.shared.context.fetch(MoneyCD.fetchRequest()) as? [MoneyCD] else { complition(moneyModel) }
            
            guard result.first != nil else { complition(moneyModel); return }
            
            moneyModel = MoneyModel(totalMoney: result.first!.totalMoney, avalableMoney: result.first!.availableMoney)
            
            complition(moneyModel)
        }catch{
            print()
            complition(moneyModel)
        }
    }
    
    static func createData(comlition: @escaping () -> Void){
        let moneyCD = MoneyCD(context: PersistantStorage.shared.context)
        
        moneyCD.totalMoney = 10000.00
        moneyCD.availableMoney = 10000.00
        moneyCD.id = "main"
        
        PersistantStorage.shared.saveContext()
        
        comlition()
    }
    
    static func editData(data: MoneyCD, complition: @escaping () -> Void){
        //TODO: EDIT DATA
    }
    
}
