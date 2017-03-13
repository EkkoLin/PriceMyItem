//
//  instagramViewController.swift
//  instagram
//
//  Created by Ekko Lin on 3/12/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse

class instagramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject]?
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set table
        tableView.delegate = self
        tableView.dataSource = self
        
        // Refresh
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        // Load data
        self.fetchPost()
        
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
        if let posts = posts {
            return posts.count
        }
        else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! photoCell
        let post = self.posts?[indexPath.row]
        cell.post = post
        
        return cell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        // Refresh once then stop
        fetchPost()
        refreshControl.endRefreshing()
    }
    
    private func fetchPost(){
        User.fetchPosts(sucess: { (object: [PFObject]?) -> () in
            
            self.posts = object
            self.tableView.reloadData()
            
        }) { (error: NSError?) -> () in
            
            print("Unable to retrieve data")
        }
    }
}

    class User: PFUser {
        class func fetchPosts(sucess: @escaping ([PFObject]?) -> (), failure: @escaping (NSError?) -> () )
        {
            let query = PFQuery(className: "Post")
            query.order(byDescending: "createdAt")
            query.includeKey("updated_at")
            query.includeKey("author")
            query.limit = 20
            
            // fetch data asynchronously
            query.findObjectsInBackground { (posts, error) in
                if let posts = posts
                {
                    sucess(posts)
                }
                else
                {
                    failure(error as NSError?)
                }
            }
        }
        
        class func fetchMyPosts(sucess: @escaping ([PFObject]?) -> (), failure: @escaping (NSError?) -> () )
        {
            let query = PFQuery(className: "Post")
            query.whereKey("author", equalTo: PFUser.current()!)
            query.order(byDescending: "createdAt")
            query.includeKey("updated_at")
            query.includeKey("author")
            query.limit = 20
            
            // fetch data asynchronously
            query.findObjectsInBackground { (posts, error) in
                if let posts = posts
                {
                    sucess(posts)
                }
                else
                {
                    failure(error as NSError?)
                
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
