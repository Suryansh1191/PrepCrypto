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
    @IBOutlet weak var profitPersentageLable: UILabel!
    @IBOutlet weak var proftAmountLable: UILabel!
    @IBOutlet weak var amountInvestedLable: UILabel!
    
    var potfolioData: PotfolioModel?
    var historyCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTableView()
        initalData()
        initStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initalData()
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
        
        var profitPersentage = 0.0
        var profitAmount = 0.0
        
        
        let historyData = potfolioData?.historyCD
        
        var buyAmount = 0.0
        var sellAmount = 0.0
        
        guard historyData != nil else { return }
        
        for historyData in historyData! {
            let data = historyData as! HistoryCD
            if data.amountSell != 0.0 {
                sellAmount = sellAmount + data.amountSell
            }else{
                buyAmount = buyAmount + data.amountBuy
            }
        }
        
        profitAmount = ((sellAmount + ((potfolioData?.buyAmount ?? 0.0)*((potfolioData?.cryptoCD?.currentPrice ?? 0.0)/(potfolioData?.buyRate ?? 0.0)) )) - buyAmount)
        print("profitAmount \(profitAmount)")
        print("sell amount \(sellAmount)")
        profitPersentage = (profitAmount / buyAmount)*100
        
        profitPersentageLable.text = String(format: "%.4f", profitPersentage) + "%"
        proftAmountLable.text = "₹ " + String(format: "%.4f", profitAmount)
        amountInvestedLable.text = "₹ " + String(format: "%.4f", buyAmount)
        
        if profitAmount < 0 {
            proftAmountLable.textColor = .red
            profitPersentageLable.textColor = .red
        }else {
            proftAmountLable.textColor = .systemGreen
            profitPersentageLable.textColor = .systemGreen
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
        let historyCDSet = potfolioData?.historyCD
        let data = historyCDSet?[indexPath.row]
        cell.setData(data: data as! HistoryCD)

        return cell
    }
    
    
}
