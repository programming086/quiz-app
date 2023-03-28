//
//  FlowTests.swift
//  QuizEngineTests
//
//  Created by Brovko Roman on 13.03.2023.
//  Copyright © 2023 Roman Brovko. All rights reserved.
//

import XCTest
@testable import QuizEngine

final class FlowTests: XCTestCase {
    
    private var router: RouterMock!
    private var sut: Flow!
    
    override func setUpWithError() throws {
        router = RouterMock()
    }
    
    override func tearDownWithError() throws {
        router = nil
    }
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routeToQuestionCallCount, 0)
        XCTAssertTrue(router.routeToQuestion_questions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToQuestion() {
        sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routeToQuestionCallCount, 1)
    }

    func test_start_withOneQuestion_routesToCorrectQuestion() {
        sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routeToQuestion_questions, ["Q1"])
    }

    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        sut = Flow(questions: ["Q2"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routeToQuestion_questions, ["Q2"])
    }

    func test_start_withTwoQuestions_routesToFirstQuestion() {
        sut = Flow(questions: ["Q1", "Q2"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routeToQuestion_questions, ["Q1"])
    }

    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        sut = Flow(questions: ["Q1", "Q2"], router: router)
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routeToQuestion_questions, ["Q1", "Q1"])
    }

    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToDecondQuestion() {
        sut = Flow(questions: ["Q1", "Q2"], router: router)
        
        sut.start()
        router.routeToQuestion_answerCallback("A1")
        
        XCTAssertEqual(router.routeToQuestion_questions, ["Q1", "Q2"])
    }
}
