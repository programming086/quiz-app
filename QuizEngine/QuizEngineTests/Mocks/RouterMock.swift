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
    var routeToQuestionQuestions: [String] = []
    var routeToQuestionAnswerCallback: Router.AnswerCallback = { _ in }
    func routeTo(question: String, answerCallback: @escaping Router.AnswerCallback) {
        routeToQuestionCallCount += 1
        routeToQuestionQuestions.append(question)
        routeToQuestionAnswerCallback = answerCallback
    }

    var routeToResultCallCount: Int = 0
    var routeToResultResult: [String: String]?
    func routeTo(result: [String: String]) {
        routeToResultCallCount += 1
        routeToResultResult = result
    }
}
