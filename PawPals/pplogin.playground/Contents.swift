//: Playground - noun: a place where people can play

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailLoginField: UITextField!
    
    @IBOutlet weak var passwordLoginField: UITextField!
    
    
    @IBAction func loginButton(sender: AnyObject) {
        
        guard let email = emailLoginField.text else { return }
        guard let  password = passwordLoginField.text else { return }
    
        RailsRequest.session().loginWithUsername(email, andPassword: password, success: { didLogin in
            
            if didLogin {
                
                let loginstoryboard = UIStoryboard(name: "loginStoryboard", bundle: nil)
                
                let VC = WKstoryboard.instantiateViewControllerWithIdentifier("VC")
                
                self.presentViewController(VC, animated: true, completion: nil)
                
                
            } else {
                
                // throw an alert error that login failed
                
            }
            
        })
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
}



