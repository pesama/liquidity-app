//
//  ViewController.swift
//  Finances
//
//  Created by Margareto, Pelayo on 30/03/2019.
//  Copyright © 2019 Smarla. All rights reserved.
//

import UIKit
import AWSAPIGateway
import AWSMobileClient
import AWSLex

class DashboardViewController: UIViewController, AWSLexVoiceButtonDelegate {
    
    private let dateFormatter = DateFormatter()
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0,
                                             left: 10.0,
                                             bottom: 10.0,
                                             right: 10.0)

    @IBOutlet weak var totalBalance: UILabel!
    @IBOutlet weak var todayExpenses: UILabel!
    @IBOutlet weak var weekExpenses: UILabel!
    @IBOutlet weak var monthExpenses: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var voiceButton: AWSLexVoiceButton!
    
    var currentBalances: WAVEBalancesAPIResponse?
    var transactions: WAVETransactionsAPIResponse?
    
    var client: WAVEWaveApiClient?
    
    override func viewDidLoad() {
        client = WAVEWaveApiClient.default()
        
        // Set the bot configuration details
        // You can use the configuration constants defined in AWSConfiguration.swift file
        let botName = "SmarlaFinance"
        let botRegion: AWSRegionType = AWSRegionType.EUWest1
        let botAlias = "$LATEST"
        
        // set up the configuration for AWS Voice Button
        let configuration = AWSServiceConfiguration(region: botRegion, credentialsProvider: AWSMobileClient.sharedInstance().getCredentialsProvider())
        let botConfig = AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: botName, botAlias: botAlias)
        
        // register the interaction kit client for the voice button using the AWSLexVoiceButtonKey constant defined in SDK
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: botConfig, forKey: AWSLexVoiceButtonKey)
        super.viewDidLoad()
        self.voiceButton.delegate = self
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        let serviceConfiguration = AWSServiceConfiguration(
            region: AWSRegionType.EUWest1,
            credentialsProvider: AWSMobileClient.sharedInstance().getCredentialsProvider())
        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
        
        self.fetchAccountBalances()
        self.fetchTransactions()
    }
    
    func fetchAccountBalances () {
        self.client!.accountsBalancesGet().continueWith(block: {(task: AWSTask) -> Any? in
            
            if let error = task.error {
                print("Error occurred: \(error)")
                // Handle error here
                return nil
            }
            
            let result = task.result!
            self.currentBalances = result
            DispatchQueue.main.async {
                self.refreshUI()
            }
            
            return nil
        })
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
    
    func refreshUI() {
        if (self.currentBalances != nil) {
            let totalValue = Float(self.currentBalances!.totalBalance.value)!
            self.totalBalance.text = String(Int(totalValue)) + "€"
            
            if (totalValue > 1200) {
                self.totalBalance.textColor = UIColor(red:0.12, green:0.54, blue:0.00, alpha:1.0)
            } else if (totalValue > 500) {
                self.totalBalance.textColor = UIColor(red:0.92, green:0.37, blue:0.03, alpha:1.0)
            } else {
                self.totalBalance.textColor = UIColor(red:0.75, green:0.03, blue:0.09, alpha:1.0)
            }
            
            self.collectionView.reloadData()
        }
        
        if (self.transactions != nil) {
            
            let allExpenses: [WAVETransaction] = (self.transactions?.latestTransactions.filter { $0.direction.value == 1 })!
            
            let expenses = allExpenses.filter { !($0.quickCategorization != nil) || $0.quickCategorization.categorizationType != "Transfer" }
            
            // Today
            let today = self.dateFormatter.string(from: Date())
            let todayTransactions: [WAVETransaction] = (expenses.filter { $0.transactionDate == today })
            let todayValue = todayTransactions.map { Float($0.transactionTotal.business.value)! }.reduce(0.0, +)
            self.todayExpenses.text = String(Int(todayValue)) + "€"
            
            // WTD
            let gregorian = Calendar(identifier: .gregorian)
            let startOfWeekDate = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
            let weekTransactions: [WAVETransaction] = (expenses.filter { self.dateFormatter.date(from: $0.transactionDate)! >= startOfWeekDate })
            let weekValue = weekTransactions.map { Float($0.transactionTotal.business.value)! }.reduce(0.0, +)
            self.weekExpenses.text = String(Int(weekValue)) + "€"
            
            // MTD
            let currentDateString = self.dateFormatter.string(from: Date())
            let currentDateSplit = currentDateString.split(separator: "-")
            let startOfMonth = currentDateSplit[0] + "-" + currentDateSplit[1] + "-01"
            let startOfMonthDate = self.dateFormatter.date(from: startOfMonth)!
            let monthTransactions = (expenses.filter { self.dateFormatter.date(from: $0.transactionDate)! >= startOfMonthDate })
            let monthValue = monthTransactions.map { Float($0.transactionTotal.business.value)! }.reduce(0.0, +)
            self.monthExpenses.text = String(Int(monthValue)) + "€"
            
        }
    }
    
    func voiceButton(_ button: AWSLexVoiceButton, on response: AWSLexVoiceButtonResponse) {
        // handle response from the voice button here
        print("on text output \(response.outputText)")
    }
    
    func voiceButton(_ button: AWSLexVoiceButton, onError error: Error) {
        // handle error response from the voice button here
        print("error \(error)")
    }
    
    @IBAction func logout(_ sender: Any) {
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "NavigationController")
            self.present(controller, animated: true, completion: nil)
        })
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let availableHeight = collectionView.frame.height
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: availableHeight / 5)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.currentBalances == nil) {
            return 0
        }
        
        return self.currentBalances!.accountBalances.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCell", for: indexPath) as! AccountBalanceCell
        
//        Style
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 5
        
//        Assign value
        let accountBalances = self.currentBalances!.accountBalances!
        let balance: WAVEBalanceWrapper = accountBalances[indexPath.row]
        
        let value = Float(balance.balance.value)!
        
        cell.accountName.text = balance.accountName!
        cell.accountBalance.text = String(Int(value)) + "€"
        return cell
    }
}
