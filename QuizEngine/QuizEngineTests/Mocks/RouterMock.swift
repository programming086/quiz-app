//
//  RouterMock.swift
//  QuizEngineTests
//
//  Created by Brovko Roman on 13.03.2023.
//  Copyright © 2023 Roman Brovko. All rights reserved.
//

import Foundation
@testable import QuizEngine

final class RouterMock: Router {
    var routeToQuestionCallCount: Int = 0
    var routeToQuestion_questions: [String] = []
    var routeToQuestion_answerCallback: Router.AnswerCallback = { _ in }
    func routeTo(question: String, answerCallback: @escaping Router.AnswerCallback) {
        routeToQuestionCallCount += 1
        routeToQuestion_questions.append(question)
        routeToQuestion_answerCallback = answerCallback
    }
    
    var routeToResultCallCount: Int = 0
    var routeToResult_result: [String: String]?
    func routeTo(result: [String: String]) {
        routeToResultCallCount += 1
        routeToResult_result = result
    }
}
