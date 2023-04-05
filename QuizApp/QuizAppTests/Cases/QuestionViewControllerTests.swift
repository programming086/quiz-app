//
//  QuestionViewControllerTests.swift
//  QuizAppTests
//
//  Created by Brovko Roman on 05.04.2023.
//  Copyright © 2023 Roman Brovko. All rights reserved.
//

import XCTest

@testable import QuizApp

final class QuestionViewControllerTests: XCTestCase {

    func test_viewDidLoad_renderQuestionHeaderTest() throws {
        let sut = QuestionViewController(question: "Q1")
        
        _ = sut.view
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
}
