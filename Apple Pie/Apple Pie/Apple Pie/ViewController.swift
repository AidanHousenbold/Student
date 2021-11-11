//
//  ViewController.swift
//  Apple Pie
//
//  Created by Aidan Housenbold on 10/31/21.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["swift","niners","menlo","apples","cookies", "macbook"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
    var player1 = 0
    var player2 = 0
    var currentPlayer = true
    
    @IBOutlet weak var gameScore2: UILabel!
    @IBOutlet weak var gameScore: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }
    
    var currentGame: Game!
    
    func newRound(){
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {
        var letters = [String]()
        letters = currentGame.formattedWord.map {String($0)}
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        gameScore.text = "Player 1 Score: \(player1)"
        gameScore2.text = "Player 2 Score: \(player2)"
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        if currentGame.playerGuessed(letter: letter) {
            if currentPlayer{
                player1 += 5
            }else{
                player2 += 5
            }
        }else{
            currentPlayer.toggle()
        }
        updateGameState()
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            if currentPlayer{
                player1 += 10
            }else{
                player2 += 10
            }
            totalWins += 1
        }else{
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    
}

