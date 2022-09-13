//
//  CryptoDataContainer.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 05/09/22.
//

import Foundation

protocol CryptoDataFetchedDelegate{
    func isCryptoDataFetched(status: Bool)
}

class CryptoDataContainer{
    
    static var data = [CryptoListModel]()
    static var fetchedDelegate: CryptoDataFetchedDelegate?
    
    static func getData(){
        let url = URL(string: "\(UrlContaner.crypto)/markets?vs_currency=inr")
        ApiNetworkCall.apiCall([CryptoListModel].self, url: URLRequest(url: url!)) { result in
            switch result {
            case .success(let data):
                
                // CORE DATA WORK
                CryptoDataRepositry.entityIsEmpty { status in
                    if status {
                        CryptoDataRepositry.create(data: data) {
                            MoneyCDRepository.createData {
                                CryptoDataRepositry.getAll { cryptoCD in
                                    CryptoDataContainer.fetchedDelegate?.isCryptoDataFetched(status: true)
                                    CryptoDataContainer.data = cryptoCD
                                }
                            }
                        }
                        
                    }else{
                        CryptoDataRepositry.updateData(data: data) {
                            CryptoDataRepositry.getAll { cryptoCD in
                                CryptoDataContainer.fetchedDelegate?.isCryptoDataFetched(status: true)
                                CryptoDataContainer.data = cryptoCD
                            }
                        }
                    }
                    
                }
                
            case .failure(let error):
                //TODO: Notify NO internet
                
                CryptoDataRepositry.getAll { data in
                    CryptoDataContainer.data = data
                    CryptoDataContainer.fetchedDelegate?.isCryptoDataFetched(status: false)
                }
                //error handling
                print(error)
            }
        }
    }
}
