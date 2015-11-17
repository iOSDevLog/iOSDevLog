//
//  ReactivePlaygroundUITests.swift
//  ReactivePlaygroundUITests
//
//  Created by iosdevlog on 15/11/17.
//  Copyright © 2015年 jiaxianhua. All rights reserved.
//

import XCTest

class ReactivePlaygroundUITests: XCTestCase {
        
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
    
    func testLoginWrong() {
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        usernameTextField.tap()
        usernameTextField.typeText("hello")
        
        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.tap()
        passwordTextField.typeText("world")
        
        XCTAssertEqual(app.navigationBars.element.identifier, "Kitten!")
        
    }
    
    func testAccess() {
        XCUIDevice.sharedDevice().orientation = .Portrait
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        
        let app = XCUIApplication()
        app.textFields["User"].typeText("hello")
        
        let passTextField = app.textFields["pass"]
        passTextField.tap()
        passTextField.tap()
        passTextField.typeText("world")
        app.buttons["Sign In"].tap()
        
    }
    
    func testLoginRight() {
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        usernameTextField.tap()
        usernameTextField.typeText("user")
        
        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("password")
        app.buttons["Sign In"].tap()
        
        XCTAssertEqual(app.navigationBars.element.identifier, "Reactive Sign In")
    }
    
}
