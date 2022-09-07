//
//  CryptoRepository.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 01/09/22.
//

import Foundation
import CoreData

class CryptoDataRepositry {

    static func create(data: [CryptoListModel], complition: @escaping () -> Void) {
        print(data.count)
        for i in 0...(data.count-1) {
            print(i)
            
            let cryptoCD = CryptoCD(context: PersistantStorage.shared.context)
            cryptoCD.currentPrice = data[i].currentPrice ?? 0.0
            cryptoCD.name = data[i].name
            cryptoCD.low24H = data[i].low24H ?? 0.0
            cryptoCD.high24H = data[i].high24H ?? 0.0
            cryptoCD.idCrypto = data[i].id
            cryptoCD.priceChangePersent24H = data[i].priceChangePercentage24H ?? 0.0
            cryptoCD.symbol = data[i].symbol
            cryptoCD.image = data[i].image
            cryptoCD.id = UUID()

            PersistantStorage.shared.saveContext()
            print("Create")
        }
       
        complition()
        
    }
    
    static func getAll(complition: @escaping ([CryptoListModel]) -> Void) {
        var cryptoList = [CryptoListModel]()
        
        do {
            
            guard let result = try PersistantStorage.shared.context.fetch(CryptoCD.fetchRequest()) as? [CryptoCD] else {return complition(cryptoList)}
            
            result.forEach { (cryptoCD) in
                let crypto = CryptoListModel(id: cryptoCD.idCrypto, symbol: cryptoCD.symbol, name: cryptoCD.name, image: cryptoCD.image, currentPrice: cryptoCD.currentPrice, marketCap: nil, fullyDilutedValuation: nil, totalVolume: nil, priceChangePercentage24H: cryptoCD.priceChangePersent24H, totalSupply: nil, ath: nil, athDate: nil, atl: nil, atlDate: nil)
                cryptoList.append(crypto)
            }
            
            return complition(cryptoList)

        } catch let error {
            print(error)
            complition(cryptoList)
        }
    }
    
    static func entityIsEmpty(complition: @escaping (Bool) -> Void) {
        do {
            guard let result = try PersistantStorage.shared.context.fetch(CryptoCD.fetchRequest()) as? [CryptoCD] else { return complition(true) }
            
            if result.count == 0 {
                complition(true)
            }else {
                complition(false)
            }
        } catch let error {
            print(error)
            complition(true)
        }
    }
    
    static func getByID(cryptoID: String, complition: @escaping (CryptoCD?) -> Void){
        let fetchRequest = NSFetchRequest<CryptoCD>(entityName: "CryptoCD")
        let fetchByID = NSPredicate(format: "idCrypto=%@", cryptoID as CVarArg)
        fetchRequest.predicate = fetchByID
        
        let result = try! PersistantStorage.shared.context.fetch(fetchRequest)
        
        guard result.count != 0 else { print("Error")
            complition(nil)
            return
        }
        complition(result.first!)
        
    }
    
    static func updateData(data: [CryptoListModel], comlition: @escaping () -> Void){
        
        for i in 0...(data.count-1) {
            
            guard data[i].id != nil else { continue }
            
            self.getByID(cryptoID: data[i].id!) { cryptoCD in
                if cryptoCD != nil {
                    cryptoCD!.currentPrice = data[i].currentPrice ?? 0.0
                    cryptoCD!.name = data[i].name
                    cryptoCD!.low24H = data[i].low24H ?? 0.0
                    cryptoCD!.high24H = data[i].high24H ?? 0.0
                    cryptoCD!.idCrypto = data[i].id
                    cryptoCD!.priceChangePersent24H = data[i].priceChangePercentage24H ?? 0.0
                    cryptoCD!.symbol = data[i].symbol
                    cryptoCD!.image = data[i].image
                    cryptoCD!.id = UUID()
                    
                    PersistantStorage.shared.saveContext()
                }
            }
            
            
        }
        
        comlition()
        
    }

}
