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
