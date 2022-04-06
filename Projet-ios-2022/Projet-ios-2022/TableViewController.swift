//
//  TableViewController.swift
//  ios
//
//  Created by Alexis Pelissier on 05/04/2022.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class Player {
    var id: Int
    var username: String
    var time: Int
    
    init(id: Int, username: String, time: Int) {
        self.id = id
        self.username = username
        self.time = time
    }
}

class TableViewController: UITableViewController {
    var players:[Player] = []
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        var db: Firestore!
        // Do any additional setup after loading the view.
        
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        
        getCollection(db: db)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return self.players.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "player", for: indexPath)

        // Configure the cell...
        let player:Player = self.players[indexPath.row]
        cell.textLabel?.text = player.username
        
        return cell
    }
    
    func getCollection(db: Firestore!) {
        
        db.collection("minesweeper").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let id: Int = Int(document.documentID)!
                    let username: String = document.data()["username"]! as! String
                    let time: Int = document.data()["time"]! as! Int
                    let player = Player(id: id, username: username, time: time)
                    self.players.append(player)
                }
                self.tableView.reloadData()
            }
        }
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

}
