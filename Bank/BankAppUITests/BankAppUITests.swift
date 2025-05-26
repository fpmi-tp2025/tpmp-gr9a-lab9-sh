//
//  BankAppUITests.swift
//  BankAppUITests
//
//  Created by Ivan Hontarau on 25.05.25.
//

import XCTest

final class BankAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    @MainActor
    func testAppLaunch() throws {
        app.launch()
        
        XCTAssertTrue(app.exists)
        
        let textFields = app.textFields
        XCTAssertTrue(textFields.count >= 1) // username field
        
        let secureTextFields = app.secureTextFields
        XCTAssertTrue(secureTextFields.count >= 1) // password field
    }
    
    @MainActor
    func testLoginScreenElements() throws {
        app.launch()
        
        let usernameField = app.textFields.element(boundBy: 0)
        let passwordField = app.secureTextFields.element(boundBy: 0)
        let loginButton = app.buttons.element(boundBy: 0)
        
        XCTAssertTrue(usernameField.exists)
        XCTAssertTrue(passwordField.exists)
        XCTAssertTrue(loginButton.exists)
    }
    
    @MainActor
    func testInvalidLogin() throws {
        app.launch()
        
        let usernameField = app.textFields.element(boundBy: 0)
        usernameField.tap()
        usernameField.typeText("wronguser")
        
        let passwordField = app.secureTextFields.element(boundBy: 0)
        passwordField.tap()
        passwordField.typeText("wrongpass")
        
    
    }
    
    @MainActor
    func testEmptyFieldsLogin() throws {
        app.launch()
        
        let loginButton = app.buttons.element(boundBy: 0)
        loginButton.tap()
        
        let errorLabel = app.staticTexts["invalid username or password"]
        XCTAssertTrue(errorLabel.waitForExistence(timeout: 2))
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
