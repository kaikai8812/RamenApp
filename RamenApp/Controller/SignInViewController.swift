//
//  SignInViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/28.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.layer.cornerRadius = 20.0
        signInButton.layer.cornerRadius = 20.0
        
        textField.text = Auth.auth().currentUser?.uid

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signinAction(_ sender: Any) {
        
        if textField.text == Auth.auth().currentUser?.uid {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
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
