//
//  Users.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 26.01.24.
//

import Foundation
import RealmSwift

class Users: Object {
    @Persisted var userId: String?
    @Persisted var name:String?
    @Persisted var surname:String?
    @Persisted var email:String?
    @Persisted var password:String?
    @Persisted var amount = 0.0
    
    
    override static func primaryKey() -> String? {
        return "userId"
    }
}
