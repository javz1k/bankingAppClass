//
//  RegisterViewController.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 24.01.24.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {
    
    
    let users = Users()
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var regPasswordTextField: UITextField!
    @IBOutlet weak var regMailTextField: UITextField!
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        if (nameTextField.text?.count ?? 0) < 3 || (surnameTextField.text?.count ?? 0) < 3 || (regPasswordTextField.text?.count ?? 0) < 3 || (regMailTextField.text?.count ?? 0) < 3 {
            let alert = UIAlertController(title: "Register error", message: "Must be at least 3 characters", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let okAlert = UIAlertController(title: "Success", message: "Register accomplish", preferredStyle: UIAlertController.Style.alert)
            okAlert.addAction(UIAlertAction(title: "Complited", style: UIAlertAction.Style.default) { _ in
                // Move the popping action inside the completion handler
                self.navigationController?.popViewController(animated: true)
            })
            self.present(okAlert, animated: true, completion: nil)
            createData()
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        surnameTextField.delegate = self
        regPasswordTextField.delegate = self
        regMailTextField.delegate = self
        
    }

    
    func createData(){
        users.userId = UUID().uuidString
        users.name = nameTextField.text ?? "error"
        users.surname = surnameTextField.text ?? "error"
        users.email = regMailTextField.text ?? "error"
        users.password = regPasswordTextField.text ?? "error"
        users.amount = 100.0
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(users)
        }
    }
    
}

extension RegisterViewController : UITextFieldDelegate{
    
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField{
        case nameTextField:
            if nameTextField.text?.count ?? 0 < 3 {
                textField.layer.borderWidth = 0.3
                textField.layer.borderColor  =  UIColor.red.cgColor
            }else{
                textField.layer.borderWidth  = 0
            }
        case surnameTextField:
            if surnameTextField.text?.count ?? 0 < 3 {
                textField.layer.borderWidth = 0.3
                textField.layer.borderColor  =  UIColor.red.cgColor
            }else{
                textField.layer.borderWidth  = 0
            }
        case regPasswordTextField:
            if regPasswordTextField.text?.count ?? 0 < 3 {
                textField.layer.borderWidth = 0.3
                textField.layer.borderColor  =  UIColor.red.cgColor
            }else{
                textField.layer.borderWidth  = 0
            }
        case regMailTextField:
            if regMailTextField.text?.count ?? 0 < 3 {
                textField.layer.borderWidth = 0.3
                textField.layer.borderColor  =  UIColor.red.cgColor
            }else{
                textField.layer.borderWidth  = 0
            }
            
        default:
            textField.layer.borderWidth  = 0
        }
    }
   

}
