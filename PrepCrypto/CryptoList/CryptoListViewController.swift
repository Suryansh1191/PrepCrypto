//
//  CyptoListViewController.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 12/08/22.
//

import UIKit

class CryptoListViewController: UIViewController {

    @IBOutlet weak var tabeView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var cryptodata = [CryptoListModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "Crypto List"
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        getCryptoData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Crypto List"
    }
    
    func configureTableView() {
        tabeView.delegate = self
        tabeView.dataSource = self
    }
    
    func getCryptoData() {
        if CryptoDataContainer.data.count != 0 {
            self.cryptodata = CryptoDataContainer.data
            DispatchQueue.main.async {
                self.tabeView.reloadData()
                self.spinner.isHidden = true
            }
        }
    }
}



//MARK: TableView
extension CryptoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptodata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstentData.CRYPTO_TABLEVIEW_CELL) as! CrytoTableViewCell
        
        let crypto = cryptodata[indexPath.row]
        
        cell.setData(data: crypto)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard tabeView.indexPathForSelectedRow != nil else { return }
        
        let selectedCrypto = cryptodata[tabeView.indexPathForSelectedRow!.row]
        
        let tranferDestination = segue.destination as! DetailedCryptoViewController
        
        tranferDestination.cryptoID = selectedCrypto.id
    }
    
    
    
}
