//
//  AddCardViewController.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 22.02.24.
//

import Foundation
import UIKit

class AddCardViewController : UIViewController{
    
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardPanTextField: UITextField!
    @IBOutlet weak var cardTypeTextField: UITextField!
    
    @IBOutlet weak var addCardAddButton: UIButton!
    @IBOutlet weak var addCardCancelButton: UIButton!
    
    var addDataCallBack:(([String])-> Void)?
    
    @IBAction func addCardCancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        print("addCancel")
    }
    
    @IBAction func addCardAddButton(_ sender: Any) {
        var addDataArrayFromTextField = [String]()
        let name = cardNameTextField.text ?? "error"
        let pan = cardPanTextField.text ?? "error"
        let type = cardTypeTextField.text ?? "error"
        addDataArrayFromTextField += [name, pan, type]
        print(addDataArrayFromTextField, "addDataArrayFromTextField from add controller")
        addDataCallBack?(addDataArrayFromTextField)
        print("addAdd!")
        
    }
    
}
