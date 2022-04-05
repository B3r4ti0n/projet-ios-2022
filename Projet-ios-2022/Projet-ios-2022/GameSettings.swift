//
//  GameSettings.swift
//  Projet-ios-2022
//
//  Created by Alexis Pelissier on 05/04/2022.
//

import UIKit

class GameSettings: ObservableObject {
    
    /// The number of rows on the board
    var numberOfRows = 10

    /// The number of columns on the board
    var numberOfColumns = 10

    /// The total number of bombs
    var numberOfBombs = 10

    /// The size each square should be based on the width of the screen
    var squareSize: CGFloat {
        UIScreen.main.bounds.width / CGFloat(numberOfColumns)
    }
}
