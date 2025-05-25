//
//  BankAppTests.swift
//  BankAppTests
//
//  Created by Team on 25.05.25.
//

import XCTest
import SQLite
@testable import BankApp

class BankAppTests: XCTestCase {
    
    // MARK: - ViewController Tests
    
    func testViewControllerInitialization() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController
        
        XCTAssertNotNil(viewController)
        viewController?.loadViewIfNeeded()
        
        XCTAssertNotNil(viewController?.usernameField)
        XCTAssertNotNil(viewController?.passwordField)
        XCTAssertNotNil(viewController?.errorLabel)
    }
    
    func testEmptyCredentialsLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
        viewController.loadViewIfNeeded()
        
        viewController.usernameField.text = ""
        viewController.passwordField.text = ""
        viewController.tryLogin(self)
        
        XCTAssertEqual(viewController.errorLabel.text, "invalid username or password")
    }
    
    // MARK: - ViewControllerMenu Tests
    
    func testMenuViewControllerUserId() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC = storyboard.instantiateViewController(identifier: "ViewControllerMenu") as! ViewControllerMenu
        
        let testUserId: Int64 = 123
        menuVC.receivedUserId = testUserId
        
        XCTAssertEqual(menuVC.receivedUserId, testUserId)
    }
    
    // MARK: - ViewControllerConverter Tests
    
    func testCurrencyConversionModel() {
        let testRates = ["USD": 1.0, "EUR": 0.85, "RUB": 75.0]
        let conversion = ViewControllerConverter.CurrencyConversion(rates: testRates)
        
        XCTAssertEqual(conversion.rates["USD"], 1.0)
        XCTAssertEqual(conversion.rates["EUR"], 0.85)
        XCTAssertEqual(conversion.rates["RUB"], 75.0)
    }
    
    func testConverterInitialization() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let converterVC = storyboard.instantiateViewController(identifier: "converter") as? ViewControllerConverter
        converterVC?.loadViewIfNeeded()
        
        XCTAssertNotNil(converterVC?.inputCurrency)
        XCTAssertNotNil(converterVC?.outputCurrency)
        XCTAssertNotNil(converterVC?.inputField)
        XCTAssertNotNil(converterVC?.outputField)
    }
    
    // MARK: - TableView Cells Tests
    
    func testAccountsCellNib() {
        let nib = accountsCell.nib()
        XCTAssertNotNil(nib)
        
        let cell = nib.instantiate(withOwner: nil, options: nil).first as? accountsCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(accountsCell.identifier, "accountsCell")
    }
    
    func testAccountDataCellNib() {
        let nib = acountDataCell.nib()
        XCTAssertNotNil(nib)
        
        let cell = nib.instantiate(withOwner: nil, options: nil).first as? acountDataCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(acountDataCell.identifier, "acountDataCell")
    }
    
    // MARK: - Database Helper Tests
    
    func testDatabaseCopyFunction() {
        let tempDir = NSTemporaryDirectory()
        let sourcePath = tempDir + "test_source.sqlite3"
        let testData = "test".data(using: .utf8)!
        
        // Create test source file
        FileManager.default.createFile(atPath: sourcePath, contents: testData, attributes: nil)
        
        // Test copy function
        let result = copyDatabaseIfNeeded(sourcePath: sourcePath)
        
        // Cleanup
        try? FileManager.default.removeItem(atPath: sourcePath)
        
        XCTAssertTrue(result || FileManager.default.fileExists(atPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/db.sqlite3"))
    }
}