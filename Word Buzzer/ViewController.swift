//
//  ViewController.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/7/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var stateUserA: ContextMachine = {
        return ContextMachine(withUser: User(name: "Swift", score: Score()))
    }()
    
    lazy var stateUserB: ContextMachine = {
        return ContextMachine(withUser: User(name: "ObjC", score: Score()))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

