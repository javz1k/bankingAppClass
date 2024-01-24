//
//  CardCollectionViewCell.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 31.01.24.
//

import UIKit

protocol CardCollectionViewCellProtocol {
    var cardnameText: String {get}
    var amountText: String {get}
    var cardTypeText: String {get}
    var cardPanText: String {get}
    var isFavoriteImage: String {get}
}

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var cardName: UILabel!
    @IBOutlet weak private var cardAmount: UILabel!
    @IBOutlet weak private var cardType: UILabel!
    @IBOutlet weak private var cardPan: UILabel!
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(data: CardCollectionViewCellProtocol) {
        cardName.text = data.cardnameText
        cardAmount.text = data.amountText
        cardType.text = data.cardTypeText
        cardPan.text = data.cardPanText
        favoriteImageView.image = UIImage(systemName: data.isFavoriteImage) 
    }
}
