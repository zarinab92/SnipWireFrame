//
//  SignUpViewController.swift
//  SnipWireFrame
//
//  Created by Zarina Bekova on 8/11/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNametxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBAction func passwordType(_ sender: UITextField) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
//        uploadData()
        
        guard let firstNameTxt = firstNametxtField.text, !firstNameTxt.isEmpty else {
            displayMessage(userMessage: "All fields are required")
            return
        }
        
        guard let lastNameTxt = lastNameTxtField.text, !lastNameTxt.isEmpty else {
            displayMessage(userMessage: "All fields are required")
            return
        }
        
        guard let emailTxt = emailTxtField.text, !emailTxt.isEmpty else {
            displayMessage(userMessage: "All fields are required")
            return
        }
        
        guard let passwordTxt = passwordTxtField.text, !passwordTxt.isEmpty else {
            displayMessage(userMessage: "All fields are required")
            return
        }
        
        if passwordTxtField.text!.count < 8 {
            displayMessage(userMessage: "Password must contain at least 8 characters, including UPPER/lowercase and numbers")
        } else if passwordTxtField.text!.count > 8 {
            print("Button Clicked")
        }
        
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: "DetailViewController")
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: emailTxt, password: passwordTxt) { _, error in
            if error == nil {
                Auth.auth().signIn(withEmail: emailTxt, password: passwordTxt)
            } else {
                print("Error in createUser: \(error?.localizedDescription ?? "")")
            }
        }
        let ref = Database.database().reference()
        ref.child(firstNameTxt).setValue([
                "Fist Name" : firstNametxtField.text!,
                "Last Name" : lastNameTxtField.text!,
                "Email" :    emailTxtField.text!,
                "Password" : passwordTxtField.text!
            ])
    
    }
    
//    func uploadData () {
//
//
//     }
    
    @IBAction func facebookTapped(_ sender: UIButton) {
    }
    
    func displayMessage(userMessage: String) -> Void {
//        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
//        }
    }
    
}
