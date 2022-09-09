//
//  HistoryViewController.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 12/08/22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var historyData = [HistoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //PersistantStorage.shared.deleteAllEntities()
        
        configureTableView()
        getData()
    }
    
    func getData() {
        HistoryCDRepository.getAllData { HistoryData in
            self.historyData = HistoryData
            print(HistoryData)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstentData.HISTORY_TABLEVIEW_CELL) as! HistoryTableViewCell
        
        let data = historyData[indexPath.row]
        
        
        cell.setData(data: data)
        
        return cell
    }
    
    
}
