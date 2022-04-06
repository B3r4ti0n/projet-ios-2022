//
//  SettingsViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Pelissier on 06/04/2022.
//

import UIKit

class Setting{
    var fileURL:URL?
    let file = "settings.txt" //this is the file. we will write to and read from it
    var settingsJson: [String: AnyObject]?
    
    init(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            self.fileURL = dir.appendingPathComponent(file)
            print(self.fileURL)
            self.settingsJson = self.readSave()
            //writeSave(text: text)
        }
    }
    
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
    
    func writeSave(username: String, highScore: Int, difficulty: Int){
        let line = "{\"username\":\"\(username)\",\"highTime\":\(highScore),\"difficulty\":\(difficulty)}"
        do {
            try line.write(to: self.fileURL!, atomically: false, encoding: .utf8)
        }
        catch {/* error handling here */}
    }
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    let settings = Setting()
    var settingsJson: [String:AnyObject] = [:]
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsJson = settings.settingsJson!
        usernameTextField.text = settingsJson["username"] as? String
        highScoreLabel.text = String((settingsJson["highTime"] as? Int)!)
    

        // Do any additional setup after loading the view.
    }
    @IBAction func saveSettings(_ sender: Any) {
        settings.writeSave(username: usernameTextField.text!, highScore: self.settingsJson["highTime"] as! Int, difficulty: 0)
        self.loading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loading.stopAnimating()
            self.saveButton.setTitle("Compte Modifié", for: .normal)
            self.saveButton.backgroundColor = UIColor.green
            self.saveButton.layer.opacity = 0.8
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
