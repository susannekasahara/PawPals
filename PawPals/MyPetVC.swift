//
//  MyPetVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 11/30/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class MyPetVC: UIViewController, UITextFieldDelegate {
    
    var savedImages: [String] = []
    
    var imagePicker = UIImagePickerController()
    
    var imageURLString: String = ""
    
    @IBOutlet weak var petnameField: UITextField!
    
    @IBOutlet weak var petageField: UITextField!
    
    @IBOutlet weak var petbreedField: UITextField!
    
    @IBOutlet weak var petdescriptField: UITextView!
    
    @IBOutlet weak var petpictureField: UIImageView!
    
    @IBAction func takephotoButton(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func galleryphotoButton(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            
        }
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        petpictureField.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func profilesubmitButton(sender: AnyObject) {
        
        var imageData = UIImageJPEGRepresentation(petpictureField.image!, 0.6)
        var compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        var alert = UIAlertController(title: "WHATS UP", message: "🎉🎉🎉🎉🎉", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        
        
        guard let petName = petnameField.text, let petAge = petageField.text, let petBreed = petbreedField.text, let petDescription = petdescriptField.text  else { return }
        
        print("registerig pet")
        
        RailsRequest.session().profileWithUsername(petName, petAge: petAge, petBreed: petBreed, petDescription: petDescription, petImageURL: imageURLString) { (success) -> () in
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:
            UIKeyboardWillShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);

        print(RailsRequest.session().token)
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        if petnameField.isFirstResponder()  {
            
            print(petnameField.isFirstResponder()) // test for nameSearchField
            
            
            
        } else {
            
            self.view.frame.origin.y = -150
        }
    }
    func keyboardWillHide(sender: NSNotification) {
        
        self.view.frame.origin.y = 0
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }

    
}

extension MyPetVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        defer { picker.dismissViewControllerAnimated(true, completion: nil) }
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return}
        
        
        let s3manager = AFAmazonS3Manager(accessKeyID: accessID, secret: secretKey)
        
        s3manager.requestSerializer.bucket = "skphotos"
        s3manager.requestSerializer.region = AFAmazonS3USStandardRegion
        
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let filepath = paths[0] + "/image.png"
        
        UIImagePNGRepresentation(image)?.writeToFile(filepath, atomically: true)
        
        let date = Int(NSDate().timeIntervalSince1970)
        
        s3manager.putObjectWithFile(filepath, destinationPath: "image_\(date).png", parameters: nil, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
            
            let percent = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
            
            print(percent)
            
            }, success: { (response) -> Void in
                
                if let urlResponse = response as? AFAmazonS3ResponseObject {
                    
                    if let url = urlResponse.URL?.absoluteString {
                        
                        
                        self.imageURLString = url
                        // send request to rails with "url"
                        
                       
                    }
                }
                
            }) { (error) -> Void in
                
                print (error)
                
        }
        
        // save image to S3
        // get URL and add to array of URLs
        // tell collectionView to reload
        
    }
    
    
}

        
extension MyPetVC: UICollectionViewDataSource, UICollectionViewDelegate {
            
            func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
                return savedImages.count
            }
            
            func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
                
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath)
                
                for v in cell.contentView.subviews {
                    
                    v.removeFromSuperview()
                }
                
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
                
                // to do add image from URL
                
                let imageURLString = savedImages[indexPath.item]
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
                    
                    // run code on background thread
                    let data = NSData(contentsOfURL: NSURL(string: imageURLString)!)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        //run code on main thread
                        
                        imageView.image = UIImage(data: data!)
                        
                    })
                    
                    
                }
                
                cell.contentView.addSubview(imageView)
                
                return cell
            }
}
            

        
        
    
