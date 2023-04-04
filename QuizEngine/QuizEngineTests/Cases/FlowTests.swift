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
        XCTAssertTrue(router.routeToQuestionQuestions.isEmpty)
    }

    func test_start_withOneQuestion_routesToQuestion() {
        sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routeToQuestionCallCount, 1)
    }

    func test_start_withOneQuestion_routesToCorrectQuestion() {
        sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routeToQuestionQuestions, ["Q1"])
    }

    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        sut = Flow(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routeToQuestionQuestions, ["Q2"])
    }

    func test_start_withTwoQuestions_routesToFirstQuestion() {
        sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routeToQuestionQuestions, ["Q1"])
    }

    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        sut.start()

        XCTAssertEqual(router.routeToQuestionQuestions, ["Q1", "Q1"])
    }

    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        router.routeToQuestionAnswerCallback("A1")

        XCTAssertEqual(router.routeToQuestionQuestions, ["Q1", "Q2"])
    }

    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        sut = Flow(questions: ["Q1", "Q2", "Q3"], router: router)

        sut.start()
        router.routeToQuestionAnswerCallback("A1")
        router.routeToQuestionAnswerCallback("A2")

        XCTAssertEqual(router.routeToQuestionQuestions, ["Q1", "Q2", "Q3"])
    }

    func test_startAndAnswerFirstQuestion_withOneQuestion_notRouteToAnotherQuestion() {
        sut = Flow(questions: ["Q1"], router: router)

        sut.start()
        router.routeToQuestionAnswerCallback("A1")

        XCTAssertEqual(router.routeToQuestionQuestions, ["Q1"])
    }

    func test_start_withNoQuestions_routeToResult() throws {
        sut = Flow(questions: [], router: router)

        sut.start()

        let result = try XCTUnwrap(router.routeToResultResult)
        XCTAssertEqual(result, [:])
    }

    func test_start_withOneQuestions_notRouteToResult() {
        sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertNil(router.routeToResultResult)
    }

    func test_startAndAnswerFirstQuestion_withTwoQuestions_notRouteToResult() {
        sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        router.routeToQuestionAnswerCallback("A1")

        XCTAssertNil(router.routeToResultResult)
    }

    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResult() throws {
        sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        router.routeToQuestionAnswerCallback("A1")
        router.routeToQuestionAnswerCallback("A2")

        let result = try XCTUnwrap(router.routeToResultResult)
        XCTAssertEqual(result, ["Q1": "A1", "Q2": "A2"])
    }

}
