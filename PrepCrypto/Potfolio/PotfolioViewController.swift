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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        getPotfolioData()
        
        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getPotfolioData() {
        PotfolioCDRepositry.getAll { potfolioData in
            self.potfolioData = potfolioData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
    
    
}
