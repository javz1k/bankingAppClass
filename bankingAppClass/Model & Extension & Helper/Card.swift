//
//  Cards.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 18.02.24.
//

import Foundation
import RealmSwift

class Card: Object, CardCollectionViewCellProtocol {
 
    
    
    @Persisted var cardId: String?
    @Persisted var cardname:String?
    @Persisted var cardtype:String?
    @Persisted var amount = 0.0
    @Persisted var isFavorite:Bool?
    @Persisted var pan: String?
    
    override static func primaryKey() -> String? {
        return "cardId"
    }
    
    var cardnameText: String {
        cardname ?? ""
    }
    
    var amountText: String {
        String(amount) 
    }
    
    var cardTypeText: String {
        cardtype ?? ""
    }
    
    var cardPan: String {
        pan ?? ""
    }
    var cardPanText: String {
        cardPan.formattedCardNumber()
    }
    
    var isFavoriteImage: String {
        
        return (isFavorite ?? false) ? "heart.fill" : "heart"
    }
}
