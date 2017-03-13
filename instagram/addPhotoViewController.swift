//
//  addPhotoViewController.swift
//  instagram
//
//  Created by Ekko Lin on 3/12/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class addPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    let imagePick = UIImagePickerController()
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.postImage.isHidden = true
        imagePick.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSubmitButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Get the image captured by the UIImagePickerController
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // Do something with the images (based on your use case)
            print("Image fetching successfully")
            postImage.contentMode = .scaleAspectFit
            postImage.image = originalImage
            self.postImage.isHidden = false
        }
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
