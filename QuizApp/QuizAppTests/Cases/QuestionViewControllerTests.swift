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

    func test_viewDidLoad_renderQuestionHeaderText() throws {
        let sut = QuestionViewController(question: "Q1", options: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptions() {
        let sut = QuestionViewController(question: "Q1", options: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOption() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

}
