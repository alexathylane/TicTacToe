//
//  Game.swift
//  TicTacToe-Core
//
//  Created by Andrew Rohn on 8/11/19.
//  Copyright © 2019 AndrewRohn. All rights reserved.
//

import Foundation

/// Callbacks for important Game lifecycle events
public protocol GameDelegate {
    func didStartTurn(_ game: Game)
    func didEnd(_ game: Game, winner: Player?)
    func didError(_ game: Game, error: CoreError)
    func retrieveNextMove(_ game: Game) -> Move
}

/// The game state itself. Sends important game lifecycle events to its GameDelegate.
public class Game {
    public var board: Board
    public var currentPlayer: Player
    var delegate: GameDelegate
    
    public init(starting: Player, board: Board, delegate: GameDelegate) {
        self.board = board
        self.currentPlayer = starting
        self.delegate = delegate
    }
    
    public func start() {
        assert(board.numMoves == 0, "Must only call start() once")
        nextTurn()
    }
    
    func nextTurn() {
        delegate.didStartTurn(self)
        
        if board.firstWinner != nil || board.numMoves >= 9 {
            delegate.didEnd(self, winner: board.firstWinner)
        } else {
            let move = delegate.retrieveNextMove(self)
            if board.isValidMove(move) {
                board[move] = currentPlayer
                currentPlayer = currentPlayer.opponent()
            } else {
                delegate.didError(self, error: .invalidMove)
            }
            
            nextTurn() // recursively call until either a player wins or tie game
        }
    }
}
