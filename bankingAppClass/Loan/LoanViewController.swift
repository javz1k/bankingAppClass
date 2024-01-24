//
//  LoanViewController.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 23.02.24.
//

import Foundation
import UIKit

class LoanViewController: UIViewController {
    
    var loanList = [LoanModel]()
    
    
    @IBOutlet weak var LoanCollectionView: UICollectionView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureLoanList()
        LoanCollectionView.delegate = self
        LoanCollectionView.dataSource = self
        
        
        LoanCollectionView.register(UINib(nibName: "LoanCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "LoanCollectionViewCell")
    }
    
    func configureLoanList(){
        loanList = [
        LoanModel(loanImage: "yelo1",firstLabelTitle: "Cash Loan",firstLabelSubtitle:"For a better life", secondLabelTitle: "Amount",
                 secondLabelSubtitle:"400 - 50000 AZN",thirdLabelTitle: "Therm", thirdLabelSubtitle:"6 - 59 mounth"),
        
        LoanModel(loanImage: "yelo2",firstLabelTitle: "Business Loan",firstLabelSubtitle:"B2B & B2C", secondLabelTitle: "Amount",
                 secondLabelSubtitle:"50000 - 2000000 AZN",thirdLabelTitle: "Annual interest rate", thirdLabelSubtitle:"AZN - min 11% USD min 3%"),
        
        LoanModel(loanImage: "yelo3",firstLabelTitle: "Online Loan",firstLabelSubtitle:"Completely online banking", secondLabelTitle: "Annual Interest Rate",
                 secondLabelSubtitle:"Starting from 11.7%",thirdLabelTitle: "Amount", thirdLabelSubtitle:"Up to 50000 AZN"),
        
        LoanModel(loanImage: "yelo4",firstLabelTitle: "Loan secured by real estate",firstLabelSubtitle:"Mortgage loan with any real estate", secondLabelTitle: "Amount",
                 secondLabelSubtitle:"5000 - 100000",thirdLabelTitle: "Therm", thirdLabelSubtitle:"12 - 54 mounth"),
        
        LoanModel(loanImage: "yelo5",firstLabelTitle: "Loan secured by deposit",firstLabelSubtitle:"For your confident use", secondLabelTitle: "Term",
                 secondLabelSubtitle:"Till the end of deposite term",thirdLabelTitle: "Annual interest rate", thirdLabelSubtitle:"Annual interest rate + 3%"),
        ]
    }
    
}

extension LoanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loanList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "LoanCollectionViewCell", for: indexPath) as! LoanCollectionViewCell
        item.firstLabelTitle.text = loanList[indexPath.row].firstLabelTitle
        item.firstLabelTitle.text = loanList[indexPath.row].firstLabelSubtitle
        
        item.secondLabelTitle.text = loanList[indexPath.row].secondLabelTitle
        item.secondLabelSubtitle.text = loanList[indexPath.row].secondLabelSubtitle
        
        item.thirdLabelTitle.text = loanList[indexPath.row].thirdLabelTitle
        item.thirdLabelSubtitle.text = loanList[indexPath.row].thirdLabelSubtitle
        
        item.loanImage.image = UIImage(named: loanList[indexPath.row].loanImage ?? "error")
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 12, height: collectionView.frame.height - 12)
    }
    
    
}
