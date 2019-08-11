//
//  Board.swift
//  TicTacToe-Core
//
//  Created by Andrew Rohn on 8/11/19.
//  Copyright © 2019 AndrewRohn. All rights reserved.
//

import Foundation

fileprivate typealias Grid = [[Player?]]

/// TicTacToe board that intelligently reports & holds its state
public struct Board: CustomStringConvertible {
    private var board = [[Player?](repeating: nil, count: 3),
                         [Player?](repeating: nil, count: 3),
                         [Player?](repeating: nil, count: 3)]
    
    public var description: String {
        return "\(board[0])\n\(board[1])\n\(board[2])"
    }
    
    var numMoves: Int {
        return board.flatMap({ $0 }).compactMap({ $0 }).count
    }
    
    var firstWinner: Player? {
        if let winningMove = winningLines?.first?.0 {
            return self[winningMove]
        }
        
        return nil
    }
    
    var winningLines: [Line]? {
        return winnableLines.compactMap { (line) -> Line? in
            return self[line.0] == self[line.1] && self[line.1] == self[line.2] ? line : nil
        }
    }
    
    private var winnableLines: [Line]
    
    public init() {
        var lines = [Line]()
        lines.append(((0,0), (1,1), (2,2))) // diagonal 1
        lines.append(((0,2), (1,1), (2,0))) // diagonal 2
        
        for i in 0...2 {
            lines.append(((i, 0), (i, 1), (i, 2))) // horizontal
            lines.append(((0, i), (1, i), (2, i))) // vertical
        }
        
        self.winnableLines = lines
    }
    
    subscript(move: Move) -> Player? {
        get { return board[move.0][move.1] }
        set { board[move.0][move.1] = newValue }
    }
    
    func isValidMove(_ move: Move) -> Bool {
        return board.canAccess(move) && self[move] == nil
    }
}

extension Grid {
    func canAccess(_ move: Move) -> Bool {
        return indices.contains(move.0) && self[move.0].indices.contains(move.1)
    }
}
