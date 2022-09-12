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
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var historyView: UIView!
    
    var potfolioData: PotfolioModel?
    var historyCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTableView()
        initalData()
        initStyle()
    }
    
    func initTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    func initStyle() {
        
        
        
        //shadow
        firstView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        firstView.layer.shadowOffset = CGSize(width: 3, height: 0)
        firstView.layer.shadowOpacity = 1
        firstView.layer.shadowRadius = 10.0
        firstView.clipsToBounds = false
        firstView.layer.cornerRadius = 30
        firstView.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        
    }
    
    func initalData() {
        nameLable.text = potfolioData?.cryptoCD?.name
        imageView.setImageWithURL(potfolioData?.cryptoCD?.image)
        priceLable.text = "₹ " + String(format: "%.2f", (potfolioData?.cryptoCD?.currentPrice ?? 0.0))
        
        historyCount = potfolioData?.historyCD?.count ?? 0
        DispatchQueue.main.async {
            self.historyTableView.reloadData()
        }
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

extension PotfolioDetailedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(potfolioData?.historyCD)
        
        return historyCount
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstentData.POTFOLIO_HISTORY_CELL) as! PotfolioHistoryTableViewCell
//
        let historyCDSet = potfolioData?.historyCD
//
//        guard historyCDSet != nil else {
//            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
//            return cell
//
//        }
//
        let data = historyCDSet?[indexPath.row]
//
//
        cell.setData(data: data as! HistoryCD)
//
        return cell
    }
    
    
}
