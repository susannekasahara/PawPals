//
//  lostpetVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 12/4/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class lostpetVC: UIViewController {
    
    @IBAction func currentLocButton(sender: AnyObject) {
    }
    
    @IBAction func homeLocButton(sender: AnyObject) {
    }

    @IBOutlet weak var streetAddressLost: UITextField!
    
    @IBOutlet weak var cityLost: UITextField!
    
    @IBOutlet weak var stateLost: UITextField!
    
    @IBOutlet weak var zipLost: UITextField!
    
    @IBAction func lostLocButton(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let lostAddress = streetAddressLost.text, let cityLost = cityLost.text, let stateLost = stateLost.text, let zipLost = zipLost.text else { return }
        
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
