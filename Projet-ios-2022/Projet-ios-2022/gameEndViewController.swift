//
//  gameEndViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Pelissier on 07/04/2022.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class gameEndViewController: UIViewController {
    
    //Definition of UI
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressBar2: UIProgressView!
    @IBOutlet weak var endStatusLabel: UILabel!
    
    //Definition of Variables
    var endStatusString: String = ""
    var endScore: Int = 0
    let settings = Setting()
    var numberOfBombs: Int = 0
    var numberOfColumns: Int = 0
    var numberOfRows: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberOfBombs = settings.settingsJson!["numberOfBombs"] as! Int
        self.numberOfColumns = settings.settingsJson!["numberOfColumns"] as! Int
        self.numberOfRows = settings.settingsJson!["numberOfRows"] as! Int
        
        //FireBase init
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        //Set String and score
        endStatusLabel.text = endStatusString
        scoreLabel.text = "\(self.endScore)"
        
        // ProgressBar Red if Lose
        if self.endScore == 0{
            progressBar.tintColor = .red
            progressBar2.tintColor = .red
        }
        
        //Compare Score and Write
        localCheck()
        databaseCheck(db: db)

        // Do any additional setup after loading the view.
    }
    
    //Add Document to FireBase
    func addDocument(db: Firestore!) {
            var ref: DocumentReference? = nil
            ref = db.collection("minesweeper").addDocument(data: [
                "difficulty": 0,
                "username": self.settings.settingsJson!["username"]!,
                "time": self.settings.settingsJson!["highTime"]!
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
    
    //Check LocalFile
    func localCheck(){
        if self.endScore < self.settings.settingsJson!["highTime"] as! Int && self.endScore > 0{
            self.settings.writeSave(username: self.settings.settingsJson!["username"] as! String, highScore: self.endScore, difficulty: 0, numberOfBombs: self.numberOfBombs, numberOfColumns: self.numberOfColumns, numberOfRows: self.numberOfRows)
        }
        
    }
    
    //Check Database
    func databaseCheck(db: Firestore!){
        db.collection("minesweeper").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var find: Bool = false
                for document in querySnapshot!.documents {
                    let id: String = document.documentID
                    let username: String = document.data()["username"]! as! String
                    let time: Int = document.data()["time"]! as! Int
                    if username == self.settings.settingsJson!["username"] as! String{
                        find = true
                    }
                    if username == self.settings.settingsJson!["username"] as! String && time > self.endScore && self.endScore > 0{
                        let user = db.collection("minesweeper").document(id)
                        user.updateData([
                            "time": self.endScore
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                            }
                        }
                    }
                }
                if find == false{
                    self.addDocument(db: db)
                }
            }
        }
    }
}
