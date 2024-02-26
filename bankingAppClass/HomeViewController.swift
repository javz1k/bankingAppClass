//
//  HomeViewController.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 29.01.24.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    
    let realm = try! Realm()
    let users = Users()
    let card = Card()
    
    var nameTextFieldTransfer: String?
    var amountTextFieldTransfer: String?
    
    //recieving data from deleteViewController Callback
    fileprivate var DeletingCardName:String?
    
    
    //initialazing variables that contains list
    private var cardList : Results<Card>?
    private var actionList : [ActionCellModel]?
    
    //func for recieving data onScreenIndex from callBack
    fileprivate var onScreenCardIndexPath : Int?
    fileprivate func onScreenCardIndexPathFunc(id : Int) {
        onScreenCardIndexPath = id
        print("this is delete index from homeviewcontroller \(id)")
    }
    
    fileprivate func addFavorite(id : Int) {
        guard let favoriteItem = cardList?.first(where: {$0.isFavorite == true}) else {return}
        guard let cardItem = cardList?[id], cardItem.cardId != favoriteItem.cardId else {return}
        try! realm.write {
            favoriteItem.isFavorite = false
            realm.add(favoriteItem)
            cardItem.isFavorite = true
            realm.add(cardItem)
        }
        getCardList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //calling functions that creates CardList and ActionList
        getCardList()
        createActionList()
        mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "MainCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "QuickActionCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "QuickActionCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "EmptyCardCell", bundle: nil),
                                    forCellWithReuseIdentifier: "EmptyCardCell")
        
        
    }
    
    //getting card list from Realm base
    fileprivate func getCardList(){
        let realm = try! Realm()
        cardList =  realm.objects(Card.self)
        mainCollectionView.reloadData()
    }
    
    //creating action list, filling the struct actionModel from Realm base
    func createActionList() {
        actionList = [
            ActionCellModel(id: 1, iconString: "plus"),
            ActionCellModel(id: 2, iconString: "trash"),
            ActionCellModel(id: 3, iconString: "percent"),
            ActionCellModel(id: 4, iconString: "arrowshape.right"),
        ]
    }
    
}

extension HomeViewController :UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cardList = cardList else {return UICollectionViewCell()}
            if cardList.isEmpty{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCardCell", for: indexPath) as! EmptyCardCell
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
                //calling configure function from cardViewCell
                cell.configureCardList(cardList)
                //calling callback for onscreen card index
                
                cell.onScreenIndexPathCallBack = { [weak self] id in
                    guard let self = self else {return}
                    self.onScreenCardIndexPathFunc(id: id)
                }
                
                cell.addFavoriteCard = { [weak self] id in
                    guard let self = self else {return}
                    self.addFavorite(id: id)
                }
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickActionCollectionViewCell", for: indexPath) as! QuickActionCollectionViewCell
            cell.delegate = self
            //calling configure function from actionViewCell
            cell.configureQuickActionList(actionList)
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            CGSize(width: collectionView.frame.width-24, height: collectionView.frame.height*0.35)
        } else {
            CGSize(width: collectionView.frame.width-24, height: 80)
        }
        
    }
    
}



extension HomeViewController: QuickActionCellProtocol {
    func quickActionCellClicked(index: Int) {
        print(index, #function)
        quickActionNavigate(index: index)
    }
}




extension HomeViewController {
    fileprivate func quickActionNavigate(index: Int) {
        switch index {
        case 0:
            createBrain()
            break
        case 1:
            deleteBrain()
            break
        case 2:
            loanBrain()
            break
        case 3:
            transferBrain()
            break
        case 4:
            break
        case 5:
            break
        default: break
        }
    }
    
    fileprivate func loanBrain(){
        let vc = UIStoryboard.init(name: "App", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoanViewController") as! LoanViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    fileprivate func deleteBrain(){
        
        let vc = UIStoryboard.init(name: "App", bundle: Bundle.main).instantiateViewController(withIdentifier: "DeleteCardViewController") as! DeleteCardViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        vc.deleteCallBack = { [weak self] data in
            guard let self = self else {return}
            print("homeViewdeleteBrainData\(data)")
            DeletingCardName = data
            
            let realm = try! Realm()
            let selectedCard = realm.objects(Card.self).where {
                $0.cardname == self.DeletingCardName
            }.first!
            
            try! realm.write {
                realm.delete(selectedCard)
            }
            realm.refresh()
            self.mainCollectionView.reloadData()
            self.navigationController?.popViewController(animated: true)
            
        }
        
        
        
    }
    
    fileprivate func createBrain(){
        
        let vc = UIStoryboard.init(name: "App", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCardViewController") as! AddCardViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.addDataCallBack = { [weak self] DataArray in
            print("this is from home callback\(DataArray)")
            self?.card.cardname = DataArray[0]
            self?.card.cardtype = DataArray[2]
            self?.card.pan = DataArray[1]
            
            self?.card.cardId = UUID().uuidString
            self?.card.amount = 0.0
            self?.card.isFavorite = false
            try! self?.realm.write{
                self?.realm.add(self!.card)
            }
            self?.realm.refresh()
            self?.mainCollectionView.reloadData()
            self?.navigationController?.popViewController(animated: true)

        }
        
    }
    
    
    
    fileprivate func transferBrain() {
        let vc = TransferViewController.loadFromNib()
        self.navigationController!.pushViewController(vc, animated: true)
        
        vc.amountCallback = { [weak self] amount in
            guard let self = self else {return}
            dump(amount)
            self.amountTextFieldTransfer = amount
        }
        
        vc.nameCallback = { [weak self] name in
            guard let self = self else {return}
            dump(name)
            self.nameTextFieldTransfer = name
            self.transfer()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func transfer() {
        let allUsers = self.realm.objects(Users.self)
        let userSelf = allUsers.first(where: {$0.email == UserDefaultsHelper.getString(key: "ud_key_email")})
        let toUser = allUsers.first(where: {$0.name == self.nameTextFieldTransfer})
        let amount = Double(amountTextFieldTransfer ?? "0")
        print("this is userfrom \(userSelf?.name ?? "")")
        print("this is userto\(toUser?.name ?? "")")
        guard let amountGuarded = amount else {return}
        if amountGuarded > (userSelf?.amount ?? 0.0) {
            print("insufficient funds in the account")
            return
        }
        try? self.realm.write {
            guard let from = userSelf, let to = toUser else {return}
            from.amount -= amountGuarded
            to.amount += amountGuarded
        }
        self.realm.refresh()
    }
    
}
