//
//  PotfolioTableViewCell.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 05/09/22.
//

import UIKit

class PotfolioTableViewCell: UITableViewCell {

    @IBOutlet weak var cryptoIMG: UIImageView!
    @IBOutlet weak var statusIMG: UIImageView!
    @IBOutlet weak var statusLable: UILabel!
    @IBOutlet weak var buyedAtLable: UILabel!
    @IBOutlet weak var holdingLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: PotfolioModel){
        nameLable.text = data.cryptoCD?.name
        cryptoIMG.setImageWithURL(data.cryptoCD?.image)
        if data.buyRate <= (data.cryptoCD?.currentPrice ?? 0.0) {
            let statusRate = (data.cryptoCD!.currentPrice/data.buyRate) - 1
            statusLable.text = "\(String(format: "%.5f", statusRate)) %"
            statusLable.textColor = .systemGreen
            statusIMG.image = UIImage(systemName: "arrowtriangle.up.fill")
            statusIMG.tintColor = .systemGreen
        }else {
            let statusRate = (data.buyRate/data.cryptoCD!.currentPrice) - 1 
            statusLable.text = "\(String(format: "%.5f", statusRate)) %"
            statusLable.textColor = .red
            statusIMG.image = UIImage(systemName: "arrowtriangle.down.fill")
            statusIMG.tintColor = .red
        }
        buyedAtLable.text = "₹ \(String(format: "%.2f",  data.buyRate))"
        holdingLable.text = "₹ \(String(format: "%.2f",  data.buyAmount))"
    }

}
