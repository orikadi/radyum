//
//  RestaurantReviewsTableViewController.swift
//  radyum
//
//  Created by Studio on 11/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class RestaurantReviewsTableViewController: UITableViewController {

    @IBOutlet weak var backButton: UIButton!//add functionality
    var restaurant:Restaurant?
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
        
        backButton.applyDesign()

    }
    
    @objc func reloadData(){
        //get all reviews for this restaurant
        Model.instance.getAllReviewsByRestaurantID(resId: restaurant!.id) { (_data:[Review]?) in
             if (_data != nil) {
                self.data = _data!.reversed();
                 self.tableView.reloadData();
            }
            self.refreshControl?.endRefreshing()
        };
    }

    @IBAction func backAction(_ sender: Any) {
        performSegue(withIdentifier: "fromRestaurantReviewsToRestaurant", sender: self)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell:RestaurantReviewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantReviewCell", for: indexPath) as! RestaurantReviewsTableViewCell
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
              performSegue(withIdentifier: "fromRestaurantReviewsToReviewDisplay", sender: self)
          }




    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     //return from unwind
       @IBAction func backToRestaurantReviews(segue:UIStoryboardSegue){}
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if (segue.identifier == "fromRestaurantReviewsToReviewDisplay") {
               let vc:DisplayReviewViewController = segue.destination as! DisplayReviewViewController
            vc.review = selected
            vc.restaurantName = restaurant?.name
            vc.returnTo = "RestaurantReviewsTableViewController"
           }
       }
    

}
