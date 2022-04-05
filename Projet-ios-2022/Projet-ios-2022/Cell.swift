//
//  Cell.swift
//  Projet-ios-2022
//
//  Created by Alexis Pelissier on 05/04/2022.
//

import UIKit

class Cell: ObservableObject {
    /// The row of the cell on the board
    var row: Int

    /// The column of the cell on the board
    var column: Int

    /// Current state of the cell
    var status: Status

    /// Whether or not the cell has been opened/touched
    var isOpened: Bool

    /// Whether or not the cell has been flagged
    var isFlagged: Bool

    init(row: Int, column: Int) {
        self.row = row
        self.column = column
        self.status = .normal
        self.isOpened = false
        self.isFlagged = false
    }
}

enum Status: Equatable {
    /// The square is open and not touching anything
    case normal

    /// The square has been opened and touching n bombs
    /// value 1: - The number of bombs the square is touching. 0 for none.
    case exposed(Int)

    /// There is a bomb in the square
    case bomb
}
