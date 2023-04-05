//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Brovko Roman on 05.04.2023.
//  Copyright © 2023 Roman Brovko. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    private var question: String!
    
    convenience init(question: String) {
        self.init()
        self.question = question
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = question
    }
}

