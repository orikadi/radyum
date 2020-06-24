//
//  FeedPageTableViewController.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class FeedPageTableViewController: UITableViewController {
    
    var data = [Review]()
    var selected:Review?

    override func viewDidLoad() {
         super.viewDidLoad()
               self.refreshControl = UIRefreshControl()
               self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
                  
               ModelEvents.ReviewDataEvent.observe {
                     self.refreshControl?.beginRefreshing()
                     self.reloadData();
               }
               self.refreshControl?.beginRefreshing()
               reloadData();
    }
    
    @objc func reloadData(){
       Model.instance.getAllReviews { (_data:[Review]?) in
       if (_data != nil) {
           self.data = _data!.reversed();
           self.tableView.reloadData();
           }
           self.refreshControl?.endRefreshing()
       };
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell:FeedPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedPageCell", for: indexPath) as! FeedPageTableViewCell
           let review = data[indexPath.row]
           cell.resNameLabel.text = review.resName
           cell.userNameLabel.text = review.userName
           cell.reviewImage.image = UIImage(named: "picture")
           if review.picture != "" {
               cell.reviewImage.kf.setImage(with: URL(string: review.picture))
           }

           return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = data[indexPath.row]
        performSegue(withIdentifier: "fromFeedPageToReviewDisplay", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "fromFeedPageToReviewDisplay") {
             let vc:DisplayReviewViewController = segue.destination as! DisplayReviewViewController
             vc.review = selected
             vc.restaurantName = selected?.resName
            vc.returnTo = "FeedPageTableViewController"
         }
     }
    
  
    
    @IBAction func backToFeed(segue:UIStoryboardSegue){}

}
