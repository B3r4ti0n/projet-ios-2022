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

    override func viewDidLoad() {
        var db: Firestore!
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // [START setup]
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        getCollection(db: db)
    }

    func getCollection(db: Firestore!){
        db.collection("minesweeper").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }

}
