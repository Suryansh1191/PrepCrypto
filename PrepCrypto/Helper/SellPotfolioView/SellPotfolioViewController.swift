//
//  SellPotfolioViewController.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 08/09/22.
//

import UIKit

protocol UpdatePotfolioViewController{
    func update()
}

class SellPotfolioViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var holdingLable: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var roundTextfield: UITextField!
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var alertLable: UILabel!
    
    var potfolioData: PotfolioModel?
    var sellingamount: Double = 0.0
    var deligate: UpdatePotfolioViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalizeData()
        alertLable.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("DisApper")
    }
    
    func initalizeData() {
        
        self.view.backgroundColor = .clear
        self.mainView.backgroundColor = .black.withAlphaComponent(0.6)
        //self.contentView.alpha = 0
        self.mainView.alpha = 0
        self.contentView.layer.cornerRadius = 10
        
        imageView.setImageWithURL(potfolioData?.cryptoCD?.image)
        nameLable.text = potfolioData?.cryptoCD?.name
        priceLable.text = String(format: "%.2f", potfolioData?.cryptoCD?.currentPrice ?? 0.0)
        holdingLable.text = "Rs: " + String(format: "%.2f", potfolioData?.buyAmount ?? 0.0)
        roundTextfield.becomeFirstResponder()
    }
    

    @IBAction func sellFieldDidChanged(_ sender: Any) {
        sellingamount = Double(roundTextfield.text ?? "0.0") ?? 0.0
        print(sellingamount)
    }
    
    @IBAction func cancleButton(_ sender: Any) {
        self.deligate?.update()
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func buyButtin(_ sender: Any) {
        
        if sellingamount > (potfolioData?.buyAmount ?? 0.0) {
            alertLable.text = "You only hold Rs.\(potfolioData?.buyAmount ?? 0.0)"
            return
        }
        
        //print(sellingamount)
        PotfolioCDRepositry.sell(potfolioData: potfolioData!, sellingAmount: sellingamount) {
            self.deligate?.update()
        }
    }
}
