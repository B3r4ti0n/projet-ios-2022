//
//  GameViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Rabiller on 05/04/2022.
//

import UIKit

class GameViewController: UIViewController {
    //variable global declaration
    let setting = Setting()
    var numbersOfRows: Int = 10
    var numbersOfColumns: Int = 10
    var numbersOfBombs: Int = 10
    var randomTab:[Int] = []
    var tabStructure:[Int] = []
    var buttonsTab: [UIButton] = []
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var squareSize: CGFloat = 30
    var gameFinishCount: Int = 0
    var endString: String = ""
    var endScore: Int = 0
    
    //variable link to view
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var gameFinishTextField: UITextField!
    
    //script to launch a grid game
    override func viewDidLoad() {
        numbersOfRows = setting.settingsJson?["numberOfRows"] as! Int
        numbersOfColumns = setting.settingsJson?["numberOfColumns"] as! Int
        numbersOfBombs = setting.settingsJson?["numberOfBombs"] as! Int
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.seconds += 1
            if self.seconds == 60{
                self.minutes += 1
                self.seconds = 0
            }
                
            let string = "\(self.minutes) : \(self.seconds)"
            self.timerLabel.text = string
        }
        
        super.viewDidLoad()
        //variable declaration
        var xvalue = self.view.frame.width / 16
        var yvalue = (self.view.frame.height / 4) + 25
        var button = UIButton()
        squareSize = (UIScreen.main.bounds.width / CGFloat(numbersOfColumns)) - 5
       
        
        //random bombs tab
        while randomTab.count != self.numbersOfBombs{
            let intRandom = Int.random(in: 0..<numbersOfColumns*numbersOfRows)
            if !randomTab.contains(intRandom){
                randomTab.append(intRandom)
            }
        }
        //repeat button for create a grid game
        var countTag: Int = 1
        for j in 0..<numbersOfRows{
            for i in 0..<numbersOfColumns{
                button = UIButton(frame: CGRect(x: xvalue, y: yvalue, width: squareSize, height: squareSize))
                button.setBackgroundImage(UIImage(named: "Minesweeper_tile"), for: UIControl.State.normal)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                button.tag = countTag
                
                buttonsTab.append(button)
                
                if randomTab.contains(countTag-1){
                    tabStructure.append(-1)
                }
                else{
                    tabStructure.append(0)
                }
                countTag = countTag + 1

                self.view.addSubview(button)
                xvalue = xvalue + squareSize
            }
            xvalue = self.view.frame.width / 16
            yvalue = yvalue + squareSize
        }
        
        //Assign Numbers On Tiles next to bombs
        for index in 0...tabStructure.count-1{
            if tabStructure[index] == -1{
                var idTileBombTouchTab: [Int]
                idTileBombTouchTab = verification(id: index+1)
                for tag in idTileBombTouchTab{
                    let id = tag-1
                    if tabStructure[id] != -1{
                        tabStructure[id] += 1
                    }
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endSegue"{
            if let destination = segue.destination as? gameEndViewController{
                destination.endStatusString = self.endString
                destination.endScore = self.endScore
                //(self.minutes * 60) + self.seconds
            }
        }
    }
    //function for click on tile of the grid game
    @objc func buttonAction(sender: UIButton!) {
        
            if randomTab.contains(sender.tag-1){
                self.endScore = 0
                self.endString = "PERDU"
                displayTheTileImageOfAllButtonInTheGrid()
            }else{
                showPreciseTileOfGridButton(indexButton: sender.tag-1, indexCell: sender.tag-1)
                gameFinishCount+=1
            }
        if gameFinishCount == (numbersOfRows * numbersOfColumns) - numbersOfBombs{
            self.endScore = (self.minutes * 60) + self.seconds
            self.endString = "GAGNÉ"
            displayTheTileImageOfAllButtonInTheGrid()
        }
    }
    //checks if a square is actually next to it
    func verification (id : Int) -> [Int]{
        
        //Initialization of checkboxes left
        func getTabLeft()->[Int]{
            var tabReturn:[Int] = []
            for i in 0...self.numbersOfRows+1{
                tabReturn.append(self.numbersOfColumns*i)
            }
            return tabReturn
        }
        
        //Initialization of checkboxes right
        func getTabRight()->[Int]{
            var tabReturn:[Int] = []
            for i in 0...self.numbersOfRows+1{
                tabReturn.append((self.numbersOfColumns*i)+1)
            }
            return tabReturn
        }
        
        let left = getTabLeft()
        let right = getTabRight()
        var tabToReturn: [Int] = []
         
        //Compare the boxes to the left
        func Left (id : Int)->Int?{
            for i in left{
                if id - 1 == i{
                    return nil
                }
            }
            print("gauche : \(id - 1)")
            return id - 1
        }
        //Compare the boxes to the right
        func Right (id : Int)->Int?{
            for i in right{
                if id + 1 == i{
                    return nil
                }
            }
            print("Droite : \(id + 1)")
            return id + 1
        }
        //Compare the boxes on the top
        func Top (id : Int) -> Int?{
            if id - self.numbersOfColumns > 0{
                    print("Haut : \(id - 10)")
                return id - self.numbersOfColumns
                }
            return nil
        }
        //Compare the boxes on the bottom
        func Bottom (id : Int) -> Int?{
            if id + self.numbersOfColumns <= self.numbersOfColumns * self.numbersOfRows{
                    print("Bas : \(id + 10)")
                return id + self.numbersOfColumns
                }
            return nil
        }
        //Compare the boxes on the top left
        func TopLeft (id : Int)->Int?{
            if id - self.numbersOfColumns > 0{
                for i in left{
                    if id - (self.numbersOfColumns+1) == i{
                        return nil
                    }
                }
                print("HautGauche : \(id - (self.numbersOfColumns+1))")
                return id-(self.numbersOfColumns+1)
            }
            return nil
        }
        //Compare the boxes on the top right
        func TopRight (id : Int)->Int?{
            if id - self.numbersOfColumns >= 0{
                for i in right{
                    if id - (self.numbersOfColumns-1) == i{
                        return nil
                    }
                }
                print("HautDroite : \(id - (self.numbersOfColumns-1))")
                return id - (self.numbersOfColumns-1)
            }
            return nil
        }
        //Compare the boxes on the bottom left
        func BottomLeft (id : Int)->Int?{
            if id + self.numbersOfColumns <= self.numbersOfColumns*self.numbersOfRows{
                for i in left{
                    if id + (self.numbersOfColumns-1) == i{
                        return nil
                    }
                }
                print("BasGauche : \(id + (self.numbersOfColumns-1))")
                return id + (self.numbersOfColumns-1)
            }
            return nil
        }
        //Compare the boxes on the bottom right
        func BottomRigth (id : Int)->Int?{
            if id + self.numbersOfColumns <= self.numbersOfColumns*self.numbersOfRows{
                for i in right{
                    if id + (self.numbersOfColumns+1) == i{
                        return nil
                    }
                }
                print("BasDroite : \(id + (self.numbersOfColumns+1))")
                return id + (self.numbersOfColumns+1)
            }
            return nil
        }

        let top = Top(id: id)
        let bottom = Bottom(id: id)
        
        let idLeft = Left(id: id)
        let idRight = Right(id: id)
        
        let topRight = TopRight(id: id)
        let topLeft = TopLeft(id: id)
        
        let bottomLeft = BottomLeft(id: id)
        let bottomRigth = BottomRigth(id: id)
        
        if top != nil{
            tabToReturn.append(top!)
        }
        if bottom != nil{
            tabToReturn.append(bottom!)
        }
        if idLeft != nil{
            tabToReturn.append(idLeft!)
        }
        if idRight != nil{
            tabToReturn.append(idRight!)
        }
        if topRight != nil{
            tabToReturn.append(topRight!)
        }
        if topLeft != nil{
            tabToReturn.append(topLeft!)
        }
        if bottomLeft != nil{
            tabToReturn.append(bottomLeft!)
        }
        if bottomRigth != nil{
            tabToReturn.append(bottomRigth!)
        }
        return tabToReturn
        
    }
    //modify a precise tile in a grid game
    func showPreciseTileOfGridButton(indexButton: Int , indexCell: Int){
            buttonsTab[indexButton].isEnabled = false
            buttonsTab[indexButton].setBackgroundImage(UIImage(named: "Minesweeper_\(tabStructure[indexCell])"), for: UIControl.State.normal)
    } 
    //modify alls tiles in a grid game
    func displayTheTileImageOfAllButtonInTheGrid(){
        self.timer.invalidate()
        for index in 0..<tabStructure.count{
            showPreciseTileOfGridButton(indexButton: index, indexCell: index)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "endSegue", sender: self)
        }
    }
}

