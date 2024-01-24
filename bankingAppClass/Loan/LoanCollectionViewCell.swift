//
//  LoanCollectionViewCell.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 23.02.24.
//

import UIKit

class LoanCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var loanImage: UIImageView!
    
    @IBOutlet weak var firstLabelTitle: UILabel!
    @IBOutlet weak var firstLabelSubtitle: UILabel!
    
    @IBOutlet weak var secondLabelTitle: UILabel!
    @IBOutlet weak var secondLabelSubtitle: UILabel!
    
    @IBOutlet weak var thirdLabelTitle: UILabel!
    @IBOutlet weak var thirdLabelSubtitle: UILabel!
    
    @IBAction func orderButton(_ sender: Any) {
        print(#function)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
