//
//  MainCollectionViewCell.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 31.01.24.
//

import UIKit
import RealmSwift
import Realm

class MainCollectionViewCell: UICollectionViewCell {
    
    var card = Card()
    @IBOutlet weak var cardCollectionView:UICollectionView!
    //creating variable
    private var cardList : Results<Card>?
    //function that calls from controller to send data to here, and reloading
    func configureCardList(_ card : Results<Card>?){
        cardList = card
        cardCollectionView.reloadData()
    }
    //intitialazing callBack to sen HomeController
    var onScreenIndexPathCallBack : ((Int) -> Void)?
    var addFavoriteCard : ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: .main),
                                    forCellWithReuseIdentifier: "CardCollectionViewCell" )
    }

}


extension MainCollectionViewCell :UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cardItem = cardList?[indexPath.row] else {return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.configureCell(data: cardItem )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addFavoriteCard?(indexPath.row)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in cardCollectionView.visibleCells {
            let indexPath = cardCollectionView.indexPath(for: cell)
            guard let indexPath = indexPath else {return}
            onScreenIndexPathCallBack!(indexPath.row)
            print(indexPath.row)
        }
    }
}
