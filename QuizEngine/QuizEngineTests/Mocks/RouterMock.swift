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
    var routeToQuestion_question: String?
    func routeTo(question: String) {
        routeToQuestionCallCount += 1
        routeToQuestion_question = question
    }
}
