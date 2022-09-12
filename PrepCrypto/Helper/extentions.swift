//
//  extentions.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 13/08/22.
//

import Foundation
import UIKit


extension UIImageView {
    func setImageWithURL(_ url: String?){
        
        if url == nil {
            return
        }
        
        let url = URL(string: url!)
        let sesion = URLSession.shared
        
        //downloading image here to set in UI IMAGE
        let dataTask = sesion.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.image = image
                }
                
            }
            
        }
        dataTask.resume()
    }
}


extension Date {
    func dateFormate() -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
                
        let date: Date? = dateFormatterGet.date(from: self.ISO8601Format() )
        return dateFormatterPrint.string(from: date!);

    }
}
