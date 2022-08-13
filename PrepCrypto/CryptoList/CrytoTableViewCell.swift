//
//  CrytoTableViewCell.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 12/08/22.
//

import UIKit

class CrytoTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCrypto: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var subNameLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var subPriceLable: UILabel!
    @IBOutlet weak var indicatorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: CryptoListModel){
        
        
        DispatchQueue.main.async {
            self.nameLable.text = data.name
            self.priceLable.text = "₹ \(String(describing: data.currentPrice ?? 0.0))"
            self.subPriceLable.text = " \(String(format: "%.2f",  data.marketCapChangePercentage24H ?? 0.0)) %"
            self.subNameLable.text = data.symbol
            
            //changing colour according to the rate
            if (data.marketCapChangePercentage24H ?? 0) < 0 {
                self.subPriceLable.textColor = .red
                self.indicatorImage.image = UIImage(systemName: "arrowtriangle.down.fill")
                self.indicatorImage.tintColor = .red

            }else{
                self.subPriceLable.textColor = .systemGreen
                self.indicatorImage.image = UIImage(systemName: "arrowtriangle.up.fill")
                self.indicatorImage.tintColor = .systemGreen
            }
            self.imageViewCrypto.setImageWithURL(data.image)
        }
    }

}

