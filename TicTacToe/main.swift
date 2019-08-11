//
//  main.swift
//  TicTacToe
//
//  Created by Andrew Rohn on 8/9/19.
//  Copyright © 2019 AndrewRohn. All rights reserved.
//

import Foundation
import TicTacToe_Core

/// A TicTacToe view layer implementation for a command line interface
class View: GameDelegate {
    func didError(_ game: Game, error: CoreError) {
        switch error {
        case .invalidMove:
            print("Invalid input. Please try again.")
        }
    }
    
    func didStartTurn(_ game: Game) {
        print("\n\(game.board) \n\n")
    }
    
    func didEnd(_ game: Game, winner: Player?) {
        if let player = winner {
            print("Player \(player) wins!")
        } else {
            print("Tie game!")
        }
    }
    
    func retrieveNextMove(_ game: Game) -> Move {
        print("Player \(game.currentPlayer), enter the x,y coordinates of where to move. e.g. '0,2'")
        let userInput = readLine(strippingNewline: true) ?? ""
        return sanitizedUserInput(userInput) ?? invalidMove
    }
    
    // converts user inputed string to valid Move (or nil)
    private func sanitizedUserInput(_ userInput: String) -> (Move)? {
        let stringComponents = userInput.components(separatedBy: ",")
        guard stringComponents.count == 2 else { return nil }
        
        let invalidCharacters = CharacterSet(charactersIn: "012").inverted
        let xString = stringComponents[0].trimmingCharacters(in: invalidCharacters)
        let yString = stringComponents[1].trimmingCharacters(in: invalidCharacters)
        
        if let xPos = Int(xString), let yPos = Int(yString) {
            return (xPos, yPos)
        }
        
        return nil
    }
}

// Setup and start game!
let game = Game(starting: Player.X, board: Board(), delegate: View())
game.start()
