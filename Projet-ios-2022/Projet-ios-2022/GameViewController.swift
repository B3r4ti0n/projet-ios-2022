//
//  GameViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Rabiller on 05/04/2022.
//

import UIKit

class GameViewController: UIViewController {

    let numbersOfRows = GameSettings().numberOfRows
    let numbersOfColumns = GameSettings().numberOfColumns
    let numbersOfBombs = GameSettings().numberOfBombs
    let square = GameSettings().squareSize
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var xvalue = 55
        var yvalue = 300
        var button = UIButton()

        for j in 0..<numbersOfRows {
            for i in 0..<numbersOfColumns {
                button = UIButton(frame: CGRect(x: xvalue, y: yvalue, width: 30 , height: 30))
              
                button.setBackgroundImage(UIImage(named: "Minesweeper_tile"), for: UIControl.State.normal)
                
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                button.tag = i
                self.view.addSubview(button)
                xvalue = xvalue + 30
            }
            
            xvalue = 55
            yvalue = yvalue + 30
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print(sender.tag)
        
    }
}
