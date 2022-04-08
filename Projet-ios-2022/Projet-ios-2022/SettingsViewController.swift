//
//  SettingsViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Pelissier on 06/04/2022.
//

import UIKit

//Class Setting
class Setting{
    //Variables definition
    var fileURL:URL?
    let file = "settings.txt" //this is the file. we will write to and read from it
    var settingsJson: [String: AnyObject]?
    
    //Constructor
    init(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            self.fileURL = dir.appendingPathComponent(file)
            print(self.fileURL!)
            self.settingsJson = self.readSave()
        }
    }
    
    //Return the JSON on the settings file
    func readSave() -> [String:AnyObject]?{
        do {
            let text = try String(contentsOf: fileURL!, encoding: .utf8)
            let data = Data(text.utf8)
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                return json
            }
        }
        catch {/* error handling here */}
        return nil
    }
    
    //Write json on file
    func writeSave(username: String, highScore: Int, difficulty: Int, numberOfBombs: Int, numberOfColumns: Int, numberOfRows: Int){
        
        let line = "{\"username\":\"\(username)\",\"highTime\":\(highScore),\"difficulty\":\(difficulty), \"numberOfBombs\":\(numberOfBombs), \"numberOfColumns\":\(numberOfColumns), \"numberOfRows\":\(numberOfRows)}"
        do {
            try line.write(to: self.fileURL!, atomically: false, encoding: .utf8)
        }
        
        catch {/* error handling here */}
    }
}

class SettingsViewController: UIViewController {
    //Get Elements of View
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    //Create Variable
    let settings = Setting()
    var settingsJson: [String:AnyObject] = [:]
    
    //Start Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign Variables and textLabel
        settingsJson = settings.settingsJson!
        usernameTextField.text = settingsJson["username"] as? String
        highScoreLabel.text = String((settingsJson["highTime"] as? Int)!)
    }
    
    //Click on Save Button
    @IBAction func saveSettings(_ sender: Any) {
        settings.writeSave(username: usernameTextField.text!, highScore: 9999 , difficulty: 0, numberOfBombs: 10, numberOfColumns: 10, numberOfRows: 10)
        
        self.loading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.loading.stopAnimating()
            self.saveButton.setTitle("Compte Modifié", for: .normal)
            self.saveButton.backgroundColor = UIColor.green
            self.saveButton.layer.opacity = 0.8
        }
    }
}
