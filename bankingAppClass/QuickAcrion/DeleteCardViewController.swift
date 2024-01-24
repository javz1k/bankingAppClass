//
//  DeleteCardViewController.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 23.02.24.
//

import UIKit

class DeleteCardViewController: UIViewController {
    
    var deleteCallBack:((String)-> Void)?
    
    @IBOutlet weak var deleteNameTextField: UITextField!
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        print("delete deleteCardViewController")
        deleteCallBack?(deleteNameTextField.text ?? "error from delete deleteCardViewController")
        deleteNameTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
