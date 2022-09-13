//
//  HistoryDetaileViewController.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 13/09/22.
//

import UIKit

class HistoryDetaileViewController: UIViewController {

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var cryptoID: String?
    var historyData = [HistoryCD]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //nameLable.text =
        title = "History"
        configureTableView()
        getData()
    }
    
    func getData() {
        nameLable.text = cryptoID
        HistoryCDRepository.getById(cryptoID: cryptoID ?? "") { historyData in
            self.historyData = historyData
            print(historyData)
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

extension HistoryDetaileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstentData.POTFOLIO_HISTORY_CELL) as! PotfolioHistoryTableViewCell
        let data = historyData[indexPath.row]
        cell.setData(data: data)

        return cell
    }


}
