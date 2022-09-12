//
//  PotfolioHistoryTableViewCell.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 11/09/22.
//

import UIKit

class PotfolioHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var buySellLable: UILabel!
    @IBOutlet weak var buySellAmountLabler: UILabel!
    @IBOutlet weak var buySellAtLable: UILabel!
    @IBOutlet weak var sellRateLable: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var historyCD: HistoryCD?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: HistoryCD){
        if data.sellRate != 0.0 {
            buySellLable.text = "Sell"
            buySellLable.textColor = .red
            buySellAmountLabler.text = "Selling Amount: Rs " + String(format: "%.2f", data.amountSell)
            buySellAtLable.text = "Selling Price: Rs" + String(format: "%.2f", data.sellRate)
            sellRateLable.isHidden = true
        }
        else{
            buySellLable.text = "Buy"
            buySellLable.textColor = .systemGreen
            buySellAmountLabler.text = "Buying Amount: Rs " + String(format: "%.2F", data.amountBuy)
            buySellAtLable.text = "Buying Price: Rs" + String(format: "%.2f", data.buyRate)
            sellRateLable.isHidden = true
        }
    }

}
