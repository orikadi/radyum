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
        //get all reviews for this restaurant
        //Model.instance.getAllReviews()
//        Model.instance.getAllReviewsByRestaurantID(resId: restaurant!.id) { (_data:[Review]?) in
//             if (_data != nil) {
//                 self.data = _data!;
//                 self.tableView.reloadData();
//            }
            self.refreshControl?.endRefreshing()
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
        //performSegue(withIdentifier: "fromRestaurantReviewsToReviewDisplay", sender: self)
        print(selected?.text)
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backToFeed(segue:UIStoryboardSegue){}

}
