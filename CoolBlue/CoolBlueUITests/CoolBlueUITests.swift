//
//  CoolBlueUITests.swift
//  CoolBlueUITests
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import XCTest

class CoolBlueUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitialState() {
        let app = XCUIApplication()
        let table = app.tables["SearchTable"]
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(table.cells.count,0, "There should be no cells")
    }

    func testEnteringSearchText() {

        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element.tap()
        app.searchFields.element.tap()
        app.searchFields.element.typeText("iPhone")
        sleep(5)
        let table = app.tables["SearchTable"]
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertGreaterThanOrEqual(table.cells.count,1,"There should be more than one cell")
    }

    func testSelectProductToView() {
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element.tap()
        app.searchFields.element.tap()
        app.searchFields.element.typeText("iPhone")
        app.scrollViews.otherElements.staticTexts["Sales price :1079.0"].tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testDetailedProductInfo() {

        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element.tap()
        app.searchFields.element.tap()
        app.searchFields.element.typeText("Testing")
        app.scrollViews.otherElements.containing(.staticText, identifier:"Apple iPhone X 64GB Space Gray").children(matching: .textView).element.tap()
        app.buttons["Back"].tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
