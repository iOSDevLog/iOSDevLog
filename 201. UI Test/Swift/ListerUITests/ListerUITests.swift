//
//  ListerUITests.swift
//  ListerUITests
//
//  Created by iosdevlog on 15/11/21.
//  Copyright © 2015年 Apple Inc. All rights reserved.
//

import XCTest

class ListerUITests: XCTestCase {
        
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
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAddOneItem() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Groceries"].tap()
        tablesQuery.textFields["Add Item"].tap()
        
        let textField = tablesQuery.childrenMatchingType(.Cell).elementBoundByIndex(0).childrenMatchingType(.TextField).element
        
        textField.typeText("Coocies")
        app.typeText("\r")
        
        let button = tablesQuery.buttons["Coocies"]
        
        XCTAssertEqual(button.value as? String, "0")
        button.tap()
        XCTAssertEqual(button.value as? String, "1")
        
        
        app.navigationBars.matchingIdentifier("Groceries").buttons["Edit"].tap()
        tablesQuery.cells.containingType(.Button, identifier:"Coocies").buttons["Delete "].tap()
        tablesQuery.buttons["Delete"].tap()
    }
    
    func testChangeColor() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Today"].tap()
        
        let todayNavigationBarsQuery = app.navigationBars.matchingIdentifier("Today")
        todayNavigationBarsQuery.buttons["Edit"].tap()
        tablesQuery.buttons["red"].tap()
        tablesQuery.buttons["orange"].tap()
        tablesQuery.buttons["yellow"].tap()
        tablesQuery.buttons["green"].tap()
        tablesQuery.buttons["blue"].tap()
        tablesQuery.buttons["gray"].tap()
        todayNavigationBarsQuery.buttons["Done"].tap()
        
    }
    
    func testAddTwoItems() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Groceries"].tap()
        
        let textField = tablesQuery.textFields["Add Item"]
        textField.tap()
        textField.typeText("Coocies")
        app.typeText("\r")
        
        let button = tablesQuery.buttons["Coocies"]
        
        XCTAssertEqual(button.value as? String, "0")
        button.tap()
        XCTAssertEqual(button.value as? String, "1")
        
        textField.tap()
        textField.typeText("Coocies")
        app.typeText("\r")
        
        let button2 = tablesQuery.descendantsMatchingType(.Button).matchingIdentifier("Coocies").elementBoundByIndex(0)
        
        XCTAssertEqual(button2.value as? String, "0")
        button2.tap()
        XCTAssertEqual(button2.value as? String, "1")
    }
    
}
