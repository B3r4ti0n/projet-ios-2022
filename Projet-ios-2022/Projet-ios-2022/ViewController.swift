//
//  ViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Rabiller on 05/04/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        // Do any additional setup after loading the view.
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
}

