//
//  instagramViewController.swift
//  instagram
//
//  Created by Ekko Lin on 3/12/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class instagramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set table
        tableView.delegate = self
        tableView.dataSource = self
        
        // Load data
        self.retrievePosts()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Logout
    @IBAction func onLogoutButton(_ sender: UIBarButtonItem) {
        PFUser.logOutInBackground { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                NotificationCenter.default.post(name: Post.userDidLogOut, object: nil)
                self.dismiss(animated: true, completion: nil)
                print("logout successfully")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! photoCell
        let post = self.posts[indexPath.row]
        cell.post = post
        
        return cell
    }
    
    func retrievePosts() {
        // construct query
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        MBProgressHUD.showAdded(to: self.view, animated: true)
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let posts = posts{
                print("Today is \(Date())")
                for post in posts{
                    self.posts.append(Post(object: post))
                }
                self.tableView.reloadData()
            }else{
                print(error?.localizedDescription)
            }
        }
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
