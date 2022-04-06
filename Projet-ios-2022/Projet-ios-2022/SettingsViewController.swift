//
//  SettingsViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Pelissier on 06/04/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    var fileURL:URL? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        var settingsJson: [String: AnyObject]
        
        let file = "settings.txt" //this is the file. we will write to and read from it
        //let text = "{\"username\":\"Spriingo\",\"highTime\":1102,\"difficulty\":0}" //just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            fileURL = dir.appendingPathComponent(file)
            //writeSave(text: text)
            settingsJson = readSave()
        }

        // Do any additional setup after loading the view.
    }
    
    func readSave() -> [String:AnyObject]{
        do {
            let text = try String(contentsOf: fileURL!, encoding: .utf8)
            let data = Data(text.utf8)
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                print("Find JSON")
                return json
            }
        }
        catch {/* error handling here */}
        let error: [String:AnyObject] = [:]
        return error
    }
    
    func writeSave(text: String){
        do {
            try text.write(to: fileURL!, atomically: false, encoding: .utf8)
        }
        catch {/* error handling here */}
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
