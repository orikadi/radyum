//
//  RestaurantsTableViewController.swift
//  radyum
//
//  Created by Studio on 17/02/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class RestaurantsTableViewController: UITableViewController {

    //TODO: updating firebase info doesnt change local content
    
    @IBOutlet var searchBar: UITableView!
    var data = [Restaurant]()
    var selected:Restaurant?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
         
        ModelEvents.RestaurantDataEvent.observe {
            self.refreshControl?.beginRefreshing()
            self.reloadData();
        }
         self.refreshControl?.beginRefreshing()
         reloadData();
    }
    
    @objc func reloadData(){
          Model.instance.getAllRestaurants { (_data:[Restaurant]?) in
          if (_data != nil) {
              self.data = _data!;
              self.tableView.reloadData();
              }
              self.refreshControl?.endRefreshing()
          };
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RestaurantTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell
        let res = data[indexPath.row]
        cell.restaurantName.text = res.name
        cell.restaurantAddress.text = res.address
        cell.picture.image = UIImage(named: "picture")
        if res.picture != "" {
            cell.picture.kf.setImage(with: URL(string: res.picture))
        }
        return cell
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
    
        
        
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selected = data[indexPath.row]
            performSegue(withIdentifier: "fromRestaurantTableToRestaurantProfile", sender: self)
        }
        
    //return from unwind
    @IBAction func toRestaurants(segue:UIStoryboardSegue){}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromRestaurantTableToRestaurantProfile") {
            let vc:RestaurantProfilePageViewController = segue.destination as! RestaurantProfilePageViewController
            vc.restaurant = selected
            vc.backTo = "restaurants"
        }
    }

}
