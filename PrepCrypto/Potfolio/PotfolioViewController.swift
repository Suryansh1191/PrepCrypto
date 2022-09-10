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
        
        //Potfolio View
        potfolioView.layer.cornerRadius = 10
        potfolioView.layer.shadowColor = UIColor.black.cgColor
        potfolioView.layer.shadowOffset = CGSize(width: 3, height: 3)
        potfolioView.layer.shadowOpacity = 0.7
        potfolioView.layer.shadowRadius = 4.0
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
            statusLable.text = "- \(String(format: "%.2f", status)) %"
            statusLable.textColor = .red
            statusIMG.image = UIImage(systemName: "arrowtriangle.down.fill")
            statusIMG.tintColor = .red
            
        }else {
            statusLable.text = "+ \(String(format: "%.2f", status)) %"
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
