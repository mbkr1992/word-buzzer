//
//  ViewController.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/7/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import UIKit

enum Constant {
    static let limit = 4
}

class ViewController: UIViewController {
    
    @IBOutlet weak var wordOne: UILabel!
    @IBOutlet weak var wordTwo: UILabel!
    @IBOutlet weak var scoreUserAlpha: UILabel!
    @IBOutlet weak var scoreUserBeta: UILabel!
    @IBOutlet weak var buzzerForUserAlpha: UIButton!
    @IBOutlet weak var buzzerForUserBeta: UIButton!
    @IBOutlet weak var currentRoundLbl: UILabel!
    @IBOutlet weak var totalRoundLbl: UILabel!
    
    var buzzerPressed = false
    
    var totalRounds: Int! {
        didSet {
            self.totalRoundLbl.text = "Total Rounds = \(totalRounds!)"
        }
    }
    
    var currentRound: Int! {
        didSet {
            self.currentRoundLbl.text = "Round \(currentRound!) starting!!!"
        }
    }
    
    var userAlpha: User! {
        didSet {
            self.scoreUserAlpha.text = """
            Total right: \(userAlpha.score.totalRight)
            Total wrong: \(userAlpha.score.totalWrong)
            """
            
            self.buzzerForUserAlpha.setTitle(userAlpha.name, for: UIControlState.normal)
        }
    }
    
    var userBeta: User! {
        didSet {
            self.scoreUserBeta.text = """
            Total right: \(userBeta.score.totalRight)
            Total wrong: \(userBeta.score.totalWrong)
            """
            
            self.buzzerForUserBeta.setTitle(userBeta.name, for: UIControlState.normal)
            
        }
    }
    
    lazy var controlPanel: ControlPanel = {
        return ControlPanel(withUserA: self.userAlpha, userB: self.userBeta)
    }()
    
    lazy var wordGenerator: WordGenerator = {
        let words = DBHandler().getContentFor(filename: "words", ofType: "json")
        return WordGenerator(withWords: words, limit: Constant.limit)
    }()
    
    var currentWord: Dictionary<String, String>! {
        didSet {
            if let word = currentWord {
                self.wordOne.text = word["text_eng"]
            }
        }
    }
    
    var currentPassingWord: Dictionary<String, String>! {
        didSet {
            if let word = currentPassingWord {
                self.wordTwo.text = word["text_spa"]
            }
        }
    }
    
    var currentWords: Array<Dictionary<String, String>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStaticProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start game
        self.newRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func userAlphaTapped(_ sender: Any) {
        if self.buzzerPressed == true {
            return
        }
        
        self.buzzerPressed = true
        if (Helper.checkAnswer(wordOne: self.currentWord, wordTwo: self.currentPassingWord)) {
            self.controlPanel.changeStateToAnsweredRight(forUser: self.userAlpha)
        } else {
            self.controlPanel.changeStateToAnsweredWrong(forUser: self.userAlpha)
            //            self.buzzerForUserAlpha.shake()
        }
    }
    
    @IBAction func userBetaTapped(_ sender: Any) {
        if self.buzzerPressed == true {
            return
        }
        
        self.buzzerPressed = true
        if (Helper.checkAnswer(wordOne: self.currentWord, wordTwo: self.currentPassingWord)) {
            self.controlPanel.changeStateToAnsweredRight(forUser: self.userBeta)
        } else {
            self.controlPanel.changeStateToAnsweredWrong(forUser: self.userBeta)
            //            self.buzzerForUserBeta.shake()
        }
    }
    
    @IBAction func dismissController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func showResult() {
        let actionSheetController: UIAlertController = UIAlertController(title: "Game Over!", message: "We are all winners in a greater scheme of things )", preferredStyle: .alert)
        let saveActionButton = UIAlertAction(title: "Ok", style: .default)
        { _ in
            self .dismiss(animated: true, completion: nil)
        }
        actionSheetController.addAction(saveActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    /**
     Configures the initial state of one-time properties
     */
    func configureStaticProperties() {
        self.userAlpha = User(id: 1, name: "Swift", score: Score())
        self.userBeta = User(id: 2, name: "ObjC", score: Score())
        self.totalRounds = 10
        self.currentRound = 0
        
        self.controlPanel.stateChanged = { (state: StateEnum, user: User?) in
            if let u = user {
                self.updateUser(withUser: u)
            }
            
            switch state {
            case .userAnsweredRight:
                self.newRound()
                break
            case .userAnsweredWrong:
                self.newRound()
                self.view.shakeView()
                break
            case .roundStarted, .userNotAnswered:
                self.continueRound()
                break
            case .gameEnded:
                self.showResult()
                break
            default:
                break
            }
        }
        
        // I wasn't sure how to transform properly and user constraints together, this was a temporary dirty workaround
        self.wordTwo.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension ViewController {
    /**
     Starts off with a new round, finishes the game if all rounds are player
     */
    func newRound() {
        if Helper.isGameOver(rounds: self.totalRounds, round: self.currentRound) {
            self.controlPanel.changeStateToGameEnded()
            return
        }
        
        self.buzzerForUserAlpha.deactivate()
        self.buzzerForUserBeta.deactivate()
        
        self.currentRound = self.currentRound + 1
        UIView.animate(withDuration: 3.0, animations: {
            self.currentRoundLbl.alpha = 1.0
        }) { (animated: Bool) in
            self.currentRoundLbl.alpha = 0.0
            
            self.buzzerForUserAlpha.activate()
            self.buzzerForUserBeta.activate()
            self.buzzerPressed = false
            let value = self.wordGenerator.next()
            if let (word, words) = value {
                self.currentWord = word
                self.currentPassingWord = words.randomObject()!
                self.currentWords = words
            }
            self.controlPanel.changeStateToRoundStarted()
        }
    }
    
    /**
     Continues the moving label animation unless user presses a buzzer
     */
    func continueRound() {
        self.buzzerForUserAlpha.activate()
        self.buzzerForUserBeta.activate()
        self.wordTwo.randomMovement(withDuration:4.0, rect: self.view.frame) { (animated: Bool) in
            if animated {
                if self.buzzerPressed == false {
                    self.currentPassingWord = self.currentWords?.randomObject()
                    self.controlPanel.changeStateToNotAnswered()
                }
            }
        }
    }
    
    /**
     Updates the userWithTheState.user
     - paramter user: the updated state.user
     */
    func updateUser(withUser user: User) {
        if self.userAlpha == user {
            self.userAlpha = user
        } else {
            self.userBeta = user
        }
    }
}
