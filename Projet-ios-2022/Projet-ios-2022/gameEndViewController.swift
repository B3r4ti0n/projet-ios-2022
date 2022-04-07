//
//  gameEndViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Pelissier on 07/04/2022.
//

import UIKit

class gameEndViewController: UIViewController {
    
    //Definition of UI
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressBar2: UIProgressView!
    @IBOutlet weak var endStatusLabel: UILabel!
    
    //Definition of Variables
    var endStatusString: String = ""
    var endScore: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        endStatusLabel.text = endStatusString
        scoreLabel.text = "\(self.endScore)"
        
        if self.endScore == 0{
            progressBar.tintColor = .red
            progressBar2.tintColor = .red
        }

        // Do any additional setup after loading the view.
    }

}
