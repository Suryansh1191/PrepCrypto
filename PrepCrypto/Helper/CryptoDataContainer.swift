//
//  CryptoDataContainer.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 05/09/22.
//

import Foundation

class CryptoDataContainer{
    static var data = [CryptoListModel]()
    
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
                                    print("Data Updated")
                                    CryptoDataContainer.data = cryptoCD
                                }
                            }
                        }
                        
                    }else{
                        CryptoDataRepositry.updateData(data: data) {
                            CryptoDataRepositry.getAll { cryptoCD in
                                CryptoDataContainer.data = cryptoCD
                            }
                        }
                    }
                    
                }
                
            case .failure(let error):
                //TODO: Notify NO internet
                
                CryptoDataRepositry.getAll { data in
                    CryptoDataContainer.data = data
                }
                //error handling
                print(error)
            }
        }
    }
}
