//
//  PotfolioCDRepositry.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 04/09/22.
//

import Foundation
import CoreData

class PotfolioCDRepositry {
    
    static func addToPotfolio(data: PotfolioModel, complition: @escaping () -> Void){
        
        self.getById(id: (data.cryptoModel?.id)!, complition: { potfolioData, count in
            if (count == 0) { //Creating when not added to potfolio before
                
                let potfolioCD = PotfolioCD(context: PersistantStorage.shared.context)
                
                potfolioCD.holdingAmount = data.buyAmount
                if potfolioCD.buyRate == 0.0 {
                    potfolioCD.buyRate = data.buyRate
                }
                potfolioCD.id = UUID()
                potfolioCD.cryptoid = data.cryptoModel?.id
                
                guard data.cryptoModel?.id != nil && data.cryptoModel != nil else { debugPrint("no cryptoID at 25"); return }
                
                CryptoDataRepositry.getByID(cryptoID: (data.cryptoModel?.id!)!) { cryptoCD in
                    
                    potfolioCD.cryptoCD = cryptoCD
                    
                    //UPDATE BALANCE
                    MoneyCDRepository.editData(moneySpent: data.buyAmount, moneyAdded: nil){
                        
                        //Adding History
                        HistoryCDRepository.addData(data: data, cryptoCD: cryptoCD!, sellingAmount: nil) { addedHistoryCD in
                            
                            //Checking for past History
                            HistoryCDRepository.getById(cryptoID: (data.cryptoID ?? "")) { historyCD in
                                if historyCD.count != 0 {
                                    let index = NSIndexSet(index: 0)
                                    potfolioCD.insertIntoHistoryCD(historyCD, at: index)
                                }
                                potfolioCD.addToHistoryCD(addedHistoryCD)
                                PersistantStorage.shared.saveContext()
                                complition()
                            }
                            
                        }
                    }
                }
            } else { //just editing the data
                potfolioData!.holdingAmount = (potfolioData!.holdingAmount + data.buyAmount)
                potfolioData!.buyRate = data.buyRate
                
                
                //UPDATE BALANCE
                MoneyCDRepository.editData(moneySpent: data.buyAmount, moneyAdded: nil) {
                    
                    //Adding History
                    HistoryCDRepository.addData(data: data, cryptoCD: (potfolioData?.cryptoCD!)!, sellingAmount: nil) { historyCD in
                        potfolioData?.addToHistoryCD(historyCD)
                        PersistantStorage.shared.saveContext()
                        complition()
                    }
                }
            }
        })
        
    }
    
    static func sell(potfolioData: PotfolioModel, sellingAmount: Double, complition: @escaping () -> Void){
        self.getById(id: potfolioData.cryptoID ?? "") { potfolioCD, status in
            if status == 1 {
                
                if potfolioCD!.holdingAmount <= sellingAmount { //Deleting the Data
                    
                    //UPDATE BALANCE
                    MoneyCDRepository.editData(moneySpent: nil, moneyAdded: sellingAmount) {
                        
                        //Adding History
                        HistoryCDRepository.addData(data: potfolioData, cryptoCD: (potfolioCD?.cryptoCD!)!, sellingAmount: sellingAmount) { historyCD in
                            PersistantStorage.shared.context.delete(potfolioCD!)
                            PersistantStorage.shared.saveContext()
                            complition()
                            return
                        }
                    }
                
                }else{
                    potfolioCD!.holdingAmount = (potfolioCD!.holdingAmount - sellingAmount)
                                
                    //UPDATE BALANCE
                    MoneyCDRepository.editData(moneySpent: nil, moneyAdded: sellingAmount) {
                        
                        //Adding History
                        HistoryCDRepository.addData(data: potfolioData, cryptoCD: (potfolioCD?.cryptoCD!)!, sellingAmount: sellingAmount) { historyCD in
                            potfolioCD?.addToHistoryCD(historyCD)
                            PersistantStorage.shared.saveContext()
                            complition()
                            return

                        }
                    }
                }
            }else {
                complition()
                //TODO: error handling
            }
        }
        
    }
    
    static func getAll(complition: @escaping ([PotfolioModel]) -> Void){
        
        var potfolioData = [PotfolioModel]()
        
        do{
            guard let result = try PersistantStorage.shared.context.fetch(PotfolioCD.fetchRequest()) as? [PotfolioCD] else {
                complition(potfolioData)
                return
            }
            
            guard result.count > 0 else { complition(potfolioData); return }
            
            for i in (0..<(result.count)).reversed() {
                let potfolioModel = PotfolioModel(buyAmount: result[i].holdingAmount, buyRate: result[i].buyRate, cryptoModel: nil, cryptoCD: result[i].cryptoCD, cryptoID: result[i].cryptoid, historyCD: result[i].historyCD?.count == 0 ? nil : result[i].historyCD , moneyLeft: result[i].moneyLeft)
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
