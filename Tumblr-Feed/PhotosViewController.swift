//
//  PhotosViewController.swift
//  Tumblr-Feed
//
//  Created by Thomas Bender on 9/13/18.
//  Copyright © 2018 Thomas Bender. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var photosTableView: UITableView!
  @IBOutlet weak var photoTableViewCell: UITableViewCell!
  
  var posts: [[String: Any]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    photosTableView.delegate = self
    photosTableView.dataSource = self
    
    fetchPhotos()
  
  }
  
  func fetchPhotos() {
    let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    let task = session.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print(error.localizedDescription)
      } else if let data = data,
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
        //print(dataDictionary)
        
        let responseDictionary = dataDictionary["response"] as! [String: Any]
        self.posts = responseDictionary["posts"] as! [[String: Any]]
        // TODO: Reload the table view
        self.photosTableView.reloadData()
      }
    }
    task.resume()
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  

  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "This is row \(indexPath.row)"
    
    return cell
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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