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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancleAction(_ sender: Any) {
    }
    
    @IBAction func potfolioAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
