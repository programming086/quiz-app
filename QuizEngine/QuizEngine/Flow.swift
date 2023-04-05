//
//  Flow.swift
//  QuizEngine
//
//  Created by Brovko Roman on 13.03.2023.
//  Copyright © 2023 Roman Brovko. All rights reserved.
//

import Foundation

/// Game router
protocol Router {
    typealias AnswerCallback = (String) -> Void
    /// Route to question
    /// - Parameters:
    ///   - question: next question
    ///   - answerCallback: answer callback
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    /// Route to result gane
    /// - Parameter result: result dictionary question -> answer
    func routeTo(result: [String: String])
}

/// Game flow
class Flow {
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]
    
    /// Init
    /// - Parameters:
    ///   - questions: questions
    ///   - router: game router
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    /// Start game
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }

    }
}

// MARK: - Private

private extension Flow {
    func nextCallback(from question: String) -> Router.AnswerCallback {
        return { [weak self] in self?.routeNext(from: question, answer: $0) }
    }

    func routeNext(from question: String, answer: String) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }
        }

    }
}
