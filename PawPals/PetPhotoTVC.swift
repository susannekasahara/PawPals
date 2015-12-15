//
//  TableViewController.swift
//  PawPals
//
//  Created by Susanne Burnham on 11/29/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class PetPhotoTVC: UITableViewController {
    
   
    
    @IBOutlet var petTableView: UITableView!

    
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            
            //navigationController?.navigationBarHidden = false
            
            // run request to rails to pull all actors
            
            
            
            let rr = RailsRequest.session()
            
            var info = RequestInfo()
            
            info.endpoint = "pets"
            info.method = .GET
            
            print(info)
            
            rr.requestWithInfo(info) { (returnedInfo) -> () in
                
                print(returnedInfo)
                
                self.users = returnedInfo?["pets"] as? [[String:AnyObject]] ?? []
                
                self.tableView.reloadData()
                
            }
        }
        
        var users: [[String:AnyObject]] = []
        
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            
            //self.navigationController?.navigationBarHidden = false
            
            tableView.reloadData()
            
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        func petTableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return users.count
        }
        
        
        func petTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            // #warning Incomplete implementation, return the number of rows
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier("petCell", forIndexPath: indexPath) as! petCell
            
            guard let pet = users[indexPath.row]["pets"] as? [String:AnyObject] else { return cell }
            
            cell.petInfo = pet
            
            cell.petNameCLabel.text = pet["name"] as? String
            
            cell.petAgeCLabel.text = pet["age"] as? String
            
            cell.petBreedCLabel.text = pet["breed"] as? String
            
//            cell.petDescriptionCLabel.text = user["description"] as? String
            
            let dispatch = dispatch_queue_create("tableView", DISPATCH_QUEUE_SERIAL)
            
            if let petImageCView = pet["picture"] as? String {
                
                cell.petImageCView.hidden = false
                
                dispatch_async(dispatch) { () -> Void in
                    
                    if let url = NSURL(string: petImageCView) {
                        
                        if let data = NSData(contentsOfURL: url) {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                if let image = UIImage(data:data) {
                                    
                                    cell.petImageCView.image = image
                                    
                                }
                                
                            })
                        }
                    }
                    
                }
                
            } else {
                
                cell.petImageCView.hidden = true
            }
            
            
            return cell
            
        }
        
        /*
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        // Configure the cell...
        
        return cell
        }
        */
        
        /*
        // Override to support conditional editing of the table view.
        override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
        }
        */
        
        /*
        // Override to support editing the table view.
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        // Delete the row from the data source
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        }
        */
        
        /*
        // Override to support rearranging the table view.
        override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        }
        */
        
        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
        }
        */
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
            if segue.identifier == "Detail" {
                
                guard let cell = sender as? petCell else { return }
                guard let indexPath = tableView.indexPathForCell(cell) else { return }
                
                let detailVC = segue.destinationViewController as? ProfileVC
                
                detailVC?.petInfo = cell.petInfo
                
            }
            
            
        }
        
}
