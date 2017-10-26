//
//  PlayersViewControllerTableViewController.swift
//  Ratings
//
//  Created by tibin on 16/03/17.
//  Copyright © 2017 tibin. All rights reserved.
//

import UIKit
import Foundation

class PlayersViewControllerTableViewController: UITableViewController {
    
    var players:[Player] = playersData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.conectToApi(urlString: URL(string: "http://jsonplaceholder.typicode.com/users/1")) { (data, response, error) in
            
            self.parseData(data: data)
            print("resss\(response)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
   
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
//        -> UITableViewCell {
//            let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath)
//            
//            let player = players[indexPath.row] as Player
//            cell.textLabel?.text = player.name
//            cell.detailTextLabel?.text = player.game
//            return cell
//    }
//    func imageForRating(rating:Int) -> UIImage? {
//        let imageName = "\(rating)Stars"
//        return UIImage(named: imageName)
//    }
    
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) //1
//        
//        let player = players[indexPath.row] as Player //2
//        
//        if let nameLabel = cell.viewWithTag(100) as? UILabel { //3
//            nameLabel.text = player.name
//        }
//        if let gameLabel = cell.viewWithTag(101) as? UILabel {
//            gameLabel.text = player.game
//        }
//        if let ratingImageView = cell.viewWithTag(102) as? UIImageView {
//            ratingImageView.image = self.imageForRating(player.rating)
//        }
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
                as! PlayerCellTableViewCell
            
            let player = players[indexPath.row] as Player
            cell.player = player
            return cell
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelToPlayersViewController(_ segue:UIStoryboardSegue) {
    }
    
    @IBAction func savePlayerDetail(_ segue:UIStoryboardSegue) {
        if let playerDetailsViewController = segue.source as? PlayerDetailsViewTableViewController {
            
            //add the new player to the players array
            if let player = playerDetailsViewController.player {
                players.append(player)
                
                //update the tableView
                let indexPath = IndexPath(row: players.count-1, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }

    func conectToApi(urlString: URL?, completionHandler2: @escaping (Data?, URLResponse?, Error?) -> Swift.Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                completionHandler2(data, response, error)
                
            }
            task.resume()
        }
    }
    
    func parseData(data: Data?){
        if let usableData = data {
            let dataString = String(data: usableData, encoding: .utf8)
            print(dataString ?? "")
            
            
            //Convert Json to Object
            let parseResult: [String:AnyObject]!
            do{
                parseResult = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String:AnyObject]
                print("data ....\(parseResult)")
                print(parseResult["name"] ?? "ss")
            } catch {
                print("Could not parse data as Json \(data)")
                return
            }
            //Check jsonDictionary
            
        }
    }
}
