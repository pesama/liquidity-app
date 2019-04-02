//
//  TransactionTableCell.swift
//  Finances
//
//  Created by Margareto, Pelayo on 31/03/2019.
//  Copyright © 2019 Smarla. All rights reserved.
//

import Foundation
import UIKit

class TransactionTableCell: UITableViewCell {
    
    @IBOutlet weak var transactionName: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var transactionValue: UILabel!
    @IBOutlet weak var accountName: UILabel!
}
