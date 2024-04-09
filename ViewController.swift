//
//  ViewController.swift
//  tray_RPS_game
//
//  Created by Tristan Earl Ray, Jr on 3/28/24.
//

import UIKit
import AVFoundation

enum GameState {
    case start
    case win
    case lose
    case draw
}

enum Sign {
    case rock
    case paper
    case scissors
}

class ViewController: UIViewController {

    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var rockBtn: UIButton!
    @IBOutlet weak var scissorsBtn: UIButton!
    @IBOutlet weak var paperBtn: UIButton!
    @IBOutlet weak var playAgainBtn: UIButton!
    
    
    @IBOutlet weak var startOverBtn: UIButton!
    
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var losses: UILabel!
    
    @IBOutlet weak var draws: UILabel!
    
    @IBOutlet weak var totalGames: UILabel!
    
    
    var winNumber: Int = 0;
    var lossNumber: Int = 0;
    var drawNumber: Int = 0;
    var totalGameNumber: Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(forState: .start)
    }

    @IBAction func rockBtnAction(_ sender: Any) {
        checkGameResult(userChoice: .rock)
    }
    
    @IBAction func scissorsBtnAction(_ sender: Any) {
        checkGameResult(userChoice: .scissors)
    }
    
    @IBAction func paperBtnAction(_ sender: Any) {
        checkGameResult(userChoice: .paper)

    }
    
    @IBAction func playAgainBtnAction(_ sender: Any) {
        updateUI(forState: .start)
    }
    
    
    @IBAction func startOverBtnAction(_ sender: Any) {
        winNumber = 0
        lossNumber = 0
        drawNumber = 0
        updateUI(forState: .start)
        
    }
    
    func updateUI(forState state: GameState) {
        switch state {
        case .start:
            signLabel.text = "🤖"
            playAgainBtn.isHidden = true
            startOverBtn.isHidden = true
            rockBtn.isHidden = false
            scissorsBtn.isHidden = false
            paperBtn.isHidden = false
            rockBtn.isEnabled = true
            scissorsBtn.isEnabled = true
            paperBtn.isEnabled = true
            statusLabel.text = "Rock, Paper, Scissors"
        case .win:
            statusLabel.text = "You Won!"
            let systemSoundID: SystemSoundID = 1016
            AudioServicesPlaySystemSound(systemSoundID)
            winNumber += 1
            
        case .lose:
            statusLabel.text = "You Lost!"
            let systemSoundID: SystemSoundID = 1006
            AudioServicesPlaySystemSound(systemSoundID)
            lossNumber += 1
        case .draw:
            statusLabel.text = "It's a draw!"
            let systemSoundID: SystemSoundID = 1116
            AudioServicesPlaySystemSound(systemSoundID)
            drawNumber += 1
            
        }
        
        wins.text = String(winNumber)
        losses.text = String(lossNumber)
        draws.text = String(drawNumber)
        totalGames.text = String(winNumber + lossNumber + drawNumber)
    }
    
    func checkGameResult(userChoice: Sign) {
        //generate computer's choice (rock, scissors, paper)
        let i = Int.random(in: 0...2)
        var computerChoice: Sign
        switch i {
            case 0:
            computerChoice = .rock
            signLabel.text = "👊🏾"
            case 1:
            computerChoice = .paper
            signLabel.text = "✋🏾"
            case 2:
            computerChoice = .scissors
            signLabel.text = "✌🏾"
        default:
            computerChoice = .rock
            
        }
        
        //we have human's choice and computera's choice
        //hide all the buttons
        rockBtn.isHidden = true
        scissorsBtn.isHidden = true
        paperBtn.isHidden = true
        //disable all the signs
        rockBtn.isEnabled = false
        scissorsBtn.isEnabled = false
        paperBtn.isEnabled = false
        
        playAgainBtn.isHidden = false
        startOverBtn.isHidden = false
        //show the sign clicked by the user
        if userChoice == .rock {
            rockBtn.isHidden = false
        } else if userChoice == .paper{
            paperBtn.isHidden = false
        } else
        {
            scissorsBtn.isHidden = false;
        }
        //check win/lose/draw
        if userChoice == computerChoice {//handle three possibilities
            updateUI(forState: .draw)
            return
        }
        var status: GameState = .win
        switch userChoice {
        case .rock:
            if computerChoice == .paper {
                status = .lose
            } else {//.scissors
                status = .win
            }
        case .paper:
            if computerChoice == .rock {
                status = .win
                
            } else {//.scissor
                status = .lose
            }
        case .scissors:
            if computerChoice == .paper {
                status = .win
            } else {//.rock
                status = .lose
            }
            
        }
        
        updateUI(forState: status)
        
    }
    
}

