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
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var submitPhotoButton: UIButton!
    
    
    var picture: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSubmitButton(_ sender: UIButton) {
        let resizedImage = self.resize(image: postImage.image!, newSize: CGSize(width: 400, height: 400))
        
        Post.postUserImage(image: resizedImage, withCaption: detailsField.text) { (success, error) in
            if success
            {
                self.showAlert(title: "Success", message: "Image Posted")
                self.clear()
            }
            else
            {
                self.showAlert(title: "Error", message: (error?.localizedDescription)!)
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func openAlbum(_ sender: UIButton) {
        let action = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        action.addAction(UIAlertAction(title: "Album", style: .default, handler: { (UIAlertAction) in
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .photoLibrary
            self.present(cameraPicker, animated: true, completion: nil)
            print ("using album")
        }))
        self.present(action, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String)
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) {_ in /*Some Code to Execute*/}
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    private func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x:0,y:0,width:newSize.width,height:newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    private func clear(){
        detailsField.text = ""
        detailsField.isEnabled = false
        submitPhotoButton.isEnabled = false
        postImage.image = nil
        addPhotoButton.isEnabled = true
        addPhotoButton.alpha = 1
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picture = image
        postImage.image = picture
        detailsField.isEnabled = true
        submitPhotoButton.isEnabled = true
        addPhotoButton.isEnabled = false
        addPhotoButton.alpha = 0
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
