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
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var cryptoIMG: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var dateStackView: UIStackView!
    
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
        
        dateLable.text = data.date?.dateFormate()
        cryptoIMG.setImageWithURL(data.cryptoCD?.image)
        
        if data.sellRate != 0.00 {
            buySellLable.text = "Sell"
            buySellLable.textColor = .red
            nameLable.text = data.cryptoCD?.name
            buySellAmount.text = "Selled At: Rs " + String(format: "%.2f", data.sellRate!)
            avalableBalanceLable.text = "Balance: Rs " + String(format: "%.2f", data.availableMoney)
            statusLable.isHidden = true
            statusIMG.isHidden = true
        }else {
            buySellLable.text = "Buy"
            buySellLable.textColor = .systemGreen
            nameLable.text = data.cryptoCD?.name
            buySellAmount.text = "Buyed at: Rs " + String(format: "%.2f", data.buyRate!)
            avalableBalanceLable.text = "Balance: Rs " + String(format: "%.2f", data.availableMoney)
            statusLable.isHidden = true
            statusIMG.isHidden = true
        }
        
    }

}
