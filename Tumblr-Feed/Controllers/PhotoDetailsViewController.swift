//
//  PhotoDetailsViewController.swift
//  Tumblr-Feed
//
//  Created by Thomas Bender on 9/27/18.
//  Copyright © 2018 Thomas Bender. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

  @IBOutlet weak var photoImageView: UIImageView!
  var post: [String : Any] = [:]
  
  
  

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(post)

      //similar to tableView
      if let photos = post["photos"] as? [[String: Any]] {
        print(photos)
        let photo = photos[0]
        let originalsize = photo["original_size"] as! [String: Any]
        let urlString = originalsize["url"] as! String
        let url = URL(string: urlString)
        photoImageView.af_setImage(withURL: url!)
      }
      
    }
  
  let photoURL = URL(string: "")

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
