//
//  AddToPotfolioViewController.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 15/08/22.
//

import UIKit


class AddToPotfolioViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var availableMoenyLable: UILabel!
    @IBOutlet weak var buyAmountLable: UILabel!
    @IBOutlet weak var warningLable: UILabel!
    
    var cryptoData: DetailedCryptoModel?
    var buyAmount = 0.0
    var availableMoney = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        MoneyCDRepository.getData { moneyCD in
            print(moneyCD.avalableMoney)
            self.availableMoney = moneyCD.avalableMoney
        }
        initalizeData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancleAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func potfolioAction(_ sender: Any) {
        
        if buyAmount > availableMoney {
            warningLable.text = "You only have ₹\(availableMoney) in you balance"
            return 
        }
        
        let potfolioDM = PotfolioModel(buyAmount: (Double(amountTextField.text ?? "0.0") ?? 0.0), buyRate: cryptoData?.marketData?.currentPrice?.inr ?? 0.0, cryptoModel: cryptoData!, historyCD: nil, moneyLeft: 0.0) //force unwraping because we have guard statment in initalizeData()
        PotfolioCDRepositry.addToPotfolio(data: potfolioDM) {
            self.dismiss(animated: true, completion: nil)
            PotfolioCDRepositry.getAll { data in
                print(data)
            }
        }
    }
    
    func initalizeData() {
        guard cryptoData != nil else { return }
        
        nameLable.text = cryptoData?.name
        availableMoenyLable.text = "₹ \(String(availableMoney))"
        priceLable.text = "₹ \(String(format: "%.2f",  cryptoData?.marketData?.currentPrice?.inr ?? 0.0))"
        buyAmountLable.text = "C \(buyAmount)"
        imgView.setImageWithURL(cryptoData?.image?.large)
        amountTextField.becomeFirstResponder()
    }
    
    @IBAction func textFieldOnChange(_ sender: Any) {
        print(buyAmount)
        buyAmount = ( (Double(amountTextField.text ?? "0.0") ?? 0.0) / (cryptoData?.marketData?.currentPrice?.inr ?? 0.0))
        print(buyAmount)
        buyAmountLable.text = "C \(String(format: "%.2f", buyAmount))"
    }
    
    
    
}
