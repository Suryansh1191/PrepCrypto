//
//  PotfolioDetailedViewController.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 07/09/22.
//

import UIKit

class PotfolioDetailedViewController: UIViewController {

    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var detailsLable: UILabel!
    
    var potfolioData: PotfolioModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initalData()
        initStyle()
    }
    
    func initStyle() {
        
        firstView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        firstView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        firstView.layer.shadowOpacity = 1.0
        firstView.layer.shadowRadius = 5.0
        firstView.layer.masksToBounds = false
        firstView.layer.cornerRadius = 4.0

        
    }
    
    func initalData() {
        nameLable.text = potfolioData?.cryptoCD?.name
        imageView.setImageWithURL(potfolioData?.cryptoCD?.image)
        priceLable.text = "₹ " + String(format: "%.2f", (potfolioData?.cryptoCD?.currentPrice ?? 0.0))
    }
    
    @IBAction func sellStocks(_ sender: Any) {
        guard potfolioData != nil else { return }
        
        let storyboard = UIStoryboard(name: "SellPotfolio", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "sellStocks") as! SellPotfolioViewController
        myAlert.potfolioData = potfolioData
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destiantion = segue.destination as? DetailedCryptoViewController
        
        destiantion?.cryptoID = potfolioData?.cryptoID
        
        
        
        
    }

}
