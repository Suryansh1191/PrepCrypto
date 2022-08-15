//
//  AddToPotfolioViewController.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 15/08/22.
//

import UIKit

protocol AddToPotfolioProtocal {
    func cryptoToBuyData(_ data: DetailedCryptoModel)
}

class AddToPotfolioViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var availableMoenyLable: UILabel!
    @IBOutlet weak var buyAmountLable: UILabel!
    
    let detailedViewControler = DetailedCryptoViewController()
    var cryptoData: DetailedCryptoModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailedViewControler.delegate = self
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        initalizeData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancleAction(_ sender: Any) {
        print(cryptoData)
    }
    
    @IBAction func potfolioAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
    func initalizeData() {
        guard cryptoData != nil else { return }
        
        nameLable.text = cryptoData?.name
        availableMoenyLable.text = "₹ 24305"
        priceLable.text = "₹ \(String(format: "%.2f",  cryptoData?.marketData?.currentPrice?.inr ?? 0.0))"
        buyAmountLable.text = "₹ 0"
        imgView.setImageWithURL(cryptoData?.image?.large)
    }
    
}

extension AddToPotfolioViewController: AddToPotfolioProtocal {
    func cryptoToBuyData(_ data: DetailedCryptoModel) {
        print("called")
        print(data)
    }
}
