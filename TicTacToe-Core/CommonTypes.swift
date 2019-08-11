//
//  CommonTypes.swift
//  TicTacToe-Core
//
//  Created by Andrew Rohn on 8/11/19.
//  Copyright © 2019 AndrewRohn. All rights reserved.
//

import Foundation

public typealias Move = (Int, Int)
public typealias Line = (Move, Move, Move)

public let invalidMove: Move = (-1, -1)

public enum CoreError: Error {
    case invalidMove
}
