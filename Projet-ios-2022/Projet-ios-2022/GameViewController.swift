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
    var randomTab:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var xvalue = 55
        var yvalue = 300
        var button = UIButton()
        
        //random bombs tab
        while randomTab.count != 10{
            let intRandom = Int.random(in: 1..<100)
            if !randomTab.contains(intRandom){
                randomTab.append(intRandom)
            }
        }
        
        var countTag: Int = 1
        for j in 0..<numbersOfRows {
            for i in 0..<numbersOfColumns {
                button = UIButton(frame: CGRect(x: xvalue, y: yvalue, width: 30 , height: 30))
              
                button.setBackgroundImage(UIImage(named: "Minesweeper_tile"), for: UIControl.State.normal)
                
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                button.tag = countTag
                countTag = countTag + 1
                self.view.addSubview(button)
                xvalue = xvalue + 30
            }
            xvalue = 55
            yvalue = yvalue + 30
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print(sender.tag)
        if randomTab.contains(sender.tag){
            sender.setBackgroundImage(UIImage(named: "Minesweeper_Bomb"), for: UIControl.State.normal)
        }else{
            sender.setBackgroundImage(UIImage(named: "Minesweeper_0"), for: UIControl.State.normal)
        }
    }
}
