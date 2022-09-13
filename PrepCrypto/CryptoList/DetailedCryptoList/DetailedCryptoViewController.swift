//
//  DetailedCryptoViewController.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 13/08/22.
//

import UIKit
import Charts

class DetailedCryptoViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var lowPriceLable: UILabel!
    @IBOutlet weak var highPriveLable: UILabel!
    @IBOutlet weak var persentagePriceLable: UILabel!
    @IBOutlet weak var indicatorImage: UIImageView!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var spinnerView: UIView!
    
    var cryptoID: String? = "bitcoin"
    var cryptoData: DetailedCryptoModel? = nil
    var buyAmountText = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View some here")
        spinnerView.isHidden = false
        lineChart.delegate = self
        
        getCryptoIDData()
    }
    
    override func viewWillAppear(_ animated: Bool) {  }
    
    func setDataValue() {
        guard cryptoData != nil else { return }
        nameLable.text = cryptoData?.name
        priceLable.text = "₹ \(String(describing: cryptoData?.marketData?.currentPrice?.inr ?? 0.0))"
        lowPriceLable.text = "₹ \(String(describing: cryptoData?.marketData?.low24H?.inr ?? 0.0))"
        highPriveLable.text = "₹ \(String(describing: cryptoData?.marketData?.high24H?.inr ?? 0.0))"
        persentagePriceLable.text = "\(String(format: "%.2f", cryptoData?.marketData?.priceChangePercentage24H ?? 0.0)) %"
        
        if cryptoData?.marketData?.priceChangePercentage24H ?? 0.0 <= 0.0 {
            
            self.persentagePriceLable.textColor = .red
            self.indicatorImage.image = UIImage(systemName: "arrowtriangle.down.fill")
            self.indicatorImage.tintColor = .red

        }else{
            self.persentagePriceLable.textColor = .systemGreen
            self.indicatorImage.image = UIImage(systemName: "arrowtriangle.up.fill")
            self.indicatorImage.tintColor = .systemGreen
        }
        
        imgView.setImageWithURL(cryptoData?.image?.large)
        
        
        chartDrow()
        
    }
    
    func chartDrow() {
        
        var entries = [ChartDataEntry]()
        
        let totalData = cryptoData?.marketData?.sparkline7D?.price
        
        guard totalData != nil else { return }
        
        for x in 0..<totalData!.count {
            entries.append(ChartDataEntry(x: Double(x), y: totalData![x]))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.vordiplom()
        set.highlightColor = NSUIColor.clear
        lineChart.xAxis.drawAxisLineEnabled = true
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawLabelsEnabled = false
        lineChart.leftAxis.drawAxisLineEnabled = true

        set.drawCirclesEnabled = false
        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
        
        spinnerView.isHidden = true
        
    }
    
    func getCryptoIDData() {
        
        guard cryptoID != nil else { return }
        let url = URL(string: "\(UrlContaner.crypto)\(cryptoID!)?tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false&sparkline=true")!
        
        
        
        ApiNetworkCall.apiCall(DetailedCryptoModel.self, url: URLRequest(url:  url)) { result in
            switch result {
            case .success(let data):
                self.cryptoData = data
                DispatchQueue.main.async {
                    self.setDataValue()
                }
            case .failure(let error):
                //error handling
                print(error)
            }
        }
        
    }
    
    
    @IBAction func addToPotfolio(_ sender: Any) {
        
        guard cryptoData != nil else { return }
        
        let storyboard = UIStoryboard(name: "AddToPotfolio", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "addToPotfolioID") as! AddToPotfolioViewController
        myAlert.cryptoData = cryptoData
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
        
    }
    

    
    

}
