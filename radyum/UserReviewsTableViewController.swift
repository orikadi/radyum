//
//  UserReviewsTableViewController.swift
//  radyum
//
//  Created by Studio on 12/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class UserReviewsTableViewController: UITableViewController {
    var user:User?
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
    @IBAction func backAction(_ sender: Any) {
        performSegue(withIdentifier: "returnToProfile", sender: self)
    }
    
    @objc func reloadData(){
          //get all reviews for this user
        Model.instance.getAllReviewsByUserEmail(userEmail: user!.email) { (_data:[Review]?) in
               if (_data != nil) {
                   self.data = _data!;
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
           let cell:UserReviewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UserReviewCell", for: indexPath) as! UserReviewsTableViewCell
           let review = data[indexPath.row]
           cell.reviewText.text = review.text
           cell.reviewImage.image = UIImage(named: "picture") //named: picture ?
           if review.picture != "" {
               cell.reviewImage.kf.setImage(with: URL(string: review.picture))
           }
           return cell
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              selected = data[indexPath.row]
              performSegue(withIdentifier: "fromUserReviewsToReviewDisplay", sender: self)
          }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if (segue.identifier == "fromUserReviewsToReviewDisplay") {
                  let vc:DisplayReviewViewController = segue.destination as! DisplayReviewViewController
                vc.review = selected
                vc.restaurantName = selected?.resName
                vc.returnTo = "UserReviewsTableViewController"
              }
          }
    
    @IBAction func toUserReviewsTable(segue:UIStoryboardSegue){}

    
}
