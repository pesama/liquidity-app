//
//  TransactionsViewController.swift
//  Finances
//
//  Created by Margareto, Pelayo on 31/03/2019.
//  Copyright © 2019 Smarla. All rights reserved.
//

import Foundation
import UIKit

class TransactionsViewController: UIViewController {
    
    var client: WAVEWaveApiClient?
    var transactions: WAVETransactionsAPIResponse?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = WAVEWaveApiClient.default()
        
        self.fetchTransactions()
    }
    
    func fetchTransactions () {
        self.client!.transactionsLatestGet().continueWith(block: {(task: AWSTask) -> Any? in
            if let error = task.error {
                print("Error occurred: \(error)")
                // Handle error here
                return nil
            }
            
            let result = task.result!
            self.transactions = result
            DispatchQueue.main.async {
                self.refreshUI()
            }
            
            return nil
        })
    }
    
    func refreshUI () {
        self.tableView.reloadData()
    }
}

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.transactions != nil) {
            return self.transactions!.latestTransactions.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableCell", for: indexPath) as! TransactionTableCell
        
        let transaction = self.transactions?.latestTransactions[indexPath.row]
        let transactionValue = Float(transaction!.transactionTotal.business.value)!
        
        cell.transactionName.text = transaction!.transactionDescription
        cell.transactionDate.text = transaction!.transactionDate
        cell.accountName.text = transaction!.anchorAccountName
        let valueText = String(transactionValue) + "€"
        
        cell.transactionDate.textColor = UIColor(red:0.67, green:0.72, blue:0.72, alpha:1.0)
        
        if (transaction!.direction.value == 0) {
            cell.transactionValue.text = valueText
            cell.transactionValue.textColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0)
        } else {
            cell.transactionValue.text = "-" + valueText
            cell.transactionValue.textColor = UIColor(red:0.75, green:0.03, blue:0.09, alpha:1.0)
        }
        
        return cell
    }
    
    
}
