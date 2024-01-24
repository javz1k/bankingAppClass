//
//  UserDefaultsHelper.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 31.01.24.
//

import Foundation

final class UserDefaultsHelper{
    static let defaults = UserDefaults.standard
    
    static func setBool(key:String, value:Bool){
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func setString(key:String, value:String?){
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    
    
    static func getBool(key:String) -> Bool{
        return defaults.bool(forKey: key)
    }
    
    
    static func getString(key:String) -> String?{
        return defaults.string(forKey: key)
    }
    
    static func remove(key:String){
        defaults.removeObject(forKey: key)
        defaults.synchronize()  
    }
}
