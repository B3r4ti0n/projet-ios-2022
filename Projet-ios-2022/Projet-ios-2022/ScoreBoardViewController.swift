//
//  ScoreBoardViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Pelissier on 05/04/2022.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class ScoreBoardViewController: UIViewController {
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

    override func viewDidLoad() {
        var db: Firestore!
        var players: [Player]
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // [START setup]
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        players = getCollection(db: db)
        print(players)
    }

    func getCollection(db: Firestore!) -> [Player]{
        var players: [Player] = []
        db.collection("minesweeper").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let id: Int = Int(document.documentID)!
                    let username: String = document.data()["username"]! as! String
                    let time: Int = document.data()["time"]! as! Int
                    let player = Player(id: id, username: username, time: time)
                    players.append(player)
                }
            }
        }
    }

}
