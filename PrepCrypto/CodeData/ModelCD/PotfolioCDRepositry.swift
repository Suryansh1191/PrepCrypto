//
//  PotfolioCDRepositry.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 04/09/22.
//

import Foundation
import CoreData

class PotfolioCDRepositry {
    
    static func create(data: PotfolioModel, complition: @escaping () -> Void){
        
        self.getById(id: (data.cryptoModel?.id)!, complition: { PotfolioData, count in
            if (count == 0) { //Creating when not added to potfolio before
                
                let potfolioCD = PotfolioCD(context: PersistantStorage.shared.context)
                
                potfolioCD.holdingAmount = data.buyAmount
                potfolioCD.buyRate = data.buyRate
                potfolioCD.id = UUID()
                potfolioCD.cryptoid = data.cryptoModel?.id
                
                guard data.cryptoModel?.id != nil && data.cryptoModel != nil else { debugPrint("no cryptoID at 25"); return }
                
                CryptoDataRepositry.getByID(cryptoID: (data.cryptoModel?.id!)!) { cryptoCD in
                    print(cryptoCD)
                    potfolioCD.cryptoCD = cryptoCD
                    PersistantStorage.shared.saveContext()
                    
                    //Adding History
                    HistoryCDRepository.addData(data: data, cryptoCD: cryptoCD, sellingRate: nil) {    }
                    
                    complition()
                }
            } else {
                print("lnas;dk")
                //TODO: UPDATE INFO
            }
        })
        
    }
    
    static func getAll(complition: @escaping ([PotfolioModel]) -> Void){
        
        var potfolioData = [PotfolioModel]()
        
        do{
            guard let result = try PersistantStorage.shared.context.fetch(PotfolioCD.fetchRequest()) as? [PotfolioCD] else {
                complition(potfolioData)
                return
            }
            for i in 0...(result.count - 1) {
                let potfolioModel = PotfolioModel(buyAmount: result[i].holdingAmount, buyRate: result[i].buyRate, cryptoModel: nil, cryptoCD: result[i].cryptoCD, cryptoID: result[i].cryptoid, moneyLeft: result[i].moneyLeft)
                potfolioData.append(potfolioModel)
            }
            complition(potfolioData)
        }catch{
            complition(potfolioData)
            return
        } 
        
    }
    
    static func getById(id: String, complition: @escaping (PotfolioCD?, Int) -> Void){
        let fetchRequest = NSFetchRequest<PotfolioCD>(entityName: "PotfolioCD")
        let fetchByID = NSPredicate(format: "cryptoid=%@", id as CVarArg)
        fetchRequest.predicate = fetchByID
        
        let result = try! PersistantStorage.shared.context.fetch(fetchRequest)
        print(result)
        
        guard result.count != 0 else {
            complition(nil, 0)
            print("Error")
            return
        }

        complition(result.first!, 1)
    }
    
}
