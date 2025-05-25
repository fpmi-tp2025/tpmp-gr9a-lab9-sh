//
//  BankAppUITests.swift
//  BankAppUITests
//
//  Created by Team on 25.05.25.
//

import XCTest

class BankAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Login Flow Tests
    
    func testLoginScreenElements() {
        // Check if login screen elements exist
        XCTAssertTrue(app.textFields["usernameField"].exists)
        XCTAssertTrue(app.secureTextFields["passwordField"].exists)
        XCTAssertTrue(app.buttons["Login"].exists)
        XCTAssertTrue(app.staticTexts["errorLabel"].exists)
    }
    
    func testInvalidLoginFlow() {
        // Enter invalid credentials
        let usernameField = app.textFields["usernameField"]
        usernameField.tap()
        usernameField.typeText("invaliduser")
        
        let passwordField = app.secureTextFields["passwordField"]
        passwordField.tap()
        passwordField.typeText("wrongpassword")
        
        // Tap login button
        app.buttons["Login"].tap()
        
        // Check error message appears
        let errorLabel = app.staticTexts["errorLabel"]
        XCTAssertTrue(errorLabel.exists)
        XCTAssertEqual(errorLabel.label, "invalid username or password")
    }
    
    // MARK: - Menu Navigation Tests
    
    func testMenuNavigation() {
        // First login with valid credentials (assuming test data exists)
        loginWithTestCredentials()
        
        // Check menu buttons exist
        XCTAssertTrue(app.buttons["Мои счета"].exists)
        XCTAssertTrue(app.buttons["Конвертер валют"].exists)
        XCTAssertTrue(app.buttons["Карта отделений"].exists)
        XCTAssertTrue(app.buttons["Выход"].exists)
    }
    
    func testAccountsListNavigation() {
        loginWithTestCredentials()
        
        // Navigate to accounts
        app.buttons["Мои счета"].tap()
        
        // Check if table view exists
        XCTAssertTrue(app.tables.element.exists)
        
        // Check back button
        XCTAssertTrue(app.buttons["Назад"].exists)
        
        // Go back
        app.buttons["Назад"].tap()
        
        // Should be back at menu
        XCTAssertTrue(app.buttons["Мои счета"].exists)
    }
    
    func testConverterNavigation() {
        loginWithTestCredentials()
        
        // Navigate to converter
        app.buttons["Конвертер валют"].tap()
        
        // Check converter elements
        XCTAssertTrue(app.textFields["inputField"].exists)
        XCTAssertTrue(app.textFields["outputField"].exists)
        XCTAssertTrue(app.buttons["Конвертировать"].exists)
        
        // Test conversion
        app.textFields["inputField"].tap()
        app.textFields["inputField"].typeText("100")
        app.buttons["Конвертировать"].tap()
        
        // Wait for result
        let outputField = app.textFields["outputField"]
        XCTAssertTrue(outputField.waitForExistence(timeout: 5))
    }
    
    // MARK: - Helper Methods
    
    private func loginWithTestCredentials() {
        // This assumes you have test data in your database
        // Adjust credentials based on your test data
        let usernameField = app.textFields["usernameField"]
        usernameField.tap()
        usernameField.typeText("testuser")
        
        let passwordField = app.secureTextFields["passwordField"]
        passwordField.tap()
        passwordField.typeText("testpass")
        
        app.buttons["Login"].tap()
        
        // Wait for menu to appear
        XCTAssertTrue(app.buttons["Мои счета"].waitForExistence(timeout: 2))
    }
}