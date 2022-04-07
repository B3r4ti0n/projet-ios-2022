//
//  GameViewController.swift
//  Projet-ios-2022
//
//  Created by Alexis Rabiller on 05/04/2022.
//

import UIKit

class GameViewController: UIViewController {
    
    let numbersOfRows = 10
    let numbersOfColumns = 10
    let numbersOfBombs = GameSettings().numberOfBombs
    var randomTab:[Int] = []
    var tabStructure:[Int] = []
    var buttonsTab: [UIButton] = []
    var timer = Timer()
    
    override func viewDidLoad() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            print("Timer fired!")
//        }
        
        super.viewDidLoad()
        
        var xvalue = self.view.frame.width / 8
        var yvalue = (self.view.frame.height / 4) + 25
        var button = UIButton()
       
        
        //random bombs tab
        while randomTab.count != 10{
            let intRandom = Int.random(in: 1..<100)
            if !randomTab.contains(intRandom){
                randomTab.append(intRandom)
            }
        }
        print(randomTab)
        //boucle d'affiche du grid sur la page minesweeper
        var countTag: Int = 1
        for j in 0..<numbersOfRows{
            for i in 0..<numbersOfColumns{
                button = UIButton(frame: CGRect(x: xvalue, y: yvalue, width: 30 , height: 30))
                button.setBackgroundImage(UIImage(named: "Minesweeper_tile"), for: UIControl.State.normal)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                
                button.tag = countTag
                
                buttonsTab.append(button)
                
                if randomTab.contains(countTag){
                    tabStructure.append(-1)
                }
                else{
                    tabStructure.append(0)
                }
                
                self.view.addSubview(button)
                xvalue = xvalue + 30
                countTag = countTag + 1
            }
            xvalue = self.view.frame.width / 8
            yvalue = yvalue + 30
            print(tabStructure)
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
        print(tabStructure)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print(sender.tag)
        if randomTab.contains(sender.tag){
            for index in 0..<tabStructure.count{
                displayButtonImageEnable(indexButton: index, indexCell: index)
            }
        }else{
            displayButtonImageEnable(indexButton: sender.tag-1, indexCell: sender.tag)
        }
    }
    
    func verification (id : Int) -> [Int]{
        
        let gauche = [0,10,20,30,40,50,60,70,80,90]
        let droite = [1,11,21,31,41,51,61,71,81,91, 101]
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
                if id - 10 >= 0{
                    //faire comparatif du block haut : id - 10
                    print("Haut : \(id - 10)")
                    return id - 10
                }
            return nil
        }
        func Bas (id : Int) -> Int?{
                if id + 10 <= 100{
                    //faire comparatif du block Bas : id + 10
                    print("Bas : \(id + 10)")
                    return id + 10
                }
            return nil
        }
        func HautGauche (id : Int)->Int?{
            if id - 10 >= 0{
                for i in gauche{
                    if id - 11 == i{
                        return nil
                    }
                }
                //faire comparatif du block HautGauche : id - 11
                print("HautGauche : \(id - 11)")
                return id-11
            }
            return nil
        }
        func HautDroite (id : Int)->Int?{
            if id - 10 >= 0{
                for i in droite{
                    if id - 9 == i{
                        return nil
                    }
                }
                //faire comparatif du block HautDroite : id - 9
                print("HautDroite : \(id - 9)")
                return id - 9
            }
            return nil
        }
        func BasGauche (id : Int)->Int?{
            if id + 10 <= 100{
                for i in gauche{
                    if id + 9 == i{
                        return nil
                    }
                }
                //faire comparatif du block BasGauche : id + 9
                print("BasGauche : \(id + 9)")
                return id + 9
            }
            return nil
        }
        func BasDroite (id : Int)->Int?{
            if id + 10 <= 100{
                for i in droite{
                    if id + 11 == i{
                        return nil
                    }
                }
                //faire comparatif du block BasDroite : id + 11
                print("BasDroite : \(id + 11)")
                return id + 11
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
    func displayButtonImageEnable(indexButton: Int , indexCell: Int){
            buttonsTab[indexButton].isEnabled = false
            buttonsTab[indexButton].setBackgroundImage(UIImage(named: "Minesweeper_\(tabStructure[indexCell])"), for: UIControl.State.normal)
    }
}
