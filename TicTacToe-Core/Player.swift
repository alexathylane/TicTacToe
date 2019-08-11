//
//  Player.swift
//  TicTacToe-Core
//
//  Created by Andrew Rohn on 8/11/19.
//  Copyright © 2019 AndrewRohn. All rights reserved.
//

import Foundation

/// The possible types of TicTacToe players
public enum Player {
    case X, O
    
    func opponent() -> Player {
        switch self {
        case .X: return .O
        case .O: return .X
        }
    }
}
