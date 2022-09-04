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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: PotfolioModel){
        statusLable.text = "Profit"
        buyedAtLable.text = String(data.buyRate)
        holdingLable.text = String(data.buyAmount)
    }

}
