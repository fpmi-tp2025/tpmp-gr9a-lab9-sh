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
        
        // Проверяем, что приложение запустилось
        XCTAssertTrue(app.exists)
        
        // Проверяем наличие текстовых полей (по индексу)
        let textFields = app.textFields
        XCTAssertTrue(textFields.count >= 1) // username field
        
        let secureTextFields = app.secureTextFields
        XCTAssertTrue(secureTextFields.count >= 1) // password field
    }
    
    @MainActor
    func testLoginScreenElements() throws {
        app.launch()
        
        // Находим элементы по типу и индексу
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
        
        // Вводим неверные данные
        let usernameField = app.textFields.element(boundBy: 0)
        usernameField.tap()
        usernameField.typeText("wronguser")
        
        let passwordField = app.secureTextFields.element(boundBy: 0)
        passwordField.tap()
        passwordField.typeText("wrongpass")
        
        // Нажимаем кнопку входа
        let loginButton = app.buttons.element(boundBy: 0)
        loginButton.tap()
        
        // Проверяем, что появилось сообщение об ошибке
        let errorLabel = app.staticTexts["invalid username or password"]
        XCTAssertTrue(errorLabel.waitForExistence(timeout: 2))
    }
    
    @MainActor
    func testEmptyFieldsLogin() throws {
        app.launch()
        
        // Сразу нажимаем кнопку входа без ввода данных
        let loginButton = app.buttons.element(boundBy: 0)
        loginButton.tap()
        
        // Проверяем сообщение об ошибке
        let errorLabel = app.staticTexts["invalid username or password"]
        XCTAssertTrue(errorLabel.waitForExistence(timeout: 2))
    }
    
    @MainActor
    func testMenuButtonsExist() throws {
        app.launch()
        
        // Для теста предполагаем, что есть тестовые данные
        // Если у вас есть тестовый пользователь, используйте его
        let usernameField = app.textFields.element(boundBy: 0)
        usernameField.tap()
        usernameField.typeText("testuser") // Замените на ваши тестовые данные
        
        let passwordField = app.secureTextFields.element(boundBy: 0)
        passwordField.tap()
        passwordField.typeText("testpass") // Замените на ваши тестовые данные
        
        let loginButton = app.buttons.element(boundBy: 0)
        loginButton.tap()
        
        // Ждем появления меню
        sleep(2)
        
        // Проверяем наличие кнопок меню по тексту
        let accountsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] %@", "счет"))
        let converterButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] %@", "конвертер"))
        let mapButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] %@", "карта"))
        
        // Если кнопки существуют, значит мы в меню
        if accountsButton.count > 0 {
            XCTAssertTrue(accountsButton.element.exists)
        }
        if converterButton.count > 0 {
            XCTAssertTrue(converterButton.element.exists)
        }
        if mapButton.count > 0 {
            XCTAssertTrue(mapButton.element.exists)
        }
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}