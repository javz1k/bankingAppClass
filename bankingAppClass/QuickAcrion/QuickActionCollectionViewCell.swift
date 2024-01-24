//
//  QuickActionCollectionViewCell.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 31.01.24.
//

import UIKit
import RealmSwift


protocol QuickActionCellProtocol: AnyObject {
    func quickActionCellClicked(index: Int)
}


class QuickActionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView:UICollectionView!
    //creating variable
    var quickActionList:[ActionCellModel]?
        //function that calls from controller to send data to here, and reloading
    func configureQuickActionList(_ list: [ActionCellModel]?){
        quickActionList = list
        collectionView.reloadData()
    }

    weak var delegate: QuickActionCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "QuickActionCell", bundle: .main),
                                    forCellWithReuseIdentifier: "QuickActionCell")
    }

}

extension QuickActionCollectionViewCell :UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quickActionList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickActionCell", for: indexPath) as! QuickActionCell
        cell.buttonImageView.image = UIImage(systemName: quickActionList?[indexPath.row].iconString ?? "")
        cell.contentMode = .scaleToFill
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? QuickActionCell else { return }
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOpacity = 0.5
                cell.layer.shadowOffset = CGSize(width: 0, height: 2)
                cell.layer.shadowRadius = 6
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? QuickActionCell else { return }
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOpacity = 0.5
                cell.layer.shadowOffset = CGSize(width: 0, height: 2)
                cell.layer.shadowRadius = 6
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.quickActionCellClicked(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 72, height: 72)
    }
}
