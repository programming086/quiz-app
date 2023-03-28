//
//  Flow.swift
//  QuizEngine
//
//  Created by Brovko Roman on 13.03.2023.
//  Copyright © 2023 Roman Brovko. All rights reserved.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
}

class Flow {
    private let router: Router
    private let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        }
        
    }
}

private extension Flow {
    func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let self else { return }
            if let currentQuestionIndex = self.questions.index(of: question),
                currentQuestionIndex + 1 < self.questions.count {
                let nextQuestion = self.questions[currentQuestionIndex + 1]
                self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion))
            }
        }
    }
}
