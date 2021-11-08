//
//  LoginViewController.swift
//  SnipWireFrame
//
//  Created by Zarina Bekova on 8/11/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [UIColor.init(cgColor: .init(srgbRed: 255, green: 138, blue: 216, alpha: 100)), UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = view.bounds

        view.layer.insertSublayer(gradient, at: 0)

    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        guard let emailTxt = emailTextField.text, !emailTxt.isEmpty else {
            displayMessage(userMessage: "All fields are required")
            return
        }
        
        guard let passwordTxt = passwordTxtField.text, !passwordTxt.isEmpty else {
            displayMessage(userMessage: "All fields are required")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: emailTxt, password: passwordTxt) {  [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                // show account creation
                strongSelf.showCreateAccount(email: emailTxt, password: passwordTxt)
                
                
                return
            }
            
            print("You have signed in")
            strongSelf.emailTextField.isHidden = true
            strongSelf.passwordTxtField.isHidden = true
           
        }
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    // show account creation
                    print("Account creation failed")
                    return
                }
                
                print("You have signed in")
                strongSelf.emailTextField.isHidden = true
                strongSelf.passwordTxtField.isHidden = true
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayMessage(userMessage: String) -> Void {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
