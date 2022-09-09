//
//  HistoryTableViewCell.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 07/09/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var buySellLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var buySellAmount: UILabel!
    @IBOutlet weak var avalableBalanceLable: UILabel!
    @IBOutlet weak var statusLable: UILabel!
    @IBOutlet weak var statusIMG: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var dateLable: UILabel!
    
    @IBOutlet weak var cryptoIMG: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize(width: 3, height: 3)
        cellView.layer.shadowOpacity = 0.7
        cellView.layer.shadowRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: HistoryModel){
        dateLable.text = data.date?.ISO8601Format()
        
        if data.sellRate != nil {
            buySellLable.text = "Sell"
            buySellLable.textColor = .red
            nameLable.text = data.cryptoCD?.name
            buySellAmount.text = "Selling Price:" + String(format: "%.2f", data.sellRate!)
            avalableBalanceLable.text = String(format: "%.2f", data.availableMoney)
            statusLable.text = "- 0.25%"
            statusLable.textColor = .red
            statusIMG.image = UIImage(systemName: "arrowtriangle.down.fill")
            statusIMG.tintColor = .red
            
        }else {
            buySellLable.text = "Buy"
            buySellLable.textColor = .green
            nameLable.text = data.cryptoCD?.name
            buySellAmount.text = "Buying Price:" + String(format: "%.2f", data.buyRate!)
            avalableBalanceLable.text = String(format: "%.2f", data.availableMoney)
            statusLable.isHidden = true
            statusIMG.isHidden = true
        }
        
    }

}
