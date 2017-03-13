//
//  Post.swift
//  instagram
//
//  Created by Ekko Lin on 3/12/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    var image: PFFile?
    var user: PFUser?
    var caption: String?
    
    
    init(object: PFObject) {
        image = object["media"] as? PFFile
        user = object["author"] as? PFUser
        caption = object["caption"] as? String
    }
    
    static let userDidLogOut = NSNotification.Name(rawValue: "UserDidLogout")
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image)   // PFFile column
        post["author"] = PFUser.current()
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object
        post.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
