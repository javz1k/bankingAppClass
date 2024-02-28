//
//  TransferViewController.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 05.02.24.
//

import UIKit

class TransferViewController: UIViewController {
    
//    var transferViewController = UIViewController(nibName: "TransferViewController", bundle: nil)
    
    @IBOutlet weak var transferNameTextField: UITextField!
    @IBOutlet weak var transferAmountTextField: UITextField!
    
    var amountCallback: ((String) -> Void)?
    var nameCallback: ((String) -> Void)?

    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var transferButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func transferAction(_ sender: UIButton) {
        amountCallback?(transferAmountTextField.text ?? "empty")
        nameCallback?(transferNameTextField.text ?? "empty")
        transferNameTextField.text = ""
        transferAmountTextField.text = ""
        print("transferButtonClicked \(transferNameTextField.text ?? "empty") and \(transferAmountTextField.text ?? "empty")")
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        print("cancel")
    }
    
}
