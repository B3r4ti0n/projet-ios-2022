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
    func verification (id : Int) -> [Int]{
        
        func getTabGauche()->[Int]{
            var tabReturn:[Int] = []
            for i in 0...self.numbersOfRows+1{
                tabReturn.append(self.numbersOfColumns*i)
            }
            return tabReturn
        }
        
        func getTabDroite()->[Int]{
            var tabReturn:[Int] = []
            for i in 0...self.numbersOfRows+1{
                tabReturn.append((self.numbersOfColumns*i)+1)
            }
            return tabReturn
        }
        
        let gauche = getTabGauche()
        let droite = getTabDroite()
        var tabToReturn: [Int] = []
         
        func Gauche (id : Int)->Int?{
            for i in gauche{
                if id - 1 == i{
                    return nil
                }
            }
            //faire comparatif du block gauche : id - 1
            print("gauche : \(id - 1)")
            return id - 1
        }
        func Droite (id : Int)->Int?{
            for i in droite{
                if id + 1 == i{
                    return nil
                }
            }
            //faire comparatif du block droite : id + 1
            print("Droite : \(id + 1)")
            return id + 1
        }
        func Haut (id : Int) -> Int?{
            if id - self.numbersOfColumns > 0{
                    //faire comparatif du block haut : id - 10
                    print("Haut : \(id - 10)")
                return id - self.numbersOfColumns
                }
            return nil
        }
        func Bas (id : Int) -> Int?{
            if id + self.numbersOfColumns <= self.numbersOfColumns * self.numbersOfRows{
                    //faire comparatif du block Bas : id + 10
                    print("Bas : \(id + 10)")
                return id + self.numbersOfColumns
                }
            return nil
        }
        func HautGauche (id : Int)->Int?{
            if id - self.numbersOfColumns > 0{
                for i in gauche{
                    if id - (self.numbersOfColumns+1) == i{
                        return nil
                    }
                }
                //faire comparatif du block HautGauche : id - 11
                print("HautGauche : \(id - (self.numbersOfColumns+1))")
                return id-(self.numbersOfColumns+1)
            }
            return nil
        }
        func HautDroite (id : Int)->Int?{
            if id - self.numbersOfColumns >= 0{
                for i in droite{
                    if id - (self.numbersOfColumns-1) == i{
                        return nil
                    }
                }
                //faire comparatif du block HautDroite : id - 9
                print("HautDroite : \(id - (self.numbersOfColumns-1))")
                return id - (self.numbersOfColumns-1)
            }
            return nil
        }
        func BasGauche (id : Int)->Int?{
            if id + self.numbersOfColumns <= self.numbersOfColumns*self.numbersOfRows{
                for i in gauche{
                    if id + (self.numbersOfColumns-1) == i{
                        return nil
                    }
                }
                //faire comparatif du block BasGauche : id + 9
                print("BasGauche : \(id + (self.numbersOfColumns-1))")
                return id + (self.numbersOfColumns-1)
            }
            return nil
        }
        func BasDroite (id : Int)->Int?{
            if id + self.numbersOfColumns <= self.numbersOfColumns*self.numbersOfRows{
                for i in droite{
                    if id + (self.numbersOfColumns+1) == i{
                        return nil
                    }
                }
                //faire comparatif du block BasDroite : id + 11
                print("BasDroite : \(id + (self.numbersOfColumns+1))")
                return id + (self.numbersOfColumns+1)
            }
            return nil
        }

        let haut = Haut(id: id)
        let bas = Bas(id: id)
        
        let idgauche = Gauche(id: id)
        let iddroite = Droite(id: id)
        
        let hautDroite = HautDroite(id: id)
        let hautGauche = HautGauche(id: id)
        
        let basGauche = BasGauche(id: id)
        let basDroite = BasDroite(id: id)
        
        if haut != nil{
            tabToReturn.append(haut!)
        }
        if bas != nil{
            tabToReturn.append(bas!)
        }
        if idgauche != nil{
            tabToReturn.append(idgauche!)
        }
        if iddroite != nil{
            tabToReturn.append(iddroite!)
        }
        if hautDroite != nil{
            tabToReturn.append(hautDroite!)
        }
        if hautGauche != nil{
            tabToReturn.append(hautGauche!)
        }
        if basGauche != nil{
            tabToReturn.append(basGauche!)
        }
        if basDroite != nil{
            tabToReturn.append(basDroite!)
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

