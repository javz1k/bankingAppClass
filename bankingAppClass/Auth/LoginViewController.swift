import UIKit
import RealmSwift


class LoginViewController: UIViewController {
    
    //    let users = Users()
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        checkUser()
        print(#function)
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.isEnabled = false
    }
    
    func enablingLoginButton() {
        guard let mailInput = mailTextField.text, let passInput = passwordTextField.text else { return }
        if mailInput.count >= 3 && passInput.count >= 3 {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    func checkUser(){
        let realm = try! Realm()
        
        let inputEmail = mailTextField.text ?? ""
        let inputPassword = passwordTextField.text ?? ""
        
        let users = realm.objects(Users.self)
        print(users)
        guard let user = users.first(where: {$0.email == inputEmail}) else {
            print("notfound")
            let alert = UIAlertController(title: "User not found", message: "Pleace re-enter info or register", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Go to register", style:UIAlertAction.Style.default , handler: { ac in
                let vc = UIStoryboard(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier:"RegisterViewController") as? RegisterViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }))
                            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if user.password == inputPassword {
            print("access granted")
            let vc = UIStoryboard(name: "App", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                                navigationController?.pushViewController(vc!, animated: true)
            UserDefaultsHelper.setBool(key: "ud_key_isLogin", value: true)
            UserDefaultsHelper.setString(key: "ud_key_email", value: inputEmail)
        } else {
            print("access denied")
            let alert = UIAlertController(title: "Password error", message: "Pleace check password", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
            
                                self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case mailTextField, passwordTextField:
            enablingLoginButton()
            if textField.text?.count ?? 0 < 3 {
                textField.layer.borderWidth = 0.3
                textField.layer.borderColor = UIColor.red.cgColor
            } else {
                textField.layer.borderWidth = 0
            }
        default:
            textField.layer.borderWidth = 0
        }
    }
}
