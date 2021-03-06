//
//  ViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Rabiller on 05/04/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageHome: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        let settings = Setting()
        if settings.settingsJson == nil{
            settings.writeSave(username: "USER", highScore: 9999, difficulty: 0, numberOfBombs: 10, numberOfColumns: 10, numberOfRows: 10)
        }
        
        defileImage()

        // Do any additional setup after loading the view.
    }
    func defileImage(){
        imageHome.animationImages = [UIImage(named: "Minesweeper_8")!,UIImage(named: "Minesweeper_7")!,UIImage(named: "Minesweeper_6")!,UIImage(named: "Minesweeper_5")!,UIImage(named: "Minesweeper_4")!,UIImage(named: "Minesweeper_3")!,UIImage(named: "Minesweeper_2")!,UIImage(named: "Minesweeper_1")!,UIImage(named: "Minesweeper_-1")!]
        imageHome.animationDuration = 10
        imageHome.animationRepeatCount = 10
        imageHome.startAnimating()
    }

    @IBAction func goToSettings(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "settings") as? SettingsViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func goToScoreboard(_ sender: Any) {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "scoreboard") as? TableViewController{
                self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    @IBAction func goToPlay(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "minesweeper") as? GameViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func goToAbout(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "about") as? AboutViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

