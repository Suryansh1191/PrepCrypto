//
//  PotfolioViewController.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 12/08/22.
//

import UIKit

class PotfolioViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var potfolioData = [PotfolioModel]()
    @IBOutlet weak var statusLable: UILabel!
    @IBOutlet weak var potfolioCountLable: UILabel!
    @IBOutlet weak var initalBalanceLable: UILabel!
    @IBOutlet weak var avalableBalanceLable: UILabel!
    @IBOutlet weak var inStocksBalanceLable: UILabel!
    @IBOutlet weak var potfolioView: UIView!
    @IBOutlet weak var subPotfolioView: UIView!
    @IBOutlet weak var statusIMG: UIImageView!
    @IBOutlet weak var assitView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        addStyleInView()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Potfolio"
        print("Potfolio View")
        getPotfolioData()
    }
    
    func addStyleInView() {
        assitView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        assitView.layer.shadowOffset = CGSize(width: 0, height: 3)
        assitView.layer.shadowOpacity = 1
        assitView.layer.shadowRadius = 10.0
        assitView.clipsToBounds = false
        assitView.layer.cornerRadius = 30
        assitView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getPotfolioData() {
        
        MoneyCDRepository.getData { balanceData in
            self.initalBalanceLable.text = "₹ " +  String(balanceData.totalMoney)
            self.avalableBalanceLable.text = "₹ " + String(balanceData.avalableMoney)
            
            PotfolioCDRepositry.getAll { potfolioData in
                self.potfolioData = potfolioData
                if potfolioData.count == 0 { return }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.calculateData(data: potfolioData, balanceData: balanceData)
                }
            }
        }
    }
    
    func calculateData(data: [PotfolioModel], balanceData: MoneyModel){
        let count = data.count
        var inStocksBalance = 0.0
        for i in 0...(count-1) {
            inStocksBalance = inStocksBalance + (data[i].buyAmount * ((data[i].cryptoCD?.currentPrice ?? 0.0)/data[i].buyRate))
        }
        
        self.potfolioCountLable.text = String(count)
        self.inStocksBalanceLable.text = "₹ " + String(format: "%.2f" ,inStocksBalance)
        let status = (((inStocksBalance+balanceData.avalableMoney) - balanceData.totalMoney) / balanceData.totalMoney)
        
        if ((inStocksBalance+balanceData.avalableMoney) < balanceData.totalMoney) {
            statusLable.text = "- \(String(format: "%.4f", status)) %"
            statusLable.textColor = .red
            statusIMG.image = UIImage(systemName: "arrowtriangle.down.fill")
            statusIMG.tintColor = .red
            
        }else {
            statusLable.text = "+ \(String(format: "%.4f", status)) %"
            statusLable.textColor = .systemGreen
            statusIMG.tintColor = .systemGreen
            statusIMG.image = UIImage(systemName: "arrowtriangle.up.fill")

        }
    }
}

extension PotfolioViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return potfolioData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstentData.POTFOLIO_TABLEVIEW_CELL) as! PotfolioTableViewCell
        
        let data = potfolioData[indexPath.row]
        
        
        cell.setData(data: data)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard tableView.indexPathForSelectedRow != nil else { return }
        
        let potfolioData = potfolioData[tableView.indexPathForSelectedRow!.row]
        
        let destination = segue.destination as? PotfolioDetailedViewController
        
        destination?.potfolioData = potfolioData
    }
    
}
