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
        // Do any additional setup after loading the view.
    }


    @IBAction func goToScoreboard(_ sender: Any) {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "scoreboard") as? TableViewController{
                self.navigationController?.pushViewController(vc, animated: true)
            }
    }
}

