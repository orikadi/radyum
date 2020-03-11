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
    }
    
    @objc func reloadData(){
        //get all reviews for this restaurant
        Model.instance.getAllReviewsByRestaurantID(resId: restaurant!.id) { (_data:[Review]?) in
             if (_data != nil) {
                 self.data = _data!;
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     //return from unwind
       @IBAction func backToRestaurantReviews(segue:UIStoryboardSegue){}
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if (segue.identifier == "fromRestaurantReviewsToReviewDisplay") {
               let vc:DisplayReviewViewController = segue.destination as! DisplayReviewViewController
            //todo: get restaurant by id, get user by email
            //vc.restaurant = selected?.resId
            //vc.user = get user by email

           }
       }
    

}
