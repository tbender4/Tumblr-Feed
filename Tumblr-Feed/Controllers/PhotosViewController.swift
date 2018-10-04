//
//  PhotosViewController.swift
//  Tumblr-Feed
//
//  Created by Thomas Bender on 9/13/18.
//  Copyright © 2018 Thomas Bender. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire      //needed for network handling

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var photosTableView: UITableView!
  
  var posts: [[String: Any]] = []
  var refreshControl = UIRefreshControl()
  
  
  let alertController = UIAlertController(title: "Cannot Get Photos", message: "The Internet connection appears to be offline.", preferredStyle: .alert)
  //network handling
  func initAlert() {
    let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
      self.fetchPhotos()
    }
    alertController.addAction(tryAgainAction)
  }
  //end networking handling
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    photosTableView.delegate = self
    photosTableView.dataSource = self
    
    refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    photosTableView.insertSubview(refreshControl, at: 0)
    
    initAlert()
    fetchPhotos()
    
  }
  
  @objc func didPullToRefresh (_ refreshControl: UIRefreshControl) {
    fetchPhotos()
  }
  
  func fetchPhotos() {
    let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    let task = session.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print(error.localizedDescription)
        self.present(self.alertController, animated: true)
        
      } else if let data = data,
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
        //print(dataDictionary)
        
        let responseDictionary = dataDictionary["response"] as! [String: Any]
        self.posts = responseDictionary["posts"] as! [[String: Any]]
        // TODO: Reload the table view
        self.photosTableView.reloadData()
        self.refreshControl.endRefreshing()
        
      }
    }
    task.resume()
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //let cell = UITableViewCell()
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
    //cell.textLabel?.text = "This is row \(indexPath.row)"
    
    let post = posts[indexPath.row]
    if let photos = post["photos"] as? [[String: Any]] {
      //TODO: Get the URL
      let photo = photos[0]
      let originalsize = photo["original_size"] as! [String: Any]
      let urlString = originalsize["url"] as! String
      let url = URL(string: urlString)
      cell.photoImageView.af_setImage(withURL: url!)
      //self.photosTableView.reloadData()
    }
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    photosTableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc = segue.destination as! PhotoDetailsViewController
    let cell = sender as! UITableViewCell
    let indexPath = photosTableView.indexPath(for: cell)!
    
    let post = posts[indexPath.row]
    vc.post = post
    
    
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
