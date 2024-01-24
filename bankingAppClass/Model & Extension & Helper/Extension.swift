//
//  Extension.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 05.02.24.
//

import Foundation
import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}

extension String {
    func formattedCardNumber() -> String {
        var formattedString = ""
        var index = self.startIndex
        
        while index < self.endIndex {
            let nextIndex = self.index(index, offsetBy: 4, limitedBy: self.endIndex) ?? self.endIndex
            formattedString += String(self[index..<nextIndex])
            if nextIndex != self.endIndex {
                formattedString += " "
            }
            index = nextIndex
        }
        
        return formattedString
    }
}
